###
HTTP (Node.js) Server for the 2013 Fee Finder
------------------------------------------------------
To start/stop this server, go to the /var/www/fee-finder
directory on the VO-WEB-DEV server and run this
command:

forever start dist/server/app.js
forever stop dist/server/app.js

@author  Johnny Freeman
###


express = require('express')
app = express()
server = require('http').createServer(app)
# io = require('socket.io').listen(server)
fs = require('fs')
server.listen 80


###
STATIC FILES
###
app.use '/assets', express.static(__dirname + '/../../public/assets')


###
ROUTES
----------------------------------------------------
Here are all of the public facing routes.
###

indexController = (req, res) ->
  fs.readFile 'public/index.html', (err, html) ->
    throw err  if err
    res.send html.toString('utf8')

# Main routes for our single page app
app.get '/', indexController
app.get '/:code', indexController