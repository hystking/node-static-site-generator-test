gulp = require "gulp"
$ = do require "gulp-load-plugins"
config = require "../config"
colors = require "colors"

browserify = require "browserify"
through2 = require "through2"

coffeeify = (opt) ->
  through2.obj (file, enc, next) ->
    browserify opt
      .add file.path
      .bundle (err, res) ->
        file.contents = res if res
        next err, file

gulp.task "coffeeify", ->
  gulp
    .src "#{config.src}/coffee/index.coffee"
    .pipe $.if config.isDebug, $.sourcemaps.init()
    .pipe $.plumber
      errorHandler: (err) ->
        console.log colors.red "[ERROR]", err.annotated or err.message or err
        @emit "end"
    .pipe coffeeify
      extensions: [".coffee", ".json"]
      transform: ["coffeeify"]
      debug: config.isDebug
    .pipe $.if not config.isDebug, $.uglify
      preserveComments: "some"
    .pipe $.if config.isDebug, $.sourcemaps.write()
    .pipe $.rename
      extname: ".js"
    .pipe gulp.dest "#{config.dest}/js"
    .pipe $.livereload()
