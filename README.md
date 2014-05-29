# Hubot Datadog

Query Datadog using Hubot.

## Installation

To use `hubot-datadog` you can add it to your `package.json`:

```json
"dependencies": {
  "hubot": "...",
  "hubot-scripts": "...",
  ...
  "hubot-datadog": "~0.1"
}
```

Then add `hubot-datadog` to your `external-scripts.json`:

```json
[ "hubot-datadog" ]
```

## Usage

Currently you can query graphs for metrics, and search for metrics.

### Generate Metric Graphs

    hubot graph -1d avg:page.response.times{*}
    hubot graph -<amount><unit> <metric>

The amount and unit are the time span you wish to go back by, for example:

  * `-1d` is one day
  * `-2M` is two months
  * `-10m` is ten minutes

The supported units are:

  * `s` seconds
  * `m` minutes
  * `h` hours
  * `d` days
  * `w` weeks
  * `M` months
  * `y` years

### Searching for Metrics

    hubot metric search page
    hubot metric search page.response

## License

Copyright &copy; Zestia, Ltd. See `LICENSE` for more information.
