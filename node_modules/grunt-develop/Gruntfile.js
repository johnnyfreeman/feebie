
/*!
 *
 * grunt-develop
 * http://github.com/edwardhotchkiss/node-develop
 *
 * Copyright (c) 2013 Edward Hotchkiss
 * Licensed under the MIT license.
 *
 */

'use strict';

module.exports = function(grunt) {

  // grunt config
  grunt.initConfig({
    // grunt-contrib-jshint
    jshint: {
      files: [
        'Gruntfile.js',
        'tasks/*.js',
        'test/**/*.js',
        '<%= nodeunit.tests %>'
      ],
      options: {
        "laxcomma":true,
        "curly": true,
        "eqeqeq": true,
        "immed": true,
        "latedef": true,
        "newcap": true,
        "noarg": true,
        "sub": true,
        "undef": true,
        "boss": true,
        "eqnull": true,
        "node": true,
        "es5": true
      }
    },
    // grunt-develop
    develop: {
      server: {
        file: 'test/fixtures/app.js'
      }
    },
    // grunt-contrib-watch
    watch: {
      jslint: {
        files: ['<%= jshint.files %>'],
        tasks: ['jshint'],
        options: {
          interrupt: true
        }
      },
      nodeunit: {
        files: 'test/**/*.js',
        tasks: ['node-unit']
      }
    },
    // grunt-contrib-nodeunit
    nodeunit: {
      tests: ['test/*_test.js']
    }
  });

  // load plugin tasks
  grunt.loadTasks('tasks');

  // load required npm plugins
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-nodeunit');

  // default = run jslint and all tests
  grunt.registerTask('default', ['jshint','develop','nodeunit']);

};
