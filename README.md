# hubot-search

[![Build Status](https://travis-ci.org/ClaudeBot/hubot-search.svg)](https://travis-ci.org/ClaudeBot/hubot-search)
[![devDependency Status](https://david-dm.org/ClaudeBot/hubot-search/dev-status.svg)](https://david-dm.org/ClaudeBot/hubot-search#info=devDependencies)

An extendable Hubot script for querying [Google Custom Search](https://cse.google.com/).

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
`GOOGLE_CUSTOM_SEARCH` | N/A | A Google Custom Search engine [identifier](https://cse.google.com/cse/all) (the `cx` portion of the custom search engine URL)

### Google Custom Search

1. Create a new Google Custom Search engine: https://cse.google.com/cse/create/new
2. To search all websites, enter any web URL in (1), and complete the creation
3. Edit your newly created search engine
4. Set _"Sites to search"_ to _"Search the entire web but emphasize included sites"_, and delete the sites you have previously added
5. Save


## Commands

Command | Listener ID | Description
--- | --- | ---
hubot `<search|google>` `query` | `search.google` | Queries Google Custom Search for `query`, and returns the first 5 results


## Sample Interaction

```
user1>> hubot search Elon Musk
hubot>> 1. Elon Musk - Wikipedia, the free encyclopedia: Elon Reeve Musk is a South African-born Canadian-American business magnate
, engineer, and investor. He is the founder, CEO and CTO of SpaceX; ... (https://en.wikipedia.org/wiki/Elon_Musk)
hubot>> ...
```
