#= require ../../utils

DS.attr.transforms.money =
  from: (serialized) ->
    parseFloat(serialized) unless Em.none(serialized)

  to: (deserialized) ->
    round(deserialized, 2) unless Em.none(deserialized)
