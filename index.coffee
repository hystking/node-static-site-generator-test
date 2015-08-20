process.env.NODE_ENV = "production"

require "gulp"
require "./gulpfile"
runSequence = require "run-sequence"

runSequence ["build"]
