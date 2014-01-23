gulp        = require 'gulp'
coffee      = require 'gulp-coffee'
concat      = require 'gulp-concat'
clean       = require 'gulp-clean'
uglify      = require 'gulp-uglify'
notify      = require 'gulp-notify'
coffeelint  = require 'gulp-coffeelint'
eventStream = require 'event-stream'
bower       = require 'gulp-bower'

###
**************************
CLEAN
**************************
###

# dist
gulp.task 'clean:dist', ->
  gulp.src('./dist/**/*.{js,css}')
    .pipe(clean())

# bower
gulp.task 'clean:bower', ->
  gulp.src(['./bower_components/**/*'])
    .pipe(clean())

# npm
gulp.task 'clean:npm', ->
  gulp.src('./node_modules/**/*')
    .pipe(clean())

# all
gulp.task 'clean', ['clean:dist', 'clean:bower', 'clean:npm']


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
  gulp.src('./src/**/*.coffee')
    .pipe(coffeelint({max_line_length: {value: 170, limitComments: false}}))
    .pipe(coffeelint.reporter()) # Using `coffeelint-stylish` reporter https://npmjs.org/package/coffeelint-stylish

###
**************************
BUILD
**************************
###

# build source files
gulp.task 'build', ['clean:dist'], ->

  # app
  appStream = gulp.src('./src/client/**/*.coffee').pipe(coffee())

  # vendors
  vendorsStream = gulp.src [
    'bower_components/jquery/jquery.min.js',
    'bower_components/underscore/underscore-min.js',
    'bower_components/backbone/backbone-min.js',
    'bower_components/backbone.marionette/lib/backbone.marionette.min.js',
    'bower_components/jquery-zclip/jquery.zclip.js',
    'bower_components/bootstrap/docs/assets/js/bootstrap.js',
    'bower_components/flat-ui/js/jquery.placeholder.js',
    'bower_components/greensock/src/minified/easing/EasePack.min.js',
    'bower_components/greensock/src/minified/plugins/CSSPlugin.min.js',
    'bower_components/greensock/src/minified/TweenLite.min.js'
  ]

  # app + vendors = client 
  clientStream = eventStream.merge(vendorsStream, appStream)
    .pipe(concat('app.js'))
    .pipe(uglify())
    .pipe(gulp.dest('./dist/client/js/'))


  # server
  serverStream = gulp.src('./src/server/**/*.coffee')
    .pipe(coffee())
    .pipe(uglify())
    .pipe(gulp.dest('./dist/server/'))

  # return concatenated server and client streams
  eventStream.merge(clientStream, serverStream)
    .pipe(notify({title: 'Gulp', message: 'Build complete, sir.', onLast: true}))



# start watch server
gulp.task 'watch', ->
  # source files
  gulp.watch ['./src/**/*.coffee', './src/client/sass/**/*.{sass,scss}'], ->
    gulp.run 'build'
  # bower
  gulp.watch './bower.json', ->
    gulp.run 'bower'

# default task
gulp.task 'default', ['lint', 'build', 'watch']