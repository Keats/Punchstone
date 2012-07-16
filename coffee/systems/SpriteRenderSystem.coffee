
P.systems.SpriteRenderSystem = {}

#A sprite is rendered at a position X,Y using an animation usually
class SpriteRenderSystem extends P.Artemis.EntityProcessingSystem

  constructor: () ->
    super "Sprite", "Position"


  initialize: () ->
    @positionMapper = new P.Artemis.ComponentMapper "Position", @world
    @spriteMapper = new P.Artemis.ComponentMapper "Sprite", @world
  

  #We render the frame for the sprite at the right position
  processEntity: (entity) ->
    position = @positionMapper.get entity
    sprite = @spriteMapper.get entity

    #If there's an animation going on right now
    if sprite._currentAnimation
      #If we need to change frame
      if sprite._timeSinceLastUpdate >= sprite._currentAnimation.frameTime
        tile = @nextFrame sprite

        sprite._timeSinceLastUpdate = 0

      else
        tile = sprite._currentAnimation.frames[sprite._currentFrame]
        sprite._timeSinceLastUpdate += @world.delta

      #TODO : optimize this (dirty rectangles) so we only draw if needed
      @draw position, sprite, tile

    else
      sprite._currentAnimation = sprite.animations["idle"]


  #Gets the next frame or rewinds if it was the last one
  nextFrame: (sprite) ->
    sprite._currentFrame = (sprite._currentFrame + 1) % sprite._currentAnimation.frames.length
    tile = sprite._currentAnimation.frames[sprite._currentFrame]
    
    tile


  #Draw the tile of the spritesheet at the position given
  draw: (position, sprite, tile) ->
    #P.canvas.context.clearRect position.x, position.y, sprite.width, sprite.height

    startingX = (tile % sprite.numberTilesPerRow) * sprite.width
    startingY = Math.floor(tile / sprite.numberTilesPerRow) * sprite.height
    image = P.scene.loadedAssets.images[sprite.spritesheetName]

    P.canvas.context.drawImage(image, startingX, startingY, sprite.width, sprite.height, 
      position.x, position.y, sprite.width, sprite.height)



P.systems.SpriteRenderSystem = SpriteRenderSystem