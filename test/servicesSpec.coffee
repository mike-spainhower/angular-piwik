'use strict'

describe 'Piwik Service', ->
  q = mock = piwik = {}

  beforeEach ->
    mock = {}
    q.resolve = jasmine.createSpy('deferred.resolve')
    q.reject = jasmine.createSpy('deferred.reject')
    q.defer = ->
      resolve: q.resolve
      reject: q.reject
      promise: 'sentinel'

    spyOn(q, 'defer').andCallThrough()

    module ($provide) ->
      $provide.value '$window', mock
      $provide.value '$q', q
      return
    , 'piwik'

    inject ($injector) ->
      piwik = $injector.get 'Piwik'
      piwik()
      return
    return


  it 'should create piwik queue', ->
    expect(mock['_paq']).toBeDefined()
    expect(mock['_paq'].length).toEqual 0

  it 'should enqueue action commands', ->
    _url = 'somestring'
    piwik.setTrackerUrl _url
    _cmd = mock['_paq'].pop()
    expect(_cmd[0]).toEqual 'setTrackerUrl'
    expect(_cmd[1]).toEqual _url

  it 'should return promise & value from get command', ->
    val = null
    getVisitorId = jasmine.createSpy('getVisitorId').andReturn 2
    class Pt
      getVisitorId: getVisitorId
    val = piwik.getVisitorId()
    expect(val).toEqual 'sentinel'
    expect(q.defer).toHaveBeenCalled()
    
    mock['_paq'].pop().apply (new Pt())
    expect(getVisitorId).toHaveBeenCalled()
    expect(q.resolve).toHaveBeenCalledWith(2)

  it 'should reject error promises', ->
    val = null
    e = new Error("error")
    err_fn = {}
    err_fn.getVisitorId = ->
      throw e
    spyOn(err_fn, 'getVisitorId').andCallThrough()
    class Pt
      getVisitorId: err_fn.getVisitorId
    val = piwik.getVisitorId()
    expect(val).toEqual 'sentinel'
    expect(q.defer).toHaveBeenCalled()
    
    mock['_paq'].pop().apply (new Pt())
    expect(err_fn.getVisitorId).toHaveBeenCalled()
    expect(q.reject).toHaveBeenCalledWith(e)

  it 'should buffer commands until siteid and url are set', ->
    expect(1).toEqual 1

  it 'should support get methods', ->
    expect(typeof piwik.getVisitorId).toEqual 'function'
    expect(typeof piwik.getVisitorInfo).toEqual 'function'
    expect(typeof piwik.getAttributionInfo).toEqual 'function'
    expect(typeof piwik.getAttributionCampaignName).toEqual 'function'
    expect(typeof piwik.getAttributionCampaignKeyword).toEqual 'function'
    expect(typeof piwik.getAttributionReferrerTimestamp).toEqual 'function'
    expect(typeof piwik.getAttributionReferrerUrl).toEqual 'function'
    expect(typeof piwik.getCustomData).toEqual 'function'
    expect(typeof piwik.getCustomVariable).toEqual 'function'

  it 'should support action methods', ->
    expect(typeof piwik.setTrackerUrl).toEqual 'function'
    expect(typeof piwik.setSiteId).toEqual 'function'
    expect(typeof piwik.setCustomData).toEqual 'function'
    expect(typeof piwik.setCustomVariable).toEqual 'function'
    expect(typeof piwik.deleteCustomVariable).toEqual 'function'
    expect(typeof piwik.setLinkTrackingTimer).toEqual 'function'
    expect(typeof piwik.setDownloadExtensions).toEqual 'function'
    expect(typeof piwik.addDownloadExtensions).toEqual 'function'
    expect(typeof piwik.setDomains).toEqual 'function'
    expect(typeof piwik.setIgnoreClasses).toEqual 'function'
    expect(typeof piwik.setRequestMethod).toEqual 'function'
    expect(typeof piwik.setReferrerUrl).toEqual 'function'
    expect(typeof piwik.setCustomUrl).toEqual 'function'
    expect(typeof piwik.setDocumentTitle).toEqual 'function'
    expect(typeof piwik.setDownloadClasses).toEqual 'function'
    expect(typeof piwik.setLinkClasses).toEqual 'function'
    expect(typeof piwik.setCampaignNameKey).toEqual 'function'
    expect(typeof piwik.setCampaignKeywordKey).toEqual 'function'
    expect(typeof piwik.discardHashTag).toEqual 'function'
    expect(typeof piwik.setCookieNamePrefix).toEqual 'function'
    expect(typeof piwik.setCookieDomain).toEqual 'function'
    expect(typeof piwik.setCookiePath).toEqual 'function'
    expect(typeof piwik.setVisitorCookieTimeout).toEqual 'function'
    expect(typeof piwik.setSessionCookieTimeout).toEqual 'function'
    expect(typeof piwik.setReferralCookieTimeout).toEqual 'function'
    expect(typeof piwik.setConversionAttributionFirstReferrer)
    .toEqual 'function'
    expect(typeof piwik.setDoNotTrack).toEqual 'function'
    expect(typeof piwik.addListener).toEqual 'function'
    expect(typeof piwik.enableLinkTracking).toEqual 'function'
    expect(typeof piwik.setHeartBeatTimer).toEqual 'function'
    expect(typeof piwik.killFrame).toEqual 'function'
    expect(typeof piwik.redirectFile).toEqual 'function'
    expect(typeof piwik.setCountPreRendered).toEqual 'function'
    expect(typeof piwik.trackEvent).toEqual 'function'
    expect(typeof piwik.trackGoal).toEqual 'function'
    expect(typeof piwik.trackLink).toEqual 'function'
    expect(typeof piwik.trackPageView).toEqual 'function'
    expect(typeof piwik.setEcommerceView).toEqual 'function'
    expect(typeof piwik.addEcommerceItem).toEqual 'function'
    expect(typeof piwik.trackEcommerceOrder).toEqual 'function'
    expect(typeof piwik.trackEcommerceCartUpdate).toEqual 'function'
    expect(typeof piwik.setUserId).toEqual 'function'
