
P.Loader = {}

class Loader

  #Which extension do we allow for the files to be loaded
  #TODO : add mime type check
  _imagesExtensions = ['png', 'jpeg', 'jpg']
  _soundsExtensions = ['ogg', 'mp3']

  #Holds the extensions the user's browser can play
  _canPlay = []


  constructor: (game) ->
    @game = game

    #Use to display progression
    @totalToLoad = @game.assets.length
    @loaded = 0

    #store assets as objects with index being the filename
    @images = {}
    @sounds = {}

    #Adds support for events
    P.Util.addEventHandling @

    @.on "loaded", @eventFileLoaded


  #Pushes the format the user browser can play to _canPlay aray
  _detectAudioFormat: () ->
    userAudio = document.createElement('audio')

    if !!userAudio.canPlayType      
      if "" isnt userAudio.canPlayType 'audio/mpeg;' then _canPlay.push "mp3"
      if "" isnt userAudio.canPlayType 'audio/ogg;' then _canPlay.push "ogg"


  #Called when a file has been successfully loaded
  eventFileLoaded: () ->
    @loaded++
    @draw()


  #Loads an array of assets, whether it's an image or a sound
  _load: () ->
    #First we check which audio format the user can play
    @_detectAudioFormat()

    couldntLoad = []

    for file in @game.assets
      extension = file.substr(file.lastIndexOf(".") + 1).toLowerCase()
      name = file.substr(file.lastIndexOf("/") + 1).toLowerCase()

      if extension in _imagesExtensions
        #Load image if it's not already loaded
        if not @images[name]
          @images[name] = @_loadImage file
          @.fire "loaded"

      else if extension in _soundsExtensions  
        #If the browser can play the sound and it's not already loaded, load it
        if extension in _canPlay and not @sounds[name]
          @sounds[name] = @_loadSound file
          @.fire "loaded"
        else
          #Oups can't play this, fallback to something else
          #TODO : fallback for audio, flash ?
          couldntLoad.push file

      else
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