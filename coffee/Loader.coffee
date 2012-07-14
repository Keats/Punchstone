
P.Loader = {}

class Loader

  #Which extension do we allow for the files to be loaded
  #TODO : add mime type check? extensions should be enough
  _imagesExtensions = ['png', 'jpeg', 'jpg']

  constructor: (scene) ->
    @scene = scene

    #Use to display progression
    @totalToLoad = @scene.assets.sounds.length + @scene.assets.images.length
    
    @loaded = 0
    @finished = false

    #store assets as objects with index being the filename in the scene
    @scene.loadedAssets = {}
    @scene.loadedAssets.images = {}
    @scene.loadedAssets.sounds = {}

    #Adds support for events
    P.Util.addEventHandling @

    @.on "loaded", @_eventFileLoaded


  #Called when a file has been successfully loaded
  _eventFileLoaded: () ->
    @loaded++
    @draw()

    if @loaded is @totalToLoad
      @finished = true


  #Loads an array of assets, whether it's an image or a sound
  #TODO : quite ugly now with onload event for the images
  _load: () ->
    couldntLoad = []

    for image in @scene.assets.images   
      extension = image.substr(image.lastIndexOf(".") + 1).toLowerCase()
      imageName = image.substr(image.lastIndexOf("/") + 1).toLowerCase()

      if extension in _imagesExtensions
        #Load image if it's not already loaded
        if not @scene.loadedAssets.images[imageName]
          #Async because if we don't wait, we won't get the image size otherwise
          @_loadImage image, imageName, (image, name) =>
            @scene.loadedAssets.images[name] = image
            @.fire "loaded"
        else 
          couldntLoad.push image


    for audio in @scene.assets.sounds      
      audioName = audio.substr(audio.lastIndexOf("/") + 1).toLowerCase()

      if not @scene.loadedAssets.sounds[audioName]
        #We detected which one we should use between mp3 and ogg
        audio = audio + "." + P.detect.preferedAudioFormat
        @scene.loadedAssets.sounds[audioName] = @_loadSound audio
        @.fire "loaded"
      else
        #Oups can't play this, fallback to something else
        #TODO : fallback for audio, flash ?
        couldntLoad.push audio


    if couldntLoad.length > 0
      return couldntLoad


  #Preloads a sound
  _loadSound: (file) ->
    sound = new Audio()
    sound.preload = "auto"
    sound.volume = 1
    sound.src = file

    sound


  #Preloads an image
  _loadImage: (file, name, callback) ->
    image = new Image()
    image.src = file

    image.onload = ->
      callback image, name


  #Draw the advancement of the loading
  draw: () ->
    percentage = Math.round((@loaded / @totalToLoad) * 100) + " %"
    
    P.canvas.clear()
    P.canvas.context.fillStyle = "#00f"
    P.canvas.context.fillText percentage, P.canvas.centerX, P.canvas.centerY



P.Loader = Loader