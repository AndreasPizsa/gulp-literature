literate= require '../'
fs      = require 'fs'
path    = require 'path'
gutil   = require 'gulp-util'
assert  = require 'assert'

createVinylFile = (filepath, contents) ->
  base = path.dirname(filepath)
  return new gutil.File(
    path: filepath
    base: base
    cwd: path.dirname(base)
    contents: if contents instanceof Buffer then contents else new Buffer(contents)
  )

describe 'gulp-literate', ->

  beforeEach ->
    literate= (require '../')()

  it 'extracts code blocks', (done)->
    filename = "#{__dirname}/fixtures/unfenced-code.js.md"
    buffer = new Buffer fs.readFileSync filename
    literate
      .on 'data', (newFile)->
        expected = fs.readFileSync(__dirname + '/expected/unfenced-code.js','utf-8');
        assert.strictEqual expected, newFile.contents.toString 'utf-8'
        return done()
      .write createVinylFile filename, buffer
    return

  it 'creates the correct filename', (done)->
    inputFilename = "#{__dirname}/fixtures/unfenced-code.js.md"
    literate
      .on 'data', (newFile)->
        assert.strictEqual path.dirname(inputFilename),path.dirname(newFile.path)
        assert.strictEqual path.basename(newFile.path),'unfenced-code.js'
        return done()
    .write createVinylFile inputFilename, ''
