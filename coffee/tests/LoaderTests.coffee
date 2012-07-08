
describe "Loader", ->

  describe "Loading valid sounds", ->

    data = ["assets/sounds/kill1.mp3", "assets/sounds/song.mp3", "assets/sounds/test.mp3"]
    loader = null

    before () ->
      game = 
        assets: data

      loader = new P.Loader game
      loader._load()

    it "should have loaded 3 sounds", ->
      Object.keys(loader.sounds).should.have.length 3
    it "should not have any sounds he couldn't load", ->
      loader.hasOwnProperty("couldntLoad").should.be.false


  describe "Loading valid and invalid sounds", ->

    data = ["assets/sounds/kill1.mp3", "assets/sounds/song.mp3", "assets/sounds/test.mp4"]
    loader = null
    couldntLoad = null

    before () ->
      game = 
        assets: data
      loader = new P.Loader game
      couldntLoad = loader._load()

    it "should have loaded 2 sounds", ->
      Object.keys(loader.sounds).should.have.length 2
    it "should have 1 sound it couldn't load", ->
      couldntLoad.should.have.length 1


  describe "Loading valid images", ->

    data = ["assets/images/tileset.png"]
    loader = null

    before () ->
      game = 
        assets: data

      loader = new P.Loader game
      couldntLoad = loader._load()

    it "should have loaded 1 image", ->
      Object.keys(loader.images).should.have.length 1

     
  describe "Loading valid and invalid images", ->

    data = ["assets/images/tileset.png", "assets/images/tileset.bmp"]
    loader = null
    couldntLoad = null

    before () ->
      game = 
        assets: data

      loader = new P.Loader game
      couldntLoad = loader._load()

    it "should have loaded 1 image", ->
      Object.keys(loader.images).should.have.length 1
    it "should have 1 image it couldn't load", ->
      couldntLoad.should.have.length 1

     
  describe "Loading sounds and images", ->

    data = ["assets/sounds/kill1.mp3", "assets/sounds/song.mp3", "assets/images/tileset.png", "assets/sounds/test.mp3"]
    loader = null
    couldntLoad = null

    before () ->
      game = 
        assets: data

      loader = new P.Loader game
      couldntLoad = loader._load()

    it "should have loaded 1 image", ->
      Object.keys(loader.images).should.have.length 1
    it "should have loaded 3 sounds", ->
      Object.keys(loader.sounds).should.have.length 3
    it "should not have any assets he couldn't load", ->
      loader.hasOwnProperty("couldntLoad").should.be.false


  describe "Loading files without extension", ->

    data = ["assets/sounds/kill1", "assets/sounds/song"]
    loader = null
    couldntLoad = null

    before () ->
      game = 
        assets: data

      loader = new P.Loader game
      couldntLoad = loader._load()

    it "should not have loaded any assets", ->
      Object.keys(loader.images).should.have.length 0
    it "should have 2 assets it couldn't load", ->
      couldntLoad.should.have.length 2


  describe "Accessing the assets loaded", ->

    data = ["assets/sounds/kill1.mp3", "assets/images/tileset.png"]
    loader = null
    couldntLoad = null

    before () ->
      game = 
        assets: data

      loader = new P.Loader game
      couldntLoad = loader._load()
      
    it "should have an instance of Audio", ->
      loader.sounds["kill1.mp3"].should.be.an.instanceof Audio
    it "should have an instance of Image", ->
      loader.images["tileset.png"].should.be.an.instanceof Image