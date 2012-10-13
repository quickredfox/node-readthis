#!/usr/bin/env coffee

###

# READTHIS

Here's how it works: 

## Install

    npm install -g readthis

## Usage

To read a bunch of files to dump to stdout:

    readthis ./some/glob/patterns/**.coffee anything.md ../bleh.js ~/code/somethingelse.js 

To read a bunch of files to dump in one file:

    readthis ./some/glob/patterns/**.coffee anything.md ../bleh.js ~/code/somethingelse.js -o README.md
    
## Hint

In all your .coffee's and .js'es, leave yourself notes using inline comments, and use pure markdown to document your code in block comments. 

###
fs      = require 'fs'
path    = require 'path'
argv    = require("optimist").argv
falafel = require 'falafel'
coffee  = require 'coffee-script'
files   = argv._
out     = argv.o||argv.output
all     = []

unpad = ( string )->
  lines = []
  string.split( "\n" ).reduce ( keep, line )->
    keep = true if !keep and /^(\s+?[^\s])|[^\s]/.test line
    lines.push( line ) if keep
    return keep
  , false
  while /^\s/.test lines[0]
    lines = lines.map ( line )-> line.slice( 1 )
  return lines.join("\n")
 

out = if out then fs.createWriteStream( out ) else {
  write: ( data )-> process.stdout.write( data )
  end: ->
}

files.forEach ( file )->
  try 
    source = fs.readFileSync file, 'utf8'
  catch ignore then return
  if !(/\.(coffee|js)$/.test( file ))
    return all.push( source )
  if /\.coffee$/.test file
    source = coffee.compile source , filename: file, bare: true
  comments = []
  falafel source, {comment: true}, ( ingredient )-> 
    if ingredient.comments 
      ingredient.comments.forEach ( comment )-> 
        if comment.type is 'Block'
          comments.push unpad comment.value 
  all.push comments.join "\n"
  
out.write all.join("\n")
