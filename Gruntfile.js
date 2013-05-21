'use strict';

var js_files = [
  'public/assets/jquery/jquery.min.js',
  'public/assets/underscore/underscore-min.js',
  'public/assets/backbone/backbone-min.js',
  'public/assets/backbone.marionette/lib/backbone.marionette.min.js',
  'public/assets/jquery-zclip/jquery.zclip.js',
  'public/assets/bootstrap/docs/assets/js/bootstrap.js',
  'public/assets/flat-ui/js/jquery.placeholder.js',

  'public/assets/GreenSock-JS/src/minified/easing/EasePack.min.js',
  'public/assets/GreenSock-JS/src/minified/plugins/CSSPlugin.min.js',
  'public/assets/GreenSock-JS/src/minified/TweenLite.min.js',

  'app/application.js',
  'app/models/code.js',
  'app/models/fees.js',
  'app/collections/code.js',
  'app/collections/fees.js',
  'app/regions/main.js',
  'app/views/code-item.js',
  'app/views/options-item.js',
  'app/views/fees-item.js',
  'app/views/notification-item.js',
  'app/views/search-form-item.js',
  'app/controller.js',
  'app/router.js'
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
        file: 'app/server.js'
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
          'app/**/*.js'
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
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-livereload');
  grunt.loadNpmTasks('grunt-regarde');
  grunt.loadNpmTasks('grunt-develop');

  // Default tasks
  grunt.registerTask('default', ['livereload-start', 'develop', 'regarde']);

};
