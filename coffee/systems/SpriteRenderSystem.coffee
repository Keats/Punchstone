
P.systems.SpriteRenderSystem = {}

#A sprite is rendered at a position X,Y using an animation usually
class SpriteRenderSystem extends P.Artemis.EntityProcessingSystem

  constructor: () ->
    super "Sprite", "Position"

    #We store some info on the animations so we don't have to do the calculations again
    @spritesheets = {}


  initialize: () ->
    @positionMapper = new P.Artemis.ComponentMapper "Position", @world
    @spriteMapper = new P.Artemis.ComponentMapper "Sprite", @world
  

  #We render the frame for the sprite at the right position
  processEntity: (entity) ->
    position = @positionMapper.get entity
    sprite = @spriteMapper.get entity

    if sprite.spritesheetName not of @spritesheets
      @normalizeSpritesheet sprite

    #If there's an animation going on right now
    if sprite.currentAnim
      #If we need to change frame
      if sprite._timeSinceLastUpdate >= (sprite.animations[sprite.currentAnim].frameTime)
        #Should we go back to the beginning or not
        if @isNextFrameInAnimation sprite          
          sprite._currentFrame++
        else
          sprite._currentFrame = 0

        sprite._timeSinceLastUpdate = 0
        

      else
        sprite._timeSinceLastUpdate += @world.delta

    else
      sprite.currentAnim = "idle"

    #TODO : rendered even if there are no changes in the anim, that sucks
    @draw(sprite, position)
    


  #Calculates infos on the sprite such as size, number of rows/columns
  normalizeSpritesheet: (sprite) ->
    image = P.scene.loadedAssets.images[sprite.spritesheetName]

    numberOfColumns = image.width / sprite.spritesheetSizeX
    numberOfRows = image.height / sprite.spritesheetSizeY

    @spritesheets[sprite.spritesheetName] =
      width: image.width
      height: image.height
      rows: numberOfRows
      columns: numberOfColumns


  #Checks whether the next frame is in the animation or if it should restart from the beginning
  isNextFrameInAnimation: (sprite) ->
    inAnim = false

    #Is the next frame in anim ?
    if sprite.animations[sprite.currentAnim].start <= sprite._currentFrame + 1 <= sprite.animations[sprite.currentAnim].end
      inAnim = true

    inAnim


  #Draws the sprite to the canvas
  draw: (sprite, position) ->
    image = P.scene.loadedAssets.images[sprite.spritesheetName]
    spritesheet = @spritesheets[sprite.spritesheetName]

    row = 0
    column = 0
    frame = 0

    until row is spritesheet.rows
      until column is (spritesheet.columns - 1)
        if frame is sprite._currentFrame
          break
        else
          frame++

        column++

      row++

    #Ugly but otherwise go up to 1 even if there's only 1 line
    row--


    P.canvas.context.drawImage(image, column*64, row*64, 64, 64, 
      position.x, position.y, 64, 64);


P.systems.SpriteRenderSystem = SpriteRenderSystem