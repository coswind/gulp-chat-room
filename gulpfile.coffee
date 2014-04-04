gulp = require 'gulp'
jade = require 'gulp-jade'
rename = require 'gulp-rename'
livereload = require 'gulp-livereload'
browserify = require 'gulp-browserify'

gulp.task 'coffee', ->
    gulp.src 'coffee/*.coffee', { read: false }
        .pipe(browserify {
            transform: ['coffeeify'],
            extensions: ['.coffee']
            })
        .pipe(rename 'app.js')
        .pipe(gulp.dest 'dist/js')

gulp.task 'jade', ->
    gulp.src 'jade/*.jade'
        .pipe(jade {
            pretty: true
            })
        .pipe(gulp.dest 'dist/')

gulp.task 'watch', ->
    server = livereload()
    gulp.watch ['coffee/*.coffee'], ['coffee']
    gulp.watch ['jade/*.jade'], ['jade']
    gulp.watch ['dist/**'], (file) ->
        server.changed file.path

gulp.task 'default', ['watch']

