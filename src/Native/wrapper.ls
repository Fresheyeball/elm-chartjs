Elm.Native = Elm.Native || {}
Elm.Native.Chartjs = Elm.Native.Chartjs || {}
make = -> Elm.Native.Chartjs = make : it

localRuntime <- make
localRuntime.Native = localRuntime.Native || {}
localRuntime.Native.Chartjs = localRuntime.Native.Chartjs || {}
return v if v = localRuntime.Native.Chartjs.values

NativeElement = Elm.Native.Graphics.Element.make localRuntime

createNode = (elementType) ->
  n = document.createElement elementType
  n.style.padding = 0
  n.style.margin = 0
  n.style.position = "relative"
  return n

makeCanvas = (w, h) ->
  canvas = NativeElement.createNode 'canvas'
  canvas.style.width  = w + 'px'
  canvas.style.height = h + 'px'
  /*canvas.style.display = "block"
  canvas.style.position = "absolute"*/
  ratio = window.devicePixelRatio || 1
  canvas.width  = w * ratio
  canvas.height = h * ratio
  return canvas


data =
  labels: ["January", "February", "March", "April", "May", "June", "July"]
  datasets: [
    {
      label: "My First dataset"
      fillColor: "rgba(220,220,220,0.2)"
      strokeColor: "rgba(220,220,220,1)"
      pointColor: "rgba(220,220,220,1)"
      pointStrokeColor: '#fff'
      pointHighlightFill: '#fff'
      pointHighlightStroke: "rgba(220,220,220,1)"
      data: [65, 59, 80, 81, 56, 55, 40]
    },
    {
      label: "My Second dataset"
      fillColor: "rgba(151,187,205,0.2)"
      strokeColor: "rgba(151,187,205,1)"
      pointColor: "rgba(151,187,205,1)"
      pointStrokeColor: '#fff'
      pointHighlightFill: '#fff'
      pointHighlightStroke: "rgba(151,187,205,1)"
      data: [28, 48, 40, 19, 86, 27, 90]
    }
  ]

update = (n, _, __) -> n

render = ({w, h}) ->
  wrap = createNode "div"
  wrap.style.width = w + 'px'
  wrap.style.height = h + 'px'
  n = makeCanvas w, h
  wrap.appendChild n
  chart = new Chart n.getContext "2d"
    .Line data, responsive : true
  #update n, {w, h}, {w, h}
  return wrap

chart = (w, h) ->
  A3 NativeElement.newElement, w, h, {
    ctor: 'Custom'
    type: 'Chart'
    render
    update
    model: {w, h} }

localRuntime.Native.Chartjs.values =
  chart : F2 chart
