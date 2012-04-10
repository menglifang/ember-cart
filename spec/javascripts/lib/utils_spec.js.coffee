#= require ember_cart/lib/utils

describe 'Utils', ->
  describe 'round', ->
    it 'rounds float to fixed decimal digits', ->
      round(10, 2).should.equal("10.00")

    it 'rounds a float down', ->
      round(10.004, 2).should.equal("10.00")

    it 'rounds a float up', ->
      round(10.005, 2).should.equal("10.01")
