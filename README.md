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
