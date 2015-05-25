'use strict'

describe 'Piwik Directives', ->
  elm = scope = win = {}

  shift_until = (arr, str) ->
    ret = arr.shift() until ret?[0] == str
    return ret

  beforeEach ->
    module 'piwik'

    inject ($rootScope, $compile, $window) ->
      elm = angular.element '''<div>
        <ngp-piwik
          ngp-set-js-url="https://piwik.test.com/piwik.js"
          ngp-set-tracker-url="https://piwik.test.com/piwik.php"
          ngp-set-site-id="42"
          ngp-set-domains="www.test.com,demo.test.com">
        </ngp-piwik>
      </div>'''
      scope = $rootScope
      $window['_paq'] = undefined
      win = $window
      $compile(elm)(scope)
      scope.$digest()
      return
    return


  it 'should create one script element', ->
    scr_elm = angular.element(document).find('script')
    url = "https://piwik.test.com/piwik.js"
    found = []
    found.push elem if elem.src is url for elem in scr_elm
    expect(found.length).toBe 1
    expect(found[0]?.src).toEqual url

  it 'should create call queue', ->
    expect(win['_paq']).toBeDefined()
    expect(win['_paq'].length).toEqual(4)

  it 'should place trackerUrl on call queue before trackPageView', ->
    cmd = shift_until win['_paq'], 'setTrackerUrl'
    expect(cmd.length).toEqual(2)
    expect(cmd[0]).toEqual('setTrackerUrl')
    expect(cmd[1]).toEqual('https://piwik.test.com/piwik.php')

    cmd = shift_until win['_paq'], 'trackPageView'
    expect(cmd[0]).toEqual('trackPageView')

  it 'should place siteid on call queue before trackPageView', ->
    cmd = shift_until win['_paq'], 'setSiteId'
    expect(cmd.length).toEqual(2)
    expect(cmd[0]).toEqual('setSiteId')
    expect(cmd[1]).toEqual('42')

    cmd = shift_until win['_paq'], 'trackPageView'
    expect(cmd[0]).toEqual('trackPageView')

  it 'should recognize and process arrays', ->
    cmd = win['_paq'].shift() until cmd?[0] == 'setDomains'
    expect(cmd[1].length).toBe(2)
    expect(cmd[1][0]).toEqual('www.test.com')
    expect(cmd[1][1]).toEqual('demo.test.com')