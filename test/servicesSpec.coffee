'use strict'

describe 'Piwik Service', ->
  q = mock = piwik = {}

  beforeEach ->
    q = mock = {}

    module ($provide) ->
      $provide.value '$window', mock
      $provide.value '$q', q
      return
    , 'piwik'

    inject ($injector) ->
      piwik = $injector.get 'Piwik'
      return
    return


  it 'should create piwik queue', ->
    expect(mock['_paq']).toBeDefined()
    expect(mock['_paq'].length).toEqual 0

  # describe 'init self', ->
  #   it 'should create piwik queue', inject([ 
  #     'Piwik'

  #     (Piwik) ->
  #       console.log typeof Piwik
  #       expect(Piwik).not.toBeNull()
  #       #expect(mock['_paq']).toBeDefined()
  #       #console.log mock
  #       #expect(mock['_paq'].length).toEqual 0
  #   ])