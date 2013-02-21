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
  'trackPageView'
  'setEcommerceView'
  'addEcommerceItem'
  'trackEcommerceOrder'
  'trackEcommerceCartUpdate'
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