
P.Game = {}


#Creates entities/components/systems here
#Update/Draw loops are here too
#Should be extended
class Game

  #Used to initalize the game
  #bind inputs, load level etc
  constructor: () ->


  run: () ->
    @update()
    @draw()


  #process systems
  update: () ->


  #process systems that renders
  draw: () ->


P.Game = Game