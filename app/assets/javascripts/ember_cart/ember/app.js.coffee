#= require_self
#
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./templates

window.EmberCart = Ember.Application.create
  rootElement: '#ember-cart'

  locales: {}

  config: Ember.Object.create()

  configure: (reconfigure) ->
    reconfigure(EmberCart.config) if reconfigure

    defaultLocale = EmberCart.config.get('defaultLocale') || 'en'
    #locale = 'locales.' + defaultLocale
    Ember.I18n.translations = EmberCart.locales[defaultLocale]

EmberCart.store = DS.Store.create
  revision: 4
  adapter: DS.RESTAdapter.create(bulkCommit: false, namespace: 'ember_cart')
