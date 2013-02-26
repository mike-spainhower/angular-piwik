# angular-piwik  [![Build Status](https://travis-ci.org/mike-spainhower/angular-piwik.png?branch=master)](https://travis-ci.org/mike-spainhower/angular-piwik)

Angular service for piwik tracking

### Overview

Angular-piwik provides the methods of the piwik javascript tracker for angular projects.  Tracking config and actions can be accessed declaratively as attributes of the ngp-piwik html element, or programmatically using the Piwik angular service.

## Install

###Bower

    # bower install angular-piwik
    
or in your component.json

    "dependencies": {
      "angular": "~1.0.0"
      ...
    }

###Manual

Grab <code>angular-piwik.js</code> from https://github.com/mike-spainhower/bower-angular-piwik


## Use

You must add <code>piwik</code> module as a dependency to your app.  For example

    var app = angular.module 'myapp', ['piwik']

The ngp-piwik html element must be added to the page somewhere.  Currently, only one per page is supported (Piwik async tracker limitation).

Add to page:

    <ngp-piwik ngp-set-js-url="<host>/piwik.js" ngp-set-tracker-url="<host>/piwik.php" ngp-set-site-id="<id>"> </ngp-piwik>

Attributes prefixed with <code>ngp-</code> are Piwik Javascript tracker methods, just dash-separated rather than camel cased.  All Piwik tracker methods are supported.

Once this element is present in the page, you may inject the <code>Piwik</code> service into your controllers.  The Piwik object has all the same methods as the official Piwik js tracker.

## Errata

### Build

    # npm install -g testacular@canary grunt
    # grunt

### See Also

Piwik JavaScript Tracker - http://piwik.org/docs/javascript-tracking/

### Contribute

Pull requests are welcome.  Please just ensure you include tests relevant to the change (e.g., unit for enhancements, regression for bug fixes)
