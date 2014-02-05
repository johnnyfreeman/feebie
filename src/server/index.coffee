###
HTTP Server for Fee Finder
###

# load modules
api = require './api'
app = require './app'
http = require 'http'
db = require 'mongoose'
require('node-monkey').start()

# create servers
apiServer = http.createServer api
appServer = http.createServer app

# exports
# if servers need to be exported, extract them to their own files in ./servers/

# connect to db when api server starts
apiServer.once 'listening', ->
  db.connect 'localhost', 'feebie'
  # db log messages
  db.connection.on 'error', console.error.bind(console, 'Failed connecting to MongoDB:')
  db.connection.once 'open', console.log.bind(console, 'Connected to MongoDB.')

apiServer.listen 81
appServer.listen 80