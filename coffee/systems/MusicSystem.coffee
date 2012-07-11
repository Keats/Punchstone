
P.systems.MusicSystem = {}

#A music is a sound that is repeated continuously with fade in/ fade out
class MusicSystem extends P.Artemis.EntityProcessingSystem

  constructor: () ->
    super "Music"

    #Keeping reference, since we fade out/in when changing music
    @currentMusicName = ""
    @currentMusicObject = null

  initialize: () ->
    @musicMapper = new P.Artemis.ComponentMapper "Music", @world
  
  #We don't do anything when processing except if music has changed
  processEntity: (entity) ->
    music = @musicMapper.get entity

    #If the new music is different
    if @currentMusicName isnt music.name or ""
      #We need to fadeout the current music !
      @fadeOutInterval = @fadeOut @currentMusicObject

      #Clearing the intervals !
      if @fadeInInterval
        clearInterval(@fadeInInterval)
      if @fadeOutInterval
        clearInterval(@fadeOutInterval)

      #Playing with fade in
      @playWithFadeIn music



  #We play the sound when the entity is created
  added: (entity) ->
    music = @musicMapper.get entity

    @playWithFadeIn music


  #Actually plays the sound, setup the looping and the fade in
  playWithFadeIn: (music) ->
    musicObject =  P.scene.loadedAssets.sounds[music.name]

    #Storing the name for reference if we change the music
    @currentMusicName = music.name
    @currentMusicObject = musicObject

    musicObject.volume = 0
    musicObject.loop = true

    @fadeInInterval = @fadeIn(musicObject)
    musicObject.play()

    #Might be needed if a browser doesn't support loop, which one ?
    ###
    musicObject.addEventListener "ended", =>
      if intervalId
        clearInterval(intervalId)
        intervalId = null
      musicObject.play()
    , false
    ###



  #Creates a fadeIn effect, change the step to experiment
  fadeIn: (music) ->
    setInterval =>
      step = 0.02
      volume = music.volume + step
      if volume < 1 - step
        music.volume = volume
      else
        music.volume = 1
    , 30


  #Used when the music changes
  fadeOut: (music) ->
    setInterval =>
      step = 0.02
      volume = music.volume - step
      if volume >= step
        music.volume = volume
      else
        music.volume = 0
    , 30


P.systems.MusicSystem = MusicSystem