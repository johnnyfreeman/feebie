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
          'public/assets/app/js/<%= pkg.name %>.min.js': [
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
          ]
        }
      }
    }
  });

  // Load the plugin that provides the "uglify" task.
  grunt.loadNpmTasks('grunt-contrib-uglify');

  // Default task(s).
  grunt.registerTask('default', ['uglify']);

};