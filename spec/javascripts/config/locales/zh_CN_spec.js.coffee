#= require spec_helper

describe 'Locale zh_CN', ->
  enKeys = Ember.keys(EmberCart.locales.en)
  zh_CN  = EmberCart.locales.zh_CN

  enKeys.forEach (key) ->
    desc = 'has key %@'.fmt key
    it desc, -> zh_CN[key].should.be.exist
