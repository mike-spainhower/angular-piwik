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
      #Attach methods that change state
      for method in PiwikActionMethods
        @[method] = ->
          cmd.push method
          cmd.push arg for arg in arguments
          _paq.push cmd

      #attach methods that retrieve state
      for method in PiwikGetMethods
        @[method] = ->
          deferred = $q.defer()
          _args = arguments
          _method = method

          _paq.push ->
            try
              deferred.resolve @[_method].apply(@, _args)
            catch e
              deferred.reject e
            
          return deferred.promise
]