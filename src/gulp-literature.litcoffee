    literature= require 'literature'
    gutil     = require 'gulp-util'
    path      = require 'path'

    packageJson = require __dirname + path.sep + './package.json'
    PLUGIN_NAME = packageJson.name

    {PluginError} = gutil

    module.exports = ->
      through = require 'through2'
      changeExtension = (path)->
        return path.replace /\.(?:lit([^.]+))|(?:\.([^.]+)\.md)$/i, '.$1$2'

      extract =  (file, enc, cb)->
        return cb(null,file) if file.isNull()
        if file.isStream()
          return cb new PluginError(PLUGIN_NAME, 'Streams are not supported!')

        file.path = changeExtension file.path
        file.contents = new Buffer literature file.contents.toString('utf-8')
        return cb(null,file)

      return through.obj(extract)
