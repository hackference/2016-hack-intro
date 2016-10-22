# Generated on 2016-10-13 using generator-cds-talk 0.1.1
module.exports = (grunt) ->

    grunt.initConfig

        watch:

            livereload:
                options:
                    livereload: true
                files: [
                    'index.html'
                    'slides/{,*/}*.{md,html}'
                    'js/*.js'
                    'images/**'
                    'video/**'
                ]

            index:
                files: [
                    'templates/_index.html'
                    'templates/_section.html'
                    'slides/list.json'
                ]
                tasks: ['buildIndex']

            coffeelint:
                files: ['Gruntfile.coffee']
                tasks: ['coffeelint']

            jshint:
                files: ['js/*.js']
                tasks: ['jshint']

        connect:

            livereload:
                options:
                    port: 9000
                    # Change hostname to '0.0.0.0' to access
                    # the server from outside.
                    hostname: 'localhost'
                    base: '.'
                    open: true
                    livereload: true

        coffeelint:

            options:
                indentation:
                    value: 4
                max_line_length:
                    level: 'ignore'

            all: ['Gruntfile.coffee']

        jshint:

            options:
                jshintrc: '.jshintrc'

            all: ['js/*.js']

        copy:

            dist:
                files: [{
                    expand: true
                    src: [
                        'slides/**'
                        'bower_components/**'
                        'js/**'
                        'css/*.css'
                        'images/**'
                        'js/**'
                        'static/**'
                    ]
                    dest: 'dist/'
                },{
                    expand: true
                    src: ['index.html']
                    dest: 'dist/'
                    filter: 'isFile'
                }]


        manifest:

            generate:
                options:
                    timestamp: true
                    exclude: [
                      'css'
                      'js'
                      'images'
                      'video'
                      'slides'
                      'bower_components'
                      'bower_components/reveal.js/plugin/leap'
                      'bower_components/reveal.js/test'
                      'bower_components/reveal.js/test/examples'
                      'bower_components/reveal.js/test/examples/assets'
                      'bower_components/reveal.js/plugin/math'
                      'bower_components/reveal.js/plugin/print-pdf'
                      'bower_components/reveal-highlight-themes'
                      'bower_components/reveal-highlight-themes/styles'
                      'bower_components/reveal.js'
                      'bower_components/reveal.js/css'
                      'bower_components/reveal.js/css/print'
                      'bower_components/reveal.js/css/theme'
                      'bower_components/reveal.js/css/theme/source'
                      'bower_components/reveal.js/css/theme/template',
                      'bower_components/reveal.js/js'
                      'bower_components/reveal.js/lib'
                      'bower_components/reveal.js/lib/css'
                      'bower_components/reveal.js/lib/font'
                      'bower_components/reveal.js/lib/js'
                      'bower_components/reveal.js/plugin'
                      'bower_components/reveal.js/plugin/highlight'
                      'bower_components/reveal.js/plugin/markdown'
                      'bower_components/reveal.js/plugin/multiplex'
                      'bower_components/reveal.js/plugin/notes'
                      'bower_components/reveal.js/plugin/notes-server'
                      'bower_components/reveal.js/plugin/postmessage'
                      'bower_components/reveal.js/plugin/remotes'
                      'bower_components/reveal.js/plugin/search'
                      'bower_components/reveal.js/plugin/zoom-js'
                    ]
                src: [
                    'css/**'
                    'static/**'
                    'bower_components/**'
                    'js/**'
                    'images/**'
                    'video/**'
                    'slides/**'
                    'index.html'
                ]
                dest: 'dist/cache.manifest'

        buildcontrol:

            options:
                dir: 'dist'
                commit: true
                push: true
                message: 'Built from %sourceCommit% on branch %sourceBranch%'
            pages:
                options:
                    remote: 'git@github.com:hackference/2016-hack-intro.git'
                    branch: 'gh-pages'



    # Load all grunt tasks.
    require('load-grunt-tasks')(grunt)

    grunt.registerTask 'buildIndex',
        'Build index.html from templates/_index.html and slides/list.json.',
        ->
            indexTemplate = grunt.file.read 'templates/_index.html'
            sectionTemplate = grunt.file.read 'templates/_section.html'
            slides = grunt.file.readJSON 'slides/list.json'

            html = grunt.template.process indexTemplate, data:
                slides:
                    slides
                section: (slide) ->
                    grunt.template.process sectionTemplate, data:
                        slide:
                            slide
            grunt.file.write 'index.html', html

    grunt.registerTask 'test',
        '*Lint* javascript and coffee files.', [
            'coffeelint'
            'jshint'
        ]

    grunt.registerTask 'serve',
        'Run presentation locally and start watch process (living document).', [
            'buildIndex'
            'connect:livereload'
            'watch'
        ]

    grunt.registerTask 'dist',
        'Save presentation files to *dist* directory.', [
            'test'
            'buildIndex'
            'copy'
        ]


    grunt.registerTask 'deploy',
        'Deploy to Github Pages', [
            'dist'
            'buildcontrol'
        ]


    # Define default task.
    grunt.registerTask 'default', [
        'test'
        'serve'
    ]
