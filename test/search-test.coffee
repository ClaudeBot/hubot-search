chai = require "chai"
sinon = require "sinon"
chai.use require "sinon-chai"

expect = chai.expect

describe "search", ->
    beforeEach ->
        @robot =
            respond: sinon.spy()
            logger:
                warning: sinon.spy()

        require("../src/search")(@robot)

    it "registers a respond listener", ->
        if GOOGLE_API_KEY? and GOOGLE_CUSTOM_SEARCH?
            expect(@robot.respond).to.have.been.calledWith(/(search|google) (.+)/i)
        if BING_SEARCH_API_KEY?
            expect(@robot.respond).to.have.been.calledWith(/bing (.+)/i)
