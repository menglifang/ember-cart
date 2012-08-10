#= require_self
#
#= require ./store
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./templates
#= require_tree ./routes

window.EmberCart = Ember.Application.create
  rootElement: '#ember-cart'

  locales: {}

  config: Ember.Object.create()

  configure: (reconfigure) ->
    reconfigure(EmberCart.config) if reconfigure

    defaultLocale = EmberCart.config.get('defaultLocale') || 'en'
    #locale = 'locales.' + defaultLocale
    Ember.I18n.translations = EmberCart.locales[defaultLocale]

EmberCart.initialize()
