
P.components.Sprite = {}


class Sprite extends P.Artemis.Component


  constructor: (@spritesheetName, @spritesheetSizeX, @spritesheetSizeY) ->
    @animations = {}
    @currentAnim = ""
    @_currentFrame = 0
    @_timeSinceLastUpdate = 0


  #At first, wanted to create a separate component for animations
  #TODO : think about if it's worth it or not
  addAnimation: (name, frameTime, startFrame, endFrame) ->
    @animations[name] =
      frameTime: frameTime
      start: startFrame
      end: endFrame
      length: endFrame - startFrame
  

P.components.Sprite = Sprite