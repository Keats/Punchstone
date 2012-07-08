
P.Util = {}

Util =

  addEventHandling: (destination) ->
    destination.on = P.Events.addEventListener
    destination.off = P.Events.removeEventListener
    destination.fire = P.Events.fireEvent
    destination.hasEventListeners = P.Events.hasEventListeners



P.Util = Util