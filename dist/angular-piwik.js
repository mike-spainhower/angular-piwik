(function() {
  'use strict';

  var mod,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; },
    __hasProp = {}.hasOwnProperty;

  mod = angular.module('piwik', []);

  mod.factory('PiwikActionMethods', function() {
    return ['setTrackerUrl', 'setSiteId', 'setCustomData', 'setCustomVariable', 'deleteCustomVariable', 'setLinkTrackingTimer', 'setDownloadExtensions', 'addDownloadExtensions', 'setDomains', 'setIgnoreClasses', 'setRequestMethod', 'setReferrerUrl', 'setCustomUrl', 'setDocumentTitle', 'setDownloadClasses', 'setLinkClasses', 'setCampaignNameKey', 'setCampaignKeywordKey', 'discardHashTag', 'setCookieNamePrefix', 'setCookieDomain', 'setCookiePath', 'setVisitorCookieTimeout', 'setSessionCookieTimeout', 'setReferralCookieTimeout', 'setConversionAttributionFirstReferrer', 'setDoNotTrack', 'addListener', 'enableLinkTracking', 'setHeartBeatTimer', 'killFrame', 'redirectFile', 'setCountPreRendered', 'trackGoal', 'trackLink', 'trackEvent', 'trackPageView', 'setEcommerceView', 'addEcommerceItem', 'trackEcommerceOrder', 'trackEcommerceCartUpdate', 'setUserId', 'setCustomRequestProcessing', 'appendToTrackingUrl', 'addPlugin', 'storeCustomVariablesInCookie', 'setRequestContentType', 'setAPIUrl', 'disableCookies', 'deleteCookies', 'enableJSErrorTracking', 'disablePerformanceTracking', 'setGenerationTimeMs', 'trackAllContentImpressions', 'trackVisibleContentImpressions', 'trackContentImpression', 'trackContentImpressionsWithinNode', 'trackContentInteraction', 'trackContentInteractionNode', 'trackSiteSearch'];
  });

  mod.factory('PiwikGetMethods', function() {
    return ['getVisitorId', 'getVisitorInfo', 'getAttributionInfo', 'getAttributionCampaignName', 'getAttributionCampaignKeyword', 'getAttributionReferrerTimestamp', 'getAttributionReferrerUrl', 'getCustomData', 'getCustomVariable', 'getTrackerUrl', 'getSiteId', 'getUserId', 'getRequest'];
  });

  mod.factory('Piwik', [
    '$q', '$window', 'PiwikActionMethods', 'PiwikGetMethods', function($q, $window, PiwikActionMethods, PiwikGetMethods) {
      var Piwik;
      $window['_paq'] = $window['_paq'] || [];
      return Piwik = (function() {
        var method, _fn, _fn1, _i, _j, _len, _len1, _self;

        function Piwik() {}

        _self = Piwik;

        _fn = function(method) {
          return _self[method] = function() {
            var arg, cmd, _j, _len1;
            cmd = [method];
            for (_j = 0, _len1 = arguments.length; _j < _len1; _j++) {
              arg = arguments[_j];
              cmd.push(arg);
            }
            return $window['_paq'].push(cmd);
          };
        };
        for (_i = 0, _len = PiwikActionMethods.length; _i < _len; _i++) {
          method = PiwikActionMethods[_i];
          _fn(method);
        }

        _fn1 = function(method) {
          return _self[method] = function() {
            var deferred, _args;
            deferred = $q.defer();
            _args = arguments;
            $window['_paq'].push(function() {
              try {
                return deferred.resolve(this[method].apply(this, _args));
              } catch (e) {
                return deferred.reject(e);
              }
            });
            return deferred.promise;
          };
        };
        for (_j = 0, _len1 = PiwikGetMethods.length; _j < _len1; _j++) {
          method = PiwikGetMethods[_j];
          _fn1(method);
        }

        return Piwik;

      })();
    }
  ]);

  mod.directive('ngpPiwik', [
    '$window', '$document', 'Piwik', 'PiwikActionMethods', function($window, $document, Piwik, PiwikActionMethods) {
      var arr_param_methods, build_p_call, comma_regex, dir_def_obj, push_paq;
      $window['_paq'] = $window['_paq'] || [];
      arr_param_methods = ['setDomains', 'setDownloadClasses', 'setIgnoreClasses', 'setLinkClasses'];
      comma_regex = /,/;
      comma_regex.compile(comma_regex);
      build_p_call = function(method, attr_val) {
        var call, param, _i, _len, _ref;
        call = [method];
        if ((__indexOf.call(arr_param_methods, method) >= 0) && comma_regex.test(attr_val)) {
          call.push(attr_val.split(','));
        } else {
          _ref = attr_val.split(',');
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            param = _ref[_i];
            call.push(param);
          }
        }
        return call;
      };
      push_paq = function(method, attr_val) {
        var existingPaq, index, item, pcall, value, _i, _len, _results;
        pcall = build_p_call(method, attr_val);
        existingPaq = (function() {
          var _i, _len, _ref, _results;
          _ref = $window['_paq'];
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            item = _ref[_i];
            if (item[0] === method) {
              _results.push(item);
            }
          }
          return _results;
        })();
        if (existingPaq.length > 0) {
          _results = [];
          for (index = _i = 0, _len = pcall.length; _i < _len; index = ++_i) {
            value = pcall[index];
            _results.push(existingPaq[0][index] = value);
          }
          return _results;
        } else {
          return $window['_paq'].push(pcall);
        }
      };
      dir_def_obj = {
        restrict: 'EA',
        replace: false,
        transclude: true,
        compile: function(tElement, tAttrs, transclude) {
          var script_elem;
          script_elem = $document[0].createElement('script');
          script_elem.setAttribute('src', tAttrs.ngpSetJsUrl);
          $document[0].body.appendChild(script_elem);
          return {
            post: function(scope, elem, attrs) {
              var k, v;
              for (k in attrs) {
                if (!__hasProp.call(attrs, k)) continue;
                v = attrs[k];
                if (/^ngp/.test(k)) {
                  (function(k, v) {
                    var method;
                    method = k[3].toLowerCase() + k.slice(4);
                    if (!(__indexOf.call(PiwikActionMethods, method) >= 0)) {
                      return;
                    }
                    push_paq(method, v);
                    return attrs.$observe(k, function(val) {
                      return push_paq(method, val);
                    });
                  })(k, v);
                }
              }
              return $window['_paq'].push(['trackPageView']);
            }
          };
        }
      };
      return dir_def_obj;
    }
  ]);

}).call(this);
