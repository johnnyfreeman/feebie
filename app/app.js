/**
 * HTTP (Node.js) Server for the 2013 Fee Finder
 * ------------------------------------------------------
 * To start/stop this server, go to the /var/www/fee-finder/app 
 * directory on the VO-WEB-DEV server and run this 
 * command:
 * 
 * forever start app.js
 * forever stop app.js
 *
 * @author  Johnny Freeman
 */
var express = require('express'),
    app     = express(),
    server  = require('http').createServer(app),
    io      = require('socket.io').listen(server),
    mongoose = require('mongoose'),
    fs      = require('fs');

// make web server listen on specific port
server.listen(8080);


/**
 * STATIC FILES
 * ----------------------------------------------------
 * Make sure our images, css, and js files can be
 * accessed.
 */
app.use('/assets', express.static(__dirname + '/../public/assets'));



/**
 * MongoDB
 * ----------------------------------------------------
 * Connect to the database
 */
mongoose.connect('localhost', 'fee_finder_2013');

var db = mongoose.connection;

// setup some error/connection reporting
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', console.log.bind(console, 'Successfully connected to MongoDB.'));

// MongoDB requires you to setup a modal 
// to reflect the schema of the database
var Fee = mongoose.model('fees', mongoose.Schema({
    code: String,
    description: String,
    fees: Array
}));



/**
 * ADMIN ROUTES
 * ----------------------------------------------------
 * This is dedicated route that will take a POST
 * request and will notify the users that they 
 * need to refresh their browser.
 */

// Admin page
app.get('/admin', function(req, res)
{
    res.send('admin page');
});

// Admin Edit Form
app.get('/admin/edit/:code', function(req, res)
{
    res.send('editing code...');
});

// Admin utilities
app.post('/admin/edit/:code', function(req, res)
{
    res.send('Success!');

    // update frontend
    io.sockets.emit('model.refresh', {code: req.param('code')});
});

// Browser refresh utility
app.post('/admin/utilities/browser.refresh', function(req, res) {

    var title = req.param('title') || 'Restart Required';
    var message = req.param('message') || 'Fee Finder has been updated and needs to be restarted. However, you may safely finish what you were doing and restart afterwards by pressing <kbd>Ctrl</kbd> + <kbd>F5</kbd>.';

    io.sockets.emit('browser.refresh', {
        title: title, 
        subtitle: subtitle, 
        message: message
    });
});



/**
 * API ROUTES
 * ----------------------------------------------------
 * Here are all of the api routes.
 */

// API Status
app.get('/api', function (req, res) {
    res.send('The Fee Finder API server is up and running. :)');
});

// API Get a single fee
app.get('/api/fee/:code', function(req, res) {
    return Fee.findOne({code: req.params.code}, function (err, fee) {
        if (!err) {
            return res.send(fee);
        } else {
            return console.log(err);
        }
    });
});

// API get all fees
app.get('/api/fees', function(req, res) {
    return Fee.find(function (err, fees) {
        if (!err) {
            return res.send(fees);
        } else {
            return console.log(err);
        }
    });
});



/**
 * FRONTEND ROUTES
 * ----------------------------------------------------
 * Here are all of the public facing routes.
 */

// Main route for our single page app
app.get('/', function(req, res)
{
    fs.readFile('public/index.html', function (err, html)
    {
        if (err) 
        {
            throw err;
        }

        res.send(html.toString('utf8'));
    });
});

app.get('/:code', function(req, res)
{
    fs.readFile('public/index.html', function (err, html)
    {
        if (err) 
        {
            throw err;
        }

        res.send(html.toString('utf8'));
    });
});