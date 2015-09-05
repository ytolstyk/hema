module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    jshint: {
      hema_dev: {
        src: 'app/assets/javascripts/**/*.js',
        jshintrc: true
      }
    },

    eslint: {
      src: ['app/assets/javascripts/**/*.js'],
      options: {
        config: 'eslint.json'
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-eslint');

  grunt.registerTask('style', ['jshint', 'eslint']);
};
