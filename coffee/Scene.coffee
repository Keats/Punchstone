
P.Scene = {}


#Creates entities/components/systems here
#Update/Draw loops are here too
#Should be extended
class Scene

  #Used to initalize the game
  #bind inputs, load level etc
  constructor: () ->


  #process systems
  update: () ->
    


  #process systems that renders
  draw: () ->


  run: =>
    requestAnimFrame @run 
    @update()
    @draw()
    #setInterval(@run, 1)


P.Scene = Scene