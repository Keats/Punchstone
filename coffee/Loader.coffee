
P.Loader = {}

class Loader

  #Which extension do we allow for the files to be loaded
  #TODO : add mime type check
  _imagesExtensions = ['png', 'jpeg', 'jpg']

  #Holds the extensions the user's browser can play
  _canPlay = []


  constructor: (scene) ->
    @scene = scene

    #Use to display progression
    @totalToLoad = @scene.assets.sounds.length + @scene.assets.images.length
    
    @loaded = 0

    #store assets as objects with index being the filename
    @images = {}
    @sounds = {}

    #Adds support for events
    P.Util.addEventHandling @

    @.on "loaded", @_eventFileLoaded


  #Called when a file has been successfully loaded
  _eventFileLoaded: () ->
    @loaded++
    @draw()


  #Loads an array of assets, whether it's an image or a sound
  _load: () ->
    couldntLoad = []

    for file in @scene.assets.images      
      extension = file.substr(file.lastIndexOf(".") + 1).toLowerCase()
      name = file.substr(file.lastIndexOf("/") + 1).toLowerCase()

      if extension in _imagesExtensions
        #Load image if it's not already loaded
        if not @images[name]
          @images[name] = @_loadImage file
          @.fire "loaded"
        else 
          couldntLoad.push file


    for file in @scene.assets.sounds      
      name = file.substr(file.lastIndexOf("/") + 1).toLowerCase()

      if not @sounds[name]
        #We detected which one we should use between mp3 and ogg
        file = file + "." + P.detect.preferedAudioFormat
        @sounds[name] = @_loadSound file
        @.fire "loaded"
      else
        #Oups can't play this, fallback to something else
        #TODO : fallback for audio, flash ?
        couldntLoad.push file


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
  _loadImage: (file) ->
    image = new Image()
    image.src = file

    image


  #Draw the advancement of the loading
  draw: () ->
    percentage = Math.round((@loaded / @totalToLoad) * 100) + " %"
    
    P.canvas.clear()
    P.canvas.context.fillStyle = "#00f"
    P.canvas.context.fillText percentage, P.canvas.centerX, P.canvas.centerY



P.Loader = Loader