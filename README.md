# hubot-search

[![Build Status](https://travis-ci.org/ClaudeBot/hubot-search.svg)](https://travis-ci.org/ClaudeBot/hubot-search)
[![devDependency Status](https://david-dm.org/ClaudeBot/hubot-search/dev-status.svg)](https://david-dm.org/ClaudeBot/hubot-search#info=devDependencies)

An extendable Hubot script for querying several search engine services: [Google Custom Search][gcse], and [Bing Search API][bse].

See [`src/search.coffee`](src/search.coffee) for full documentation.


## Installation via NPM

1. Install the **hubot-search** module as a Hubot dependency by running:

    ```
    npm install --save hubot-search
    ```

2. Enable the module by adding the **hubot-search** entry to your `external-scripts.json` file:

    ```json
    [
        "hubot-search"
    ]
    ```

3. Run your bot and see below for available config / commands


## Configuration

Variable | Default | Description
--- | --- | ---
`GOOGLE_API_KEY` | N/A | A unique developer [API key](https://developers.google.com/custom-search/json-api/v1/introduction#identify_your_application_to_google_with_api_key) is required to use Google's Custom Search API
`GOOGLE_CUSTOM_SEARCH` | N/A | The [Google Custom Search][gcse] engine [identifier](https://cse.google.com/cse/all) (the `cx` portion of the custom search engine URL)
`BING_SEARCH_API_KEY` | N/A | The [primary account key](https://datamarket.azure.com/dataset/explore/bing/searchweb) for performing Bing Search API queries

### Google Custom Search

The Google Custom Search command listener will not be registered if neither `GOOGLE_API_KEY` nor `GOOGLE_CUSTOM_SEARCH` environment variables are defined.

#### Create Google API Key

1. Create a new API key: https://console.developers.google.com/apis/credentials
2. Select _"Server key"_ for the type. You may be required to create a new project, just follow the instructions
3. Return to the _"Overview"_, and locate _"Custom Search API"_
4. Enable _"Custom Search API"_

#### Create Google Custom Search Engine

1. Create a new Google Custom Search engine: https://cse.google.com/cse/create/new
2. To search all websites, enter any web URL in (1), and complete the creation
3. Edit your newly created search engine
4. Set _"Sites to search"_ to _"Search the entire web but emphasize included sites"_, and delete the sites you have previously added
5. Save, and export the variables:

    ```bash
    export GOOGLE_API_KEY="API KEY HERE"
    export GOOGLE_CUSTOM_SEARCH="ENGINE ID HERE"
    ```

### Bing Search API

The Bing Search API command listener will not be registered if `BING_SEARCH_API_KEY` is not defined.

1. Visit https://datamarket.azure.com/dataset/bing/searchweb
2. Subscribe for a _"Bing Search API – Web Results Only"_ package / plan (free works fine)
3. [Obtain][bsekey] the primary account key (located at the top of the page under _"Show"_)
4. Export the API key:

    ```bash
    export BING_SEARCH_API_KEY="API KEY HERE"
    ```


## Commands

Command | Listener ID | Description
--- | --- | ---
hubot `<search|google>` `query` | `search.google` | Queries Google Custom Search for `query`, and returns the first 5 results
hubot bing `query` | `search.bing` | Queries Bing Search API for `query`, and returns the first 5 results


## Sample Interaction

```
user1>> hubot search Elon Musk
hubot>> 1. Elon Musk - Wikipedia, the free encyclopedia: Elon Reeve Musk is a South African-born Canadian-American business magnate
, engineer, and investor. He is the founder, CEO and CTO of SpaceX; ... (https://en.wikipedia.org/wiki/Elon_Musk)
hubot>> ...
```


[gcse]: https://cse.google.com/
[bse]: https://datamarket.azure.com/dataset/bing/searchweb
[bsekey]: https://datamarket.azure.com/dataset/explore/bing/searchweb