

Core =
  #Start the game !
  start: (canvasId, width, height, sceneClass) ->
    #Object controling the canvas element
    P.canvas = new P.Canvas canvasId, width, height

    #Detecting all the clients info
    P.detect = new P.Detector()

    scene = new sceneClass()

    loader = new P.Loader scene
    couldntLoad = loader._load()


    #TODO : create a static class doing all the shims/setup of plugins
    #shim for requestAnimationFrame
    window.requestAnimFrame = (->
      #
      # requestAnim shim layer by Paul Irish
      #
      # http://paulirish.com/2011/requestanimationframe-for-smart-animating/
      #
          
      window.requestAnimationFrame       || 
      window.webkitRequestAnimationFrame || 
      window.mozRequestAnimationFrame    || 
      window.oRequestAnimationFrame      || 
      window.msRequestAnimationFrame     || 
      (callback, element) ->
        window.setTimeout(callback, 1000 / 60)
    )()

    if not couldntLoad
      #start the game
      P.canvas.clear()
      scene.run()
    else
      #display an error
      console.log couldntLoad
      console.log 'oops'



P.start = Core.start