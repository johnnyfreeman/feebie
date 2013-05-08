'use strict';

var js_files = [
  'public/assets/jquery/jquery-1.9.1.js',
  'public/assets/underscore/underscore.js',
  'public/assets/backbone/backbone.js',
  'public/assets/marionette/backbone.marionette.min.js',
  'public/assets/zclip/zclip.min.js',
  'public/assets/bootstrap/js/bootstrap.js',
  'public/assets/flat-ui/js/jquery.placeholder.js',

  'public/assets/greensock-v12-js/src/uncompressed/easing/EasePack.js',
  'public/assets/greensock-v12-js/src/uncompressed/plugins/CSSPlugin.js',
  'public/assets/greensock-v12-js/src/uncompressed/TweenLite.js',

  'public/assets/app/js/application.js',
  'public/assets/app/js/models/code.js',
  'public/assets/app/js/models/fees.js',
  'public/assets/app/js/collections/code.js',
  'public/assets/app/js/collections/fees.js',
  'public/assets/app/js/regions/main.js',
  'public/assets/app/js/views/code-item.js',
  'public/assets/app/js/views/options-item.js',
  'public/assets/app/js/views/fees-item.js',
  'public/assets/app/js/views/notification-item.js',
  'public/assets/app/js/views/search-form-item.js',
  'public/assets/app/js/controller.js',
  'public/assets/app/js/router.js'
];

module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({

    pkg: grunt.file.readJSON('package.json'),

    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      },
      build: {
        files: {
          'public/assets/app/js/<%= pkg.name %>.min.js': js_files
        }
      }
    },

    develop: {
      server: {
        file: 'app/app.js'
      }
    },

    livereload: {
      port: 35729 // Default livereload listening port.
    },

    // compile .scss/.sass to .css using Compass
    compass: {
      dist: {
        // http://compass-style.org/help/tutorials/configuration-reference/#configuration-properties
        options: {
          cssDir: 'public/assets/app/css',
          sassDir: 'public/assets/app/scss',
          imagesDir: 'public/assets/app/img',
          javascriptsDir: 'public/assets/app/js',
          force: true
        }
      }
    },

    // regarde configuration
    regarde: {

      compass: {
        files: [
          'public/assets/app/scss/*.{scss,sass}'
        ],
        tasks: 'compass'

      },

      livereload: {
        files: [
          'public/*.html',
          'public/assets/**/*.{css,png,jpg,gif,jpeg}',
          'public/assets/app/js/<%= pkg.name %>.min.js',
          'app/app.js' // reload the browser when the server is restarted
        ],
        tasks: 'livereload'
      },

      uglify: {
        files: js_files,
        tasks: 'uglify'
      }

    }

  });

  // Load tasks
  grunt.loadNpmTasks('grunt-contrib');
  grunt.loadNpmTasks('grunt-regarde');
  grunt.loadNpmTasks('grunt-develop');

  // Default tasks
  grunt.registerTask('default', ['livereload-start', 'develop', 'regarde']);

};