#!/usr/bin/env coffee
fs = require 'fs'
spawn     = require('child_process').spawn
script = "#{__dirname}/../bin/readthis.coffee"
readthis  = spawn script, [script]

expected  = fs.readFileSync "#{__dirname}/../README.md", 'utf8'
got = ''

readthis.stdout.on 'data', (data)->
  got += data

readthis.stdout.on 'end', ()->
  code = if got is expected then 0 else 1
  console.log if code is 1 then "failed!" else "passed!"
  process.exit( code )
