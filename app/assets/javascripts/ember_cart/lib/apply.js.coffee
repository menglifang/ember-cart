# Copies all the properties of config to the specified object.
# @param {Object} object The receiver of the properties
# @param {Object} config The source of the properties
# @param {Object} defaults A different object that will also be applied for default values
# @return {Object} returns obj
window.apply = (object, config, defaults)->
  apply(object, defaults) if defaults

  if object && config && typeof config == 'object'
    for k, v of config
      object[k] = v

  object

# Copies all the properties of config to object if they don't already exist.
# @param {Object} object The receiver of the properties
# @param {Object} config The source of the properties
# @return {Object} returns obj
window.applyIf = (object, config)->
  if object
    for k, v of config
      object[k] = v if object[k] == undefined

  object
