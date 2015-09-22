Elm.Native ||= {}
Elm.Native.Chartjs ||= {}

make = (x) -> Elm.Native.Chartjs = make : x
localRuntime <- make

localRuntime.Native ||= {}
localRuntime.Native.Chartjs ||= {}
return v if v = localRuntime.Native.Chartjs.values

NativeElement = Elm.Native.Graphics.Element.make localRuntime
{toArray} = Elm.Native.List.make localRuntime

px = (x) -> "#{x}px"

Chart.defaults.global.animation = false

createNode = (elementType) ->
  n = document.createElement elementType
  n.style.padding = 0
  n.style.margin = 0
  n.style.position = "relative"
  return n

genLineChart = ({w, h, data}, canvas) ->
  new Chart canvas.getContext "2d" .Line data, {}

setWrapSize = (wrap, {w, h}) ->
  wrap.style.width = px w
  wrap.style.height = px h
  canvas = wrap.firstChild
  canvas.style.width  = px w
  canvas.style.height = px h
  canvas.style.display = "block"
  ratio = window.devicePixelRatio || 1
  canvas.width  = w * ratio
  canvas.height = h * ratio

update = (wrap, _, newModel) ->
  if wrap.__chart
    wrap.__chart.clear().destroy()
    setWrapSize wrap, newModel
    wrap.__chart = genLineChart newModel, wrap.firstChild
  return wrap

render = (model) ->
  wrap = createNode "div"
  canvas = NativeElement.createNode 'canvas'
  wrap.appendChild canvas
  setWrapSize wrap, model
  setTimeout (-> wrap.__chart = genLineChart model, canvas), 0
  update wrap, model, model
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
