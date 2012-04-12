window.Factory =
  store: null
  factories: {}

  define: (name, opts, fn)->
    config = {}
    fn.call @, config

    Factory.factories[name] = { id: 0 }
    Factory.factories[name]['opts'] = opts
    Factory.factories[name]['defaults'] = config

  create: (name, config)->
    object = Factory.attributeFor(name, config)
    object.id = Factory.generateId(name) unless object.id
    
    opts = Factory.factories[name]['opts']
    klass = opts['class']

    Factory.store.load(klass, object)
    Factory.store.find(klass, object.id)

  attributeFor: (name, config)->
    factory = Factory.factories[name]
    defaults = factory['defaults']

    apply({}, config, defaults)

  generateId: (name)->
    factory = Factory.factories[name]
    factory.id = factory.id + 1

