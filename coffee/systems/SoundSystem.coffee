
P.systems.SoundSystem = {}

#Plays a short sound that can be repeated quickly, not a music
#Best way to use it is to create a SoundEntity with the Sound component
#This way the entity only exists to play the sound and is deleted right away
class SoundSystem extends P.Artemis.EntityProcessingSystem

  constructor: () ->
    super "Sound"

    #We need to create clones of the sounds elements to deal with some html5 quirk
    #On some browsers, you can't play several times the same sound quickly
    @sounds = {}
    @channels = 4
    @indexes = {}


  initialize: () ->
    @soundMapper = new P.Artemis.ComponentMapper "Sound", @world
  
  #We delete the sound entity when it's this system turn to process
  #(sound played in added function)
  processEntity: (entity) ->
    @world.deleteEntity entity


  #We play the sound when the entity is created
  added: (entity) ->
    sound = @soundMapper.get entity
    name = sound.name

    console.log 'la'

    #Need to create some clones to act as channels
    #Copying first in the system so we don't need to access the P.scene object for this sound
    if name not of @sounds
      @sounds[name] = []
      @indexes[name] = 0

      for channel in [@channels..1]
        @sounds[name].push P.scene.loadedAssets.sounds[name].cloneNode(true)

    #Quite horrible
    soundToPlay = @sounds[name][@indexes[name]]
    console.log 'should play'
    soundToPlay.play()
    @indexes[name] = (@indexes[name] + 1) % @sounds[name].length


P.systems.SoundSystem = SoundSystem