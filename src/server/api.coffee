###
Fee Finder API
###

# load modules
express = require 'express'
mongoose = require('mongoose')

# create app
module.exports = app = express()

# allow CORS
app.use (req, res, next) ->
  res.header 'Access-Control-Allow-Origin', '*'
  res.header 'Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS'
  res.header 'Access-Control-Allow-Headers', 'Content-Type, Authorization, Content-Length, X-Requested-With'

  # intercept OPTIONS method
  if 'OPTIONS' == req.method
    res.send 200
  else
    next()

###
Mongoose Models
###
ObjectId = mongoose.Schema.ObjectId

Code = mongoose.model('codes', mongoose.Schema(
  code: String
  description: String
))

Fee = mongoose.model('fees', mongoose.Schema(
  modifier1: String
  modifier2: String
  fac: Boolean
  quantity: Number
  codeId:
    type: ObjectId
    ref: 'Code'
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

# Get a single code
app.get '/code/:code', (req, res) ->
  
  Code.findOne {code: req.params.code}, (err, code) ->
    res.send err if err

    Fee.find {codeId: code._id}, (err, fees) ->
      res.send err if err
      
      code = code.toObject()

      # save fee object
      code['fees'] = fees

      # output
      res.send code