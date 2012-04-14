#= require_tree ../lib
#
#= require ../ember/app
#
#= require_tree ./locales

EmberCart.configure (config) ->
  #config.set 'locales.en', EmberCart.locales.en
  #config.set 'locales.zh_CN', EmberCart.locales.zh_CN

  config.set 'defaultLocale', 'en'

