process.env.NODE_ENV = "production"

require "./gulpfile"
runSequence = require "run-sequence"
fs = require "fs"

articles = require "./site-config/articles.json"
runSequence ["serve"]

build = ->
  runSequence ["build"]

addButton.addEventListener "click", ->
  if titleInput.value
    articles.push
      title: titleInput.value
      body: bodyInput.value
    titleInput.value = ""
    bodyInput.value = ""
  fs.writeFile "site-config/articles.json", JSON.stringify articles
  build()
