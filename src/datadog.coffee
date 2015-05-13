# Description:
#   Query Datadog using Hubot.
#
# Configuration:
#   HUBOT_DATADOG_APIKEY - Your Datadog API key
#   HUBOT_DATADOG_APPKEY - Your Datadog app Key
#
# Commands:
#   hubot graph me -<amount><unit> <metric query> - Queries for a graph snapshot
#   hubot metric search <metric query> - Queries for a list of matching metrics
#
# Author
#   tombell

dog    = require 'dogapi'
moment = require 'moment'

module.exports = (robot) ->
  unless process.env.HUBOT_DATADOG_APIKEY?
    return robot.logger.error "HUBOT_DATADOG_APIKEY env var is not set"

  unless process.env.HUBOT_DATADOG_APPKEY?
    return robot.logger.error "HUBOT_DATADOG_APPKEY env var is not set"

  dog.initialize({
    api_key: process.env.HUBOT_DATADOG_APIKEY
    app_key: process.env.HUBOT_DATADOG_APPKEY
  })

  robot.respond /graph( me)? -(\d+)([smhdwMy]) (.*)/i, (msg) ->
    time = msg.match[2]
    unit = msg.match[3]
    metric = msg.match[4]

    console.log "DEBUG: #{metric}"

    now = moment()
    end = now.unix()
    start = now.subtract(unit, time).unix()

    dog.graph.snapshot metric, start, end, (err, result) ->
      return msg.send "Could not generate the graph snapshot: #{err}" if err?

      setTimeout ->
        msg.send result['snapshot_url']
      , 3000

  robot.respond /metric(s)? search (.*)/i, (msg) ->
    metric = msg.match[2]

    dog.infrastructure.search metric, (err, result) ->
      msg.send "Could not fetch search results: #{err}" if err?

      metrics = result['results']['metrics']
      msg.send "I found the following results:", metrics.join("\n")
