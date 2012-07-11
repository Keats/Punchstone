P.Canvas = {}

#Class that controls the canvas for resize, clear and everything 
class Canvas
  
  constructor: (canvasId, width, height) ->
    @element = document.getElementById canvasId
    @element.width = width
    @element.height = height
    @context = @element.getContext('2d')
    
    @centerX = width / 2
    @centerY = height / 2


  #Clears the canvas
  clear: () ->
    @element.width = @element.width


  drawRandomCircle: () ->
    x = P.Util.randomInRange 0, @element.width
    y = P.Util.randomInRange 0, @element.height

    @context.beginPath()
    @context.arc(x, y, 10, 0, 2 * Math.PI, false)
    @context.fillStyle = "rgb(255, 0, 0)"
    @context.fill()


P.Canvas = Canvas