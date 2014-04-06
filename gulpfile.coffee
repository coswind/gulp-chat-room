$ = require('gulp-load-plugins')()
gulp = require 'gulp'

gulp.task 'coffee', ->
    gulp.src 'coffee/load.coffee', { read: false }
        .pipe($.browserify {
            transform: ['coffeeify'],
            extensions: ['.coffee']
            })
        .pipe($.rename 'app.js')
        .pipe(gulp.dest 'dist/js')

gulp.task 'jade', ->
    gulp.src 'jade/*.jade'
        .pipe($.jade {
            pretty: true
            })
        .pipe(gulp.dest 'dist/')

gulp.task 'template', ->
    gulp.src 'template/*.html'
        .pipe $.fileToJs()
        .pipe(gulp.dest 'coffee/template')

gulp.task 'socket', ->
    $.nodemon({
        script: 'socket/socket.coffee',
        ext: '',
        ignore: ['']
    })

gulp.task 'watch', ->
    server = $.livereload()
    gulp.watch ['coffee/*.coffee'], ['coffee']
    gulp.watch ['jade/*.jade'], ['jade']
    gulp.watch ['template/*.html'], ['template']
    gulp.watch ['dist/*.html', 'dist/js/*.js'], (file) ->
        server.changed file.path

gulp.task 'default', ['template', 'socket', 'watch']

