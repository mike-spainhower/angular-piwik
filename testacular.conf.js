// Testacular configuration
// Generated on Wed Feb 20 2013 02:27:33 GMT-0500 (EST)


// base path, that will be used to resolve files and exclude
basePath = './';


// list of files / patterns to load in the browser
files = [
  JASMINE,
  JASMINE_ADAPTER,
  'vendor/angular.js',
  'vendor/angular-*.js',
  'test/vendor/angular-mocks.js',
  'lib/*.coffee',
  'test/*.coffee'
];


// list of files to exclude
exclude = [
  '**/*.sw*'
];


// test results reporter to use
// possible values: 'dots', 'progress', 'junit'
reporters = ['progress', 'coverage'];


// web server port
port = 8080;


// cli runner port
runnerPort = 9100;


// enable / disable colors in the output (reporters and logs)
colors = true;


// level of logging
// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_INFO;


// enable / disable watching file and executing tests whenever any file changes
autoWatch = true;


// Start these browsers, currently available:
// - Chrome
// - ChromeCanary
// - Firefox
// - Opera
// - Safari (only Mac)
// - PhantomJS
// - IE (only Windows)
browsers = ['PhantomJS', 'Chrome', 'Firefox', 'Opera'];


// If browser does not capture in given timeout [ms], kill it
captureTimeout = 5000;


// Continuous Integration mode
// if true, it capture browsers, run tests and exit
singleRun = false;

//Get me some coffee and some coverage
preprocessors = {
  '**/*.coffee': 'coffee',
  '**/lib/*.js': 'coverage'
}