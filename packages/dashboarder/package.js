Package.describe({
  name: 'bgrayburn:dashboarder',
  version: '0.0.6',
  // Brief, one-line summary of the package.
  summary: 'build a page tree and bootstrap navigation with a single hashmap',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/humanwireio/dashboarder',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.2.1');
  api.use('ecmascript');
  api.use('templating','client');
  api.use('coffeescript');
  api.use('underscore');
  api.use('mizzao:bootstrap-3@3.3.1_1');
  api.use('session');
  api.use('mongo')
  api.use('tracker');
  api.use('fourseven:scss@3.4.1');
  //api.use("d3js:d3")
  //api.use('react');
  //api.use('browserify:react-d3');
  //api.export('ReactDOM');

  api.addFiles('collections.js',['server','client']);
  api.export('Data',['server','client']);

  api.addFiles('navbars.html','client');
  api.addFiles('navbars.coffee','client');

  api.addFiles('navbar.html','client');
  api.addFiles('navbar.coffee','client');

  api.addFiles('panel.html','client');
  api.addFiles('panel.coffee','client');

  api.addFiles('blank.html','client');

  //api.addFiles('graph.html','client');
  //api.addFiles('graph.coffee','client');

  api.addFiles('dashboarder.html','client');
  api.addFiles('dashboarder.coffee','client');
  api.addFiles('dashboarder.css','client');
  api.addFiles('app.scss','client')
});

Package.onTest(function(api) {
  api.use('ecmascript');
  api.use('tinytest');
  api.use('bgrayburn:dashboarder');
  api.addFiles('dashboarder-tests.js');
});
