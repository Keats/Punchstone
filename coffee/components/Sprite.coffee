
P.components.Sprite = {}


class Sprite extends P.Artemis.Component


  constructor: (@spritesheetName, @width, @height, @numberTilesPerRow) ->
    @animations = {}

    @_currentAnimation = ""
    @_currentFrame = 0
    @_timeSinceLastUpdate = 0


  #At first, wanted to create a separate component for animations
  #TODO : think about if it's worth it or not
  addAnimation: (name, frameTime, frames) ->
    @animations[name] =
      frameTime: frameTime
      frames: frames



P.components.Sprite = Sprite