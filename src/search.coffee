# Description
#   Universal Search Engine
#
#   Currently supports:
#       - Google Custom Search
#       - Bing Search API
#
# Configuration:
#   GOOGLE_API_KEY
#   GOOGLE_CUSTOM_SEARCH
#   BING_SEARCH_API_KEY
#
# Commands:
#   hubot <search|google> <query> - Queries Google Custom Search for <query>, and returns the first 5 results
#   hubot bing <query> - Queries Bing Search API for <query>, and returns the first 5 results
#
# Author:
#   MrSaints

GOOGLE_API_KEY = process.env.GOOGLE_API_KEY
GOOGLE_CUSTOM_SEARCH = process.env.GOOGLE_CUSTOM_SEARCH
BING_SEARCH_API_KEY = process.env.BING_SEARCH_API_KEY

DEF_SERVER_ERROR = "I'm unable to process your request at this time due to a server error. Please try again later."

class ISearch
    constructor: (@robot) ->

    search: (query, cb) ->
        if query.length < 1
            cb "Please provide a valid search query."

        @_search query, (err, httpRes, body) =>
            @robot.logger.debug "hubot-search: #{body}"
            if err or (httpRes.statusCode isnt 200 and err = "server did not return HTTP 200")
                @robot.logger.error "hubot-search: #{err} (#{httpRes.statusCode})"
            else
                try
                    data = JSON.parse body
                    if not @_hasResults(data)
                        cb "No results were found using search query: \"#{query}\". Please try a different query."
                    else
                        cb @_format(data)
                    return
                catch error
                    @robot.logger.error "hubot-search: #{error}"
            cb DEF_SERVER_ERROR

    _search: (query, cb) ->
        @robot.logger.error "_search is not implemented"

    _hasResults: (data) ->
        @robot.logger.error "_hasResults is not implemented"

    _format: (data) ->
        @robot.logger.error "_format is not implemented"

class GoogleSearch extends ISearch
    _search: (query, cb) ->
        @robot.logger.info "hubot-search: using Google Custom Search"
        params =
            key: GOOGLE_API_KEY
            cx: GOOGLE_CUSTOM_SEARCH
            num: 5
            q: query
        @robot.http("https://www.googleapis.com/customsearch/v1")
            .header("content-type", "application/json")
            .query(params)
            .get() cb

    _hasResults: (data) ->
        data.searchInformation.totalResults > 0

    _format: (data) ->
        results = ""
        for result, i in data.items
            results += "#{i+1}. #{result.title}: #{result.snippet} (#{result.link})\n"
        results += "About #{data.searchInformation.formattedTotalResults} results (#{data.searchInformation.formattedSearchTime} seconds)."
        results

class BingSearch extends ISearch
    _search: (query, cb) ->
        @robot.logger.info "hubot-search: using Bing Search API (Web Results Only)"
        opts =
            auth: "#{BING_SEARCH_API_KEY}:#{BING_SEARCH_API_KEY}"
        params =
            $format: "json"
            $top: 5
            Query: "'#{query}'"
        # @robot.logger.debug "hubot-search: Bing Search API params : #{params}"
        @robot.http("https://api.datamarket.azure.com/Bing/SearchWeb/v1/Web", opts)
            .header("content-type", "application/json")
            .query(params)
            .get() cb

    _hasResults: (data) ->
        data.d?.results?.length > 0

    _format: (data) ->
        results = ""
        for result, i in data.d.results
            results += "#{i+1}. #{result.Title}: #{result.Description} (#{result.Url})\n"
        results

module.exports = (robot) ->
    # Listener: Google Custom Search
    if GOOGLE_API_KEY? and GOOGLE_CUSTOM_SEARCH?
        google = new GoogleSearch robot
        robot.respond /(search|google) (.+)/i, id: "search.google", (res) =>
            q = res.match[2]
            google.search q, (results) =>
                res.send results
    else
        robot.logger.warning "hubot-search: Missing GOOGLE_API_KEY or GOOGLE_CUSTOM_SEARCH in environment. Google Custom Search will not be available."

    # Listener: Bing Search API
    if BING_SEARCH_API_KEY?
        bing = new BingSearch robot
        robot.respond /bing (.+)/i, id: "search.bing", (res) =>
            q = res.match[1]
            bing.search q, (results) =>
                res.send results
    else
        robot.logger.warning "hubot-search: Missing BING_SEARCH_API_KEY in environment. Bing Search API will not be available."
