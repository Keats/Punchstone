
P.Input = {}
P.Keys = {}

#All the useful keys on a keyboard
keys =
  LEFT: 37
  UP: 38
  RIGHT: 39
  DOWN: 40
  ENTER: 13
  SHIFT: 16
  CTRL: 17
  ALT: 18
  PAUSE: 19
  ESC: 27
  SPACE: 32
  NUM0: 48
  NUM1: 49
  NUM2: 50
  NUM3: 51
  NUM4: 52
  NUM5: 53
  NUM6: 54
  NUM7: 55
  NUM8: 56
  NUM9: 57
  A: 65
  B: 66
  C: 67
  D: 68
  E: 69
  F: 70
  G: 71
  H: 72
  I: 73
  J: 74
  K: 75
  L: 76
  M: 77
  N: 78
  O: 79
  P: 80
  Q: 81
  R: 82
  S: 83
  T: 84
  U: 85
  V: 86
  W: 87
  X: 88
  Y: 89
  Z: 90

P.Keys = keys


class Input

  constructor: () ->
    #the bindings key/action
    @bindings = {}
    #Which key are pressed right now
    @pressed = {}

    window.addEventListener "keydown", @keydown, false
    window.addEventListener "keyup", @keyup, false


  #Binds an input to an action, like A, "attack"
  bind: (input, action) ->
    @bindings[input] = action


  #Removes a binding
  unbind: (input) ->
    delete @bindings[input]


  keydown: (event) ->
    action = P.input.bindings[event.keyCode]
    P.input.pressed[action] = true

    event.stopPropagation()
    event.preventDefault()


  keyup: (event) ->
    #do something here?
    event.stopPropagation()
    event.preventDefault()


  activated: (action) ->
    @pressed[action]


  clearInput: () ->
    @pressed = {}




P.Input = Input