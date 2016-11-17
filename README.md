# hubot-search

[![Build Status](https://travis-ci.org/ClaudeBot/hubot-search.svg)](https://travis-ci.org/ClaudeBot/hubot-search)
[![devDependency Status](https://david-dm.org/ClaudeBot/hubot-search/dev-status.svg)](https://david-dm.org/ClaudeBot/hubot-search#info=devDependencies)

An extendable Hubot script for querying several search engine services: [Google Custom Search][googlesearch], [Azure Marketplace - Bing Search API v2][azurebing], and [Microsoft Cognitive Services - Bing Search API v5][cognitivebing].

See [`src/search.coffee`](src/search.coffee) for full documentation.

---

**Attention:** Azure Marketplace _"Bing Search"_ and _"Bing Search Web Results Only"_ API (v2) [offerings][azurebing] will end of life on **December 15, 2016**.

Currently by default, this script will use [Azure Marketplace - Bing Search API v2][azurebing], and the `BING_SEARCH_API_KEY` environment variable should be the [v2 key][azurebingkey] (from Azure Marketplace).

Nevertheless, we strongly recommend that you use [Microsoft Cognitive Services - Bing Search API v5][cognitivebing] by setting `USE_BING_V5` to `true` in the environment that is using this script, and ensuring the `BING_SEARCH_API_KEY` is the [v5 key][cognitivebingkey] (from Cognitive Services).

`USE_BING_V5` will not be necessary by 2017 when the v2 API is deprecated at end of life.


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
`GOOGLE_CUSTOM_SEARCH` | N/A | The [Google Custom Search][googlesearch] engine [identifier](https://cse.google.com/cse/all) (the `cx` portion of the custom search engine URL)
`BING_SEARCH_API_KEY` | N/A | The [API key][cognitivebingkey] for performing [Bing Search API][cognitivebing] queries
`MAX_SEARCH_RESULTS` | 5 | The number of search results to return

### [Google Custom Search][googlesearch]

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

### [Azure Marketplace - Bing Search API v2][azurebing]

The Bing Search API command listener will not be registered if `BING_SEARCH_API_KEY` is not defined.

1. Visit https://datamarket.azure.com/dataset/bing/searchweb
2. Subscribe for a _"Bing Search API – Web Results Only"_ package / plan (free works fine)
3. [Obtain][azurebingkey] the primary account key (located at the top of the page under _"Show"_)
4. Export the API key:

    ```bash
    export BING_SEARCH_API_KEY="API KEY HERE"
    ```

### [Microsoft Cognitive Services - Bing Search API v5][azurebing]

The Bing Search API command listener will not be registered if `BING_SEARCH_API_KEY` is not defined.

1. Visit https://www.microsoft.com/cognitive-services/en-us/subscriptions?productId=/products/56ec2de6bca1df083495c610
2. Subscribe for a _"Bing Web Search"_ package / plan (free works fine)
3. [Obtain][cognitivebingkey] the API key (located in the _"Keys"_ column; click _"Show"_)
4. Export the API key:

    ```bash
    export BING_SEARCH_API_KEY="API KEY HERE"
    export USE_BING_V5="true"
    ```


## Commands

Command | Listener ID | Description
--- | --- | ---
hubot `<search|google>` `query` | `search.google` | Queries Google Custom Search for `query`, and returns the first `MAX_SEARCH_RESULTS` results
hubot bing `query` | `search.bing` | Queries Bing Search API for `query`, and returns the first `MAX_SEARCH_RESULTS` results


## Sample Interaction

```
user1>> hubot search Elon Musk
hubot>> 1. Elon Musk - Wikipedia, the free encyclopedia: Elon Reeve Musk is a South African-born Canadian-American business magnate
, engineer, and investor. He is the founder, CEO and CTO of SpaceX; ... (https://en.wikipedia.org/wiki/Elon_Musk)
hubot>> ...
```


[googlesearch]: https://cse.google.com/
[azurebing]: https://datamarket.azure.com/dataset/bing/searchweb
[azurebingkey]: https://datamarket.azure.com/dataset/explore/bing/searchweb
[cognitivebing]: https://azure.microsoft.com/en-gb/services/cognitive-services/search/
[cognitivebingkey]: https://www.microsoft.com/cognitive-services/en-US/subscriptions
