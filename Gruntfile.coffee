module.exports = (grunt) ->

  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig

    baseDir: 'lib/peterhenrikson'

    stylus:
      options:
        'include css': true
      css:
        src: '<%= baseDir %>/styles/style.styl'
        dest: 'public/style.css'

    watch:
      options:
        livereload: true
      site:
        files: ['<%= baseDir %>/views/**/*',
                '<%= baseDir %>/scripts/**/*']
      css:
        files: ['<%= baseDir %>/styles/*']
        tasks: ['stylus']

    requirejs:
      options:
        baseUrl: '',
        mainConfigFile: 'config/requirejs.js',
        name: 'components/almond/almond',
        out: 'public/site.js'

      development:
        options:
          optimize: 'none'
      production:
        options:
          optimize: 'uglify2'

  grunt.registerTask 'rackup', ->
    spawn = require('child_process').spawn
    rackup = spawn('rackup')
    rackup.stdout.on 'data', (data) ->
      process.stdout.write('[rackup]: '+data.toString());
    rackup.stderr.on 'data', (data) ->
      process.stdout.write('[rackup]: '+data.toString());

  grunt.registerTask('work', ['stylus', 'rackup', 'watch'])
  grunt.registerTask('production', ['stylus', 'requirejs:production'])
  grunt.registerTask('default', ['work'])
