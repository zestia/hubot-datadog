chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'datadog', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    process.env.HUBOT_DATADOG_APIKEY = sinon.spy()
    process.env.HUBOT_DATADOG_APPKEY = sinon.spy()

    require('../src/datadog')(@robot)

  it 'registers the graph me responder', ->
    expect(@robot.respond).to.have.been.calledWith(/graph( me)? -(\d+)([smhdwMy]) (.*)/i)

  it 'registers the metric search responser', ->
    expect(@robot.respond).to.have.been.calledWith(/metric(s)? search (.*)/i)
