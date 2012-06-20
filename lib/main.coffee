{readFileSync} = require 'fs'
{join} = require 'path'
{buildParser} = require 'pegjs'

standard = buildParser String readFileSync join __dirname, 'standard.pegjs'
simple = buildParser String readFileSync join __dirname, 'simple.pegjs'

module.exports =
  parse: (command) -> standard.parse command
  simple: (command) -> simple.parse command