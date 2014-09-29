var PLUGIN_NAME, PluginError, gutil, literature, packageJson, path;

literature = require('literature');

gutil = require('gulp-util');

path = require('path');

packageJson = require(__dirname + path.sep + './package.json');

PLUGIN_NAME = packageJson.name;

PluginError = gutil.PluginError;

module.exports = function() {
  var changeExtension, extract, through;
  through = require('through2');
  changeExtension = function(path) {
    return path.replace(/\.(?:lit([^.]+))|(?:\.([^.]+)\.md)$/i, '.$1$2');
  };
  extract = function(file, enc, cb) {
    if (file.isNull()) {
      return cb(null, file);
    }
    if (file.isStream()) {
      return cb(new PluginError(PLUGIN_NAME, 'Streams are not supported!'));
    }
    file.path = changeExtension(file.path);
    file.contents = new Buffer(literature(file.contents.toString('utf-8')));
    return cb(null, file);
  };
  return through.obj(extract);
};
