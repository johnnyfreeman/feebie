###
Fee Finder app
###

# load modules
express = require 'express'
fs = require 'fs'

# create app
module.exports = app = express()

# status files
app.use express.static(__dirname + '/../client')

# index controller
indexController = (req, res) ->
  fs.readFile 'public/client/index.html', (err, html) ->
    throw err  if err
    res.send html.toString('utf8')

# Main routes
app.get '/', indexController
app.get '/:code', indexController