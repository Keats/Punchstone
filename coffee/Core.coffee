

Core =
  #Start the game !
  start: (canvasId, width, height, gameClass) ->
    P.canvas = new P.Canvas canvasId, width, height

    game = new gameClass()

    loader = new P.Loader game

    couldntLoad = loader._load()

    if not couldntLoad
      #start the game
      game.run()
    else
      #display an error
      console.log 'oops'



P.start = Core.start