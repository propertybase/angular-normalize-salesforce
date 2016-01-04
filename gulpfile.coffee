'use strict'

gulp          = require 'gulp'
$             = require('gulp-load-plugins')()
run           = require 'run-sequence'
fs            = require 'fs'
del           = require 'del'

packageJSON     = JSON.parse fs.readFileSync './package.json'

#-------------------------------------------------

src_files = [
  'src/angular-normalize-salesforce.coffee',
  'src/salesforce-standard-fields.coffee',
  'src/salesforce-standard-objects.coffee',
  'src/salesforce-sobjects.coffee',
  'src/salesforce-array-values.coffee',
  'src/normalize-salesforce.coffee'
]

gulp.task 'clean', (cb) ->
  del [
    'dist'
  ], cb

gulp.task 'coffee', ->
  gulp.src src_files
    .pipe $.sourcemaps.init()
      .pipe $.coffee({bare: true}).on('error', $.util.log)
      .pipe $.ngAnnotate()
      .pipe $.concat "#{packageJSON.name}.js"
    .pipe $.sourcemaps.write()
    .pipe gulp.dest 'dist'

gulp.task 'coffee:min', ->
  gulp.src src_files
    .pipe $.sourcemaps.init()
      .pipe $.coffee({bare: true}).on('error', $.util.log)
      .pipe $.ngAnnotate()
      .pipe $.uglify({mangle: false, preserveComments: 'some'})
      .pipe $.concat "#{packageJSON.name}.min.js"
    .pipe $.sourcemaps.write('.')
    .pipe gulp.dest 'dist'

gulp.task 'karma', ->
  gulp.src './idontexist'
    .pipe $.karma(
      configFile: 'karma.conf.coffee'
      action: 'run'
    ).on 'error', (err) ->
      throw err

gulp.task 'lint', ->
  gulp.src src_files.concat([
    'test/*.coffee'
  ])
    .pipe $.coffeelint()
    .pipe $.coffeelint.reporter()

gulp.task 'version', ->
  $.util.log $.util.colors.yellow(
    "Angular Normalize Salesforce Version: #{packageJSON.version}"
  )

inc = (importance) ->
  gulp.src(['./package.json', './bower.json'])
    # bump the version number in those files
    .pipe($.bump({type: importance}))
    # save it back to filesystem
    .pipe(gulp.dest('./'))
    # commit the changed version number
    .pipe($.git.commit('bumps package version'))

    # read only one file to get the version number
    .pipe($.filter('package.json'))
    # **tag it in the repository**
    .pipe($.tagVersion({prefix: ''}))
    # push the tags to master
    .pipe($.git.push('origin', 'master', { args: '--tags' }))

gulp.task 'patch', ->
  inc('patch')

gulp.task 'minor', ->
  inc('minor')

gulp.task 'major', ->
  inc('major')

#-------------------------------------------------

gulp.task 'test', ->
  run 'version',
    ['karma', 'lint']

gulp.task 'build', ->
  run 'version',
    'clean', 'coffee', 'coffee:min'

gulp.task 'default', ->
  run 'version',
    ['karma', 'lint'],
    'clean', 'coffee', 'coffee:min'
