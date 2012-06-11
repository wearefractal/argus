{readFileSync} = require 'fs'
{join} = require 'path'
{buildParser} = require 'pegjs'

safe = buildParser String readFileSync join __dirname, 'safe.pegjs'
#unsafe = buildParser String readFileSync join __dirname, 'unsafe.pegjs'

module.exports =
  #unsafe: (command) ->
  #  unsafe.parse command

  parse: (command) ->
    safe.parse command