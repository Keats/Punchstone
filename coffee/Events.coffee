
P.Events = {}

Events =

  #Adds an event to the current object, signature is something like "loaded", Function
  addEventListener: (type, callback) ->
    events = @["_events"] = @["_events"] or {}
    
    events[type] = events[type] or []
    events[type].push callback


  removeEventListener: (type, callback) ->
    events = @["_events"]

    if callback in events[type]
      index = events[type].indexOf callback
      events[type].splice index, 1


  #Checks if the event exists
  hasEventListeners: (type) ->
    @["_events"]? and @["_events"][type]? and @["_events"][type].length > 0


  #Fires the event with the data given if it exists
  fireEvent: (type, data) ->
    if not @hasEventListeners type
      return @

    for callback in @["_events"][type]
      #Using the callback the data
      callback.call @, data
      

P.Events = Events