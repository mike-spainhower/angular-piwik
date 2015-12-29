'use strict'

mod = angular.module 'piwik', []

mod.factory 'PiwikActionMethods', -> [
  'setTrackerUrl'
  'setSiteId'
  'setCustomData'
  'setCustomVariable'
  'deleteCustomVariable'
  'setLinkTrackingTimer'
  'setDownloadExtensions'
  'addDownloadExtensions'
  'setDomains'
  'setIgnoreClasses'
  'setRequestMethod'
  'setReferrerUrl'
  'setCustomUrl'
  'setDocumentTitle'
  'setDownloadClasses'
  'setLinkClasses'
  'setCampaignNameKey'
  'setCampaignKeywordKey'
  'discardHashTag'
  'setCookieNamePrefix'
  'setCookieDomain'
  'setCookiePath'
  'setVisitorCookieTimeout'
  'setSessionCookieTimeout'
  'setReferralCookieTimeout'
  'setConversionAttributionFirstReferrer'
  'setDoNotTrack'
  'addListener'
  'enableLinkTracking'
  'setHeartBeatTimer'
  'killFrame'
  'redirectFile'
  'setCountPreRendered'
  'trackGoal'
  'trackLink'
  'trackEvent'
  'trackPageView'
  'setEcommerceView'
  'addEcommerceItem'
  'trackEcommerceOrder'
  'trackEcommerceCartUpdate'
  'setUserId'
  'setCustomRequestProcessing'
  'appendToTrackingUrl'
  'addPlugin'
  'storeCustomVariablesInCookie'
  'setRequestContentType'
  'setAPIUrl'
  'disableCookies'
  'deleteCookies'
  'enableJSErrorTracking'
  'disablePerformanceTracking'
  'setGenerationTimeMs'
  'trackAllContentImpressions'
  'trackVisibleContentImpressions'
  'trackContentImpression'
  'trackContentImpressionsWithinNode'
  'trackContentInteraction'
  'trackContentInteractionNode'
  'trackSiteSearch'
  'setCustomDimension'
  'deleteCustomDimension'
]

mod.factory 'PiwikGetMethods', -> [
  'getVisitorId'
  'getVisitorInfo'
  'getAttributionInfo'
  'getAttributionCampaignName'
  'getAttributionCampaignKeyword'
  'getAttributionReferrerTimestamp'
  'getAttributionReferrerUrl'
  'getCustomData'
  'getCustomVariable'
  'getTrackerUrl'
  'getSiteId'
  'getUserId'
  'getRequest'
  'getCustomDimension'
]

mod.factory 'Piwik', [
  '$q'
  '$window'
  'PiwikActionMethods'
  'PiwikGetMethods'

  ($q, $window, PiwikActionMethods, PiwikGetMethods) ->

    $window['_paq'] = $window['_paq'] || []

    class Piwik
      _self = @
      #Attach methods that change state
      for method in PiwikActionMethods
        do (method) ->
          _self[method] = ->
            cmd = [method]
            cmd.push arg for arg in arguments
            $window['_paq'].push cmd

      #attach methods that retrieve state
      for method in PiwikGetMethods
        do (method) ->
          _self[method] = ->
            deferred = $q.defer()
            _args = arguments

            $window['_paq'].push ->
              try
                deferred.resolve @[method].apply(@, _args)
              catch e
                deferred.reject e

            return deferred.promise
]



mod.directive 'ngpPiwik', [
  '$window'
  '$document'
  'Piwik'
  'PiwikActionMethods'

  ($window, $document, Piwik, PiwikActionMethods) ->
    $window['_paq'] = $window['_paq'] || []
    arr_param_methods = [
      'setDomains'
      'setDownloadClasses'
      'setIgnoreClasses'
      'setLinkClasses'
    ]
    comma_regex = /,/
    comma_regex.compile comma_regex

    build_p_call = (method, attr_val) ->
      call = [method]
      if ((method in arr_param_methods) and comma_regex.test(attr_val))
        call.push attr_val.split(',')
      else
        call.push param for param in attr_val.split(',')
      return call

    push_paq = (method, attr_val) ->
      pcall = build_p_call(method, attr_val)
      existingPaq = (item for item in $window['_paq'] when item[0] is method)
      if(existingPaq.length > 0)
        for value, index in pcall
          existingPaq[0][index] = value
      else
        $window['_paq'].push pcall

    dir_def_obj =
      restrict: 'EA'
      replace: no
      transclude: yes
      compile: (tElement, tAttrs, transclude) ->
        script_elem = $document[0].createElement 'script'
        script_elem.setAttribute 'src', tAttrs.ngpSetJsUrl
        $document[0].body.appendChild script_elem

        return {
          post: (scope, elem, attrs) ->
            for own k,v of attrs when /^ngp/.test(k)
              do (k,v) ->
                method = k[3].toLowerCase() + k[4..]
                return if not (method in PiwikActionMethods)
                push_paq(method, v)

                attrs.$observe k, (val) ->
                  push_paq(method, val)

            $window['_paq'].push ['trackPageView']
        }

    return dir_def_obj
]
