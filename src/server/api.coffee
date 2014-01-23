###
HTTP Server for the Fee Finder API
------------------------------------------------------
To start/stop this server, go to the
/var/www/fee-finder/server directory on the
VO-WEB-DEV server and run this command:

forever start api.js
forever stop api.js

@author  Johnny Freeman
###

express = require('express')
app = express()
server = require('http').createServer(app)
server.listen 81

###
MongoDB Connection
###

mongoose = require('mongoose')
mongoose.connect '192.168.37.31', 'fee_finder_2014'
db = mongoose.connection
db.on 'error', console.error.bind(console, 'Failed connecting to MongoDB:')
db.once 'open', console.log.bind(console, 'Successfully connected to MongoDB.')

###
Mongoose Models
###

Code = mongoose.model('codes', mongoose.Schema(
  code: String
  description: String
))

Fee = mongoose.model('fees', mongoose.Schema(
  modifier1: String
  modifier2: String
  fac: Boolean
  quantity: Number
  codeId: mongoose.Schema.ObjectId # mongo ObjectId
  year: Number
  categoryId: String
  amount: Number
))


###
ROUTES
###

# Status
app.get '/', (req, res) ->
  res.send 'The Fee Finder API server is up and running. :)'

# Get a single fee
app.get '/code/:code', (req, res) ->
  Code.findOne {code: req.params.code}, (err, fee) ->
    unless err
      res.send fee
    else
      res.send err