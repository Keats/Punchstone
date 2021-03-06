// Generated by CoffeeScript 1.3.3
(function() {

  describe("Events", function() {
    return describe("Attaching events to an object", function() {
      var loader;
      loader = null;
      before(function() {
        var game;
        game = {
          assets: ''
        };
        return loader = new P.Loader(game);
      });
      it("should have an on function", function() {
        return loader.on.should.be.an["instanceof"](Function);
      });
      it("should have an off function", function() {
        return loader.off.should.be.an["instanceof"](Function);
      });
      it("should have a hasEventListeners function", function() {
        return loader.hasEventListeners.should.be.an["instanceof"](Function);
      });
      return it("should have a fire function", function() {
        return loader.fire.should.be.an["instanceof"](Function);
      });
    });
  });

}).call(this);
