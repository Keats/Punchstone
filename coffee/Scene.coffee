
P.Scene = {}


#Creates entities/components/systems here
#Update/Draw loops are here too
#Should be extended
class Scene

  #Used to initalize the game
  #bind inputs, load level etc
  constructor: () ->
    @fps = 0
    @displayStats = false
    @lastRun = null
    @world = new P.Artemis.EntityWorld()


  #process systems
  update: () ->    
    @world.loopStart()
    #process entities
    @world.systemManager.updateSynchronous("update")
    


  #process systems that renders
  draw: () ->
    #draw systems
    @world.systemManager.updateSynchronous("draw")


  run: =>
    if not @lastRun
      @lastRun = new Date().getTime()
      requestAnimFrame @run 
      return

    @world.delta = (new Date().getTime() - @lastRun) / 1000
    @lastRun = new Date().getTime()
    @fps = P.Util.round(1 / @world.delta)

    #TODO : redraw only what's necessary
    P.canvas.clear()

    @update()
    @draw()

    P.input.clearInput()
    
    if @displayStats
      P.canvas.displayStats()

    requestAnimFrame @run 


P.Scene = Scene