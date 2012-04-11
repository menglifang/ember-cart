#= require spec_helper

describe 'EmberCart', ->
  describe 'class methods', ->
    describe '.configure', ->
      beforeEach ->
        EmberCart.configure (config) ->
          config.set('defaultLocale', 'zh_CN')

      afterEach ->
        EmberCart.configure (config) ->
          config.set('defaultLocale', 'en')

      it 'overrides the default locale', ->
        EmberCart.config.get('defaultLocale').should.equal('zh_CN')
