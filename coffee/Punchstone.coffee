
root = this

original_P = root.P
P = undefined


if typeof exports isnt "undefined"
  P = exports
else
  P = original_P = {}
  #Using that to store everything not from the game engine
  P.my = {}
  root.P = P


P.VERSION = "0.0.1"