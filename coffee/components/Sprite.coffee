
P.components.Sprite = {}


class Sprite extends P.Artemis.Component


  constructor: (@spritesheetName, @width, @height, @numberTilesPerRow) ->
    @animations = {}

    @currentAnimation = ""
    @_currentFrame = 0
    @_timeSinceLastUpdate = 0
    @flipped = false
    @_nextFrame = false


  #At first, wanted to create a separate component for animations
  #TODO : think about if it's worth it or not
  addAnimation: (name, frameTime, frames) ->
    @animations[name] =
      frameTime: frameTime
      frames: frames


  #Changes which animation is currently played
  #Automotic means if the anim is played in loop automatically of if the anim changes on input for ex
  play: (name, automatic = false) ->
    if @currentAnimation isnt @animations[name]
      @currentAnimation = @animations[name]
      @_currentFrame = 0
      @_timeSinceLastUpdate = 0
      @flipped = false
      @_automatic = automatic
    
    @_nextFrame = true


P.components.Sprite = Sprite