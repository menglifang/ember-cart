EmberCart.store = DS.Store.create
  revision: 4
  adapter: DS.RESTAdapter.create(bulkCommit: false, namespace: 'ember_cart')
