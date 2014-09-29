gulp  = require 'gulp'
gutil = require 'gulp-util'
coffee= require 'gulp-coffee'

gulp.task 'default', ->
  gulp.src './src/gulp-literature.litcoffee'
    .pipe coffee bare:true
      .on 'error', gutil.log
    .pipe gulp.dest './'
