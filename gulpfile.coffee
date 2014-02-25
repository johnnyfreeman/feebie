gulp        = require 'gulp'
gutil       = require 'gulp-util'
coffee      = require 'gulp-coffee'
concat      = require 'gulp-concat'
clean       = require 'gulp-clean'
uglify      = require 'gulp-uglify'
notifier    = require 'node-notifier'
coffeelint  = require 'gulp-coffeelint'
eventStream = require 'event-stream'
bower       = require 'gulp-bower'
stylus      = require 'gulp-stylus'

###
**************************
PATHS
**************************
###

paths =
  app:
    coffee: [
      './src/client/coffee/application.coffee'
      './src/client/coffee/models/code.coffee'
      './src/client/coffee/models/fee.coffee'
      './src/client/coffee/models/notification.coffee'
      './src/client/coffee/models/filter.coffee'
      './src/client/coffee/collections/fees.coffee'
      './src/client/coffee/collections/mrifees.coffee'
      './src/client/coffee/collections/notifications.coffee'
      './src/client/coffee/regions/main.coffee'
      './src/client/coffee/views/code.coffee'
      './src/client/coffee/views/filter.coffee'
      './src/client/coffee/views/fee.coffee'
      './src/client/coffee/views/fees.coffee'
      './src/client/coffee/views/notification.coffee'
      './src/client/coffee/views/notifications.coffee'
      './src/client/coffee/views/notification-info.coffee'
      './src/client/coffee/views/search-form.coffee'
      './src/client/coffee/controller.coffee'
      './src/client/coffee/router.coffee'
    ]
    html: './src/client/index.html'
    images: './src/client/img/**/*'
    stylus: './src/client/styl/**/*.styl'
  vendor:
    js: [
      './bower_components/jquery/jquery.min.js'
      './bower_components/underscore/underscore-min.js'
      './bower_components/backbone/backbone-min.js'
      './bower_components/backbone.marionette/lib/backbone.marionette.min.js'
      './bower_components/jquery-zclip/jquery.zclip.js'
      './bower_components/bootstrap/dist/js/bootstrap.js'
      './bower_components/flat-ui/js/jquery.placeholder.js'
      './bower_components/greensock/src/minified/easing/EasePack.min.js'
      './bower_components/greensock/src/minified/plugins/CSSPlugin.min.js'
      './bower_components/greensock/src/minified/TweenLite.min.js'
      './bower_components/messenger/build/js/messenger.min.js'
      './bower_components/messenger/build/js/messenger-theme-flat.min.js'
      './bower_components/pace/pace.min.js'
    ]
    images: './bower_components/flat-ui/images/**/*'
    fonts: './bower_components/font-awesome/fonts/*'
    css: [
      './bower_components/bootstrap/dist/css/bootstrap.min.css'
      './bower_components/font-awesome/css/font-awesome.min.css'
      './bower_components/flat-ui/css/flat-ui.css'
      './bower_components/messenger/build/css/messenger.css'
      './bower_components/messenger/build/css/messenger-theme-flat.css'
      './bower_components/pace/themes/pace-theme-minimal.css'
    ]
  server:
    coffee: './src/server/**/*.coffee'

###
**************************
CLEAN
**************************
###

# public
gulp.task 'clean:public', ->
  gulp.src('./public')
    .pipe(clean())

# bower
gulp.task 'clean:bower', ->
  gulp.src(['./bower_components'])
    .pipe(clean())

# npm
gulp.task 'clean:npm', ->
  gulp.src('./node_modules')
    .pipe(clean())

# all
gulp.task 'clean', ['clean:public', 'clean:bower', 'clean:npm']


###
**************************
INSTALL
**************************
###

gulp.task 'bower', ['clean:bower'], ->
  bower()


###
**************************
LINT
**************************
###

# lint source files
gulp.task 'lint', ->
  gulp.src(paths.app.coffee)
    .pipe(coffeelint({max_line_length: {value: 170, limitComments: false}}))
    .pipe(coffeelint.reporter()) # Using `coffeelint-stylish` reporter https://npmjs.org/package/coffeelint-stylish


###
**************************
SERVER
**************************
###

# # start http servers
# gulp.task 'start', ['stop'], ->
#   # spawn node process for ./bin/start

# # stop http servers
# gulp.task 'stop', ->
#   server.api.close() if server.api._handle isnt null
#   server.app.close() if server.app._handle isnt null

# # alias for stop and restart
# gulp.task 'restart', ['stop', 'start']

###
**************************
BUILD
**************************
###

# copy app html files
gulp.task 'build:app:html', ->
  gulp.src(paths.app.html).pipe(gulp.dest('./public/client'))

# copy app images
gulp.task 'build:app:images', ['build:vendor:images'], ->
  gulp.src(paths.app.images).pipe(gulp.dest('./public/client/img'))

# copy vendor images files
gulp.task 'build:vendor:images', ->
  gulp.src(paths.vendor.images).pipe(gulp.dest('./public/client/img'))

# copy vendor fonts
gulp.task 'build:vendor:fonts', ->
  gulp.src(paths.vendor.fonts).pipe(gulp.dest('./public/client/fonts'))

# build app css
gulp.task 'build:app:css', ->
  gulp.src(paths.app.stylus)
    .pipe(stylus())
    .pipe(gulp.dest('./public/client/css'))

# build vendor css
gulp.task 'build:vendor:css', ->
  gulp.src(paths.vendor.css)
    .pipe(concat('vendors.css'))
    .pipe(gulp.dest('./public/client/css'))

# build app js
gulp.task 'build:app:js', ->
  gulp.src(paths.app.coffee)
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(concat('app.js'))
    # .pipe(uglify())
    .pipe(gulp.dest('./public/client/js/'))

# build vendor js
gulp.task 'build:vendor:js', ->
  gulp.src(paths.vendor.js)
    .pipe(concat('vendors.js'))
    .pipe(uglify())
    .pipe(gulp.dest('./public/client/js/'))

# build server js
gulp.task 'build:server:js', ->
  gulp.src(paths.server.coffee)
  .pipe(coffee({bare: true}).on('error', gutil.log))
  # .pipe(uglify())
  .pipe(gulp.dest('./public/server/'))

# build everything
gulp.task 'build', [
  'build:app:html'
  'build:app:images'
  'build:vendor:images'
  'build:vendor:fonts'
  'build:app:css'
  'build:vendor:css'
  'build:app:js'
  'build:vendor:js'
  'build:server:js'
], ->
  notifier.notify
    title: 'Gulp'
    message: 'Build complete, sir.'

# start watch server
gulp.task 'watch', ->
  gulp.watch paths.app.html, ['build:app:html']
  gulp.watch paths.app.coffee, ['build:app:js']
  gulp.watch paths.app.html, ['build:app:html']
  gulp.watch paths.app.images, ['build:app:images']
  gulp.watch paths.app.stylus, ['build:app:css']
  gulp.watch paths.vendor.fonts, ['build:vendor:fonts']
  gulp.watch paths.vendor.images, ['build:vendor:images']
  gulp.watch paths.vendor.css, ['build:vendor:css']
  gulp.watch paths.vendor.js, ['build:vendor:js']
  gulp.watch paths.server.coffee, ['build:server:js']
  gulp.watch './bower.json', ['bower']

# default task
gulp.task 'default', ['lint', 'build', 'watch']