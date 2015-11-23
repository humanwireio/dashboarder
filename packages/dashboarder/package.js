Package.describe({
  name: 'bgrayburn:dashboarder',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: '',
  // URL to the Git repository containing the source code for this package.
  git: '',
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
  api.use('session');
  api.use('tracker');

  api.addFiles('navbars.html','client');
  api.addFiles('navbars.coffee','client');

  api.addFiles('navbar.html','client');
  api.addFiles('navbar.coffee','client');

  api.addFiles('panel.html','client');
  api.addFiles('panel.coffee','client');

  api.addFiles('blank.html','client');

  api.addFiles('dashboarder.html','client');
  api.addFiles('dashboarder.coffee','client');
  api.addFiles('dashboarder.css','client');
});

Package.onTest(function(api) {
  api.use('ecmascript');
  api.use('tinytest');
  api.use('bgrayburn:dashboarder');
  api.addFiles('dashboarder-tests.js');
});