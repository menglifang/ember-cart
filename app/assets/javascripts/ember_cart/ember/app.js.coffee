#= require_self
#
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./templates

window.EmberCart = Ember.Application.create
  rootElement: '#ember-cart'

  config: Ember.Object.create()

  configure: (reconfigure) ->
    reconfigure(EmberCart.config) if reconfigure

    defaultLocale = EmberCart.config.get('defaultLocale') || 'en'
    locale = 'locales.' + defaultLocale
    Ember.I18n.translations = EmberCart.config.get(locale)
