
root = this

original_P = root.P
P = undefined


if typeof exports isnt "undefined"
  P = exports
else
  P = original_P = {}
  #Using that to store everything not from the game engine
  P.my = {}
  #Storing libs in the P namespace to avoid confusion
  P.Artemis = root.Artemis
  P.soundManager = root.soundManager
  
  root.P = P


P.VERSION = "0.0.1"