
describe "Events", ->

  describe "Attaching events to an object", ->

    loader = null

    before () ->
      game = 
        assets: ''
      loader = new P.Loader game

    it "should have an on function", ->
      loader.on.should.be.an.instanceof Function
    it "should have an off function", ->
      loader.off.should.be.an.instanceof Function
    it "should have a hasEventListeners function", ->
      loader.hasEventListeners.should.be.an.instanceof Function
    it "should have a fire function", ->
      loader.fire.should.be.an.instanceof Function
