Elm.Native ||= {}
Elm.Native.Chartjs ||= {}

make = -> Elm.Native.Chartjs = make : it
localRuntime <- make

localRuntime.Native ||= {}
localRuntime.Native.Chartjs ||= {}
return v if v = localRuntime.Native.Chartjs.values

NativeElement = Elm.Native.Graphics.Element.make localRuntime
{toArray} = Elm.Native.List.make localRuntime

px = -> "#{it}px"

createNode = (elementType) ->
  n = document.createElement elementType
  n.style.padding = 0
  n.style.margin = 0
  n.style.position = "relative"
  return n

makeCanvas = (w, h) ->
  canvas = NativeElement.createNode 'canvas'
  canvas.style.width  = px w
  canvas.style.height = px h
  canvas.style.display = "block"
  ratio = window.devicePixelRatio || 1
  canvas.width  = w * ratio
  canvas.height = h * ratio
  return canvas

update = (n, _, __) -> n

render = ({w, h, data}) ->
  wrap = createNode "div"
  wrap.style.width = px w
  wrap.style.height = px h
  canvas = makeCanvas w, h
  gen = -> new Chart canvas.getContext "2d" .Line data, {}

  wrap.appendChild canvas
  setTimeout (-> canvas.__chart = gen!), 1000
  update canvas, {w, h}, {w, h}
  return wrap

showRGBA = ({_0,_1,_2,_3}) ->
  "rgba(#{_0},#{_1},#{_2},#{_3})"

lineChartRaw = (w, h, data) ->
  A3 NativeElement.newElement, w, h, {
    ctor: 'Custom'
    type: 'Chart'
    render
    update
    model: {w, h, data} }

localRuntime.Native.Chartjs.values = {
  toArray
  showRGBA
  lineChartRaw : F3 lineChartRaw
}
