
P.Util = {}

Util =

  addEventHandling: (destination) ->
    destination.on = P.Events.addEventListener
    destination.off = P.Events.removeEventListener
    destination.fire = P.Events.fireEvent
    destination.hasEventListeners = P.Events.hasEventListeners


  randomInRange: (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

  #Faster than Math.round
  round: (number) ->
    (0.5 + number) << 0


P.Util = Util