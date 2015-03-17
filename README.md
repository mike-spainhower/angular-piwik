# angular-piwik  [![Build Status](https://travis-ci.org/mike-spainhower/angular-piwik.png?branch=master)](https://travis-ci.org/mike-spainhower/angular-piwik)

Angular service for piwik tracking

### Overview

Angular-piwik provides the methods of the piwik javascript tracker for angular projects.  Tracking config and actions can be accessed declaratively as attributes of the ngp-piwik html element, or programmatically using the Piwik angular service.

## Install

###Bower

    # bower install angular-piwik
    
or in your bower.json (auto)

    #bower install --save angular-piwik

or in your bower.json (manual)

    "dependencies": {
      "angular-piwik": "~1.0.0"
      ...
    }

### CDN

Point to the release on Github's CDN - https://cdn.rawgit.com/mike-spainhower/angular-piwik/v1.2.0/dist/angular-piwik.js

###Manual

Grab `angular-piwik.js` from https://github.com/mike-spainhower/angular-piwik/raw/master/dist/angular-piwik.js


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

    # npm install -g testacular@canary grunt-cli
    # grunt

### See Also

* Piwik JavaScript Tracker - http://piwik.org/docs/javascript-tracking/
* Test Coverage Report - http://mike-spainhower.github.com/angular-piwik/


### Contribute

Pull requests are welcome.  Please just ensure you include tests relevant to the change (e.g., unit for enhancements, regression for bug fixes)

### MIT License

Copyright (c) 2013 Personal Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
