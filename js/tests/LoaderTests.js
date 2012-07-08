// Generated by CoffeeScript 1.3.3
(function() {

  describe("Loader", function() {
    describe("Loading valid sounds", function() {
      var data, loader;
      data = ["assets/sounds/kill1.mp3", "assets/sounds/song.mp3", "assets/sounds/test.mp3"];
      loader = null;
      before(function() {
        var game;
        game = {
          assets: data
        };
        loader = new P.Loader(game);
        return loader._load();
      });
      it("should have loaded 3 sounds", function() {
        return Object.keys(loader.sounds).should.have.length(3);
      });
      return it("should not have any sounds he couldn't load", function() {
        return loader.hasOwnProperty("couldntLoad").should.be["false"];
      });
    });
    describe("Loading valid and invalid sounds", function() {
      var couldntLoad, data, loader;
      data = ["assets/sounds/kill1.mp3", "assets/sounds/song.mp3", "assets/sounds/test.mp4"];
      loader = null;
      couldntLoad = null;
      before(function() {
        var game;
        game = {
          assets: data
        };
        loader = new P.Loader(game);
        return couldntLoad = loader._load();
      });
      it("should have loaded 2 sounds", function() {
        return Object.keys(loader.sounds).should.have.length(2);
      });
      return it("should have 1 sound it couldn't load", function() {
        return couldntLoad.should.have.length(1);
      });
    });
    describe("Loading valid images", function() {
      var data, loader;
      data = ["assets/images/tileset.png"];
      loader = null;
      before(function() {
        var couldntLoad, game;
        game = {
          assets: data
        };
        loader = new P.Loader(game);
        return couldntLoad = loader._load();
      });
      return it("should have loaded 1 image", function() {
        return Object.keys(loader.images).should.have.length(1);
      });
    });
    describe("Loading valid and invalid images", function() {
      var couldntLoad, data, loader;
      data = ["assets/images/tileset.png", "assets/images/tileset.bmp"];
      loader = null;
      couldntLoad = null;
      before(function() {
        var game;
        game = {
          assets: data
        };
        loader = new P.Loader(game);
        return couldntLoad = loader._load();
      });
      it("should have loaded 1 image", function() {
        return Object.keys(loader.images).should.have.length(1);
      });
      return it("should have 1 image it couldn't load", function() {
        return couldntLoad.should.have.length(1);
      });
    });
    describe("Loading sounds and images", function() {
      var couldntLoad, data, loader;
      data = ["assets/sounds/kill1.mp3", "assets/sounds/song.mp3", "assets/images/tileset.png", "assets/sounds/test.mp3"];
      loader = null;
      couldntLoad = null;
      before(function() {
        var game;
        game = {
          assets: data
        };
        loader = new P.Loader(game);
        return couldntLoad = loader._load();
      });
      it("should have loaded 1 image", function() {
        return Object.keys(loader.images).should.have.length(1);
      });
      it("should have loaded 3 sounds", function() {
        return Object.keys(loader.sounds).should.have.length(3);
      });
      return it("should not have any assets he couldn't load", function() {
        return loader.hasOwnProperty("couldntLoad").should.be["false"];
      });
    });
    describe("Loading files without extension", function() {
      var couldntLoad, data, loader;
      data = ["assets/sounds/kill1", "assets/sounds/song"];
      loader = null;
      couldntLoad = null;
      before(function() {
        var game;
        game = {
          assets: data
        };
        loader = new P.Loader(game);
        return couldntLoad = loader._load();
      });
      it("should not have loaded any assets", function() {
        return Object.keys(loader.images).should.have.length(0);
      });
      return it("should have 2 assets it couldn't load", function() {
        return couldntLoad.should.have.length(2);
      });
    });
    return describe("Accessing the assets loaded", function() {
      var couldntLoad, data, loader;
      data = ["assets/sounds/kill1.mp3", "assets/images/tileset.png"];
      loader = null;
      couldntLoad = null;
      before(function() {
        var game;
        game = {
          assets: data
        };
        loader = new P.Loader(game);
        return couldntLoad = loader._load();
      });
      it("should have an instance of Audio", function() {
        return loader.sounds["kill1.mp3"].should.be.an["instanceof"](Audio);
      });
      return it("should have an instance of Image", function() {
        return loader.images["tileset.png"].should.be.an["instanceof"](Image);
      });
    });
  });

}).call(this);