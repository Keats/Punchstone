
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
    


  #process systems that renders
  draw: () ->


  run: =>
    if not @lastRun
      @lastRun = new Date().getTime()
      requestAnimFrame @run 
      return

    @world.delta = (new Date().getTime() - @lastRun) / 1000
    @lastRun = new Date().getTime()
    @fps = P.Util.round(1 / @world.delta)

    P.canvas.clear()

    @update()
    @draw()

    if @displayStats
      P.canvas.displayStats()

    requestAnimFrame @run 


P.Scene = Scene