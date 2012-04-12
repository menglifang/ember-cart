#= require jquery
#= require jquery_ujs
#
#= require ember
#= require ember-data
#= require ember-i18n
#
#= require Faker
#= require sinon
#
#= require_self
#
#= require ember_cart/config/app
#
#= require_tree ./support
#= require_tree ./factories

jQuery ->
  jQuery("#konacha").append('<div id="ember-cart"></div>')
