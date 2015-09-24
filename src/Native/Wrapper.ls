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

update = (gen) -> (wrap, _, newModel) ->
  if wrap.__chart
    wrap.__chart.clear!.destroy!
    setWrapSize wrap, newModel
    wrap.__chart = gen newModel, wrap.firstChild
  return wrap

render = (gen) -> (model) ->
  wrap = createNode "div"
  canvas = NativeElement.createNode 'canvas'
  wrap.appendChild canvas
  setWrapSize wrap, model
  setTimeout (-> wrap.__chart = gen model, canvas), 0
  update(gen) wrap, model, model
  return wrap

showRGBA = ({_0,_1,_2,_3}) ->
  "rgba(#{_0},#{_1},#{_2},#{_3})"

chartRaw = (type, w, h, data, options) ->

  gen = ({data, options}, canvas) ->
    new Chart(canvas.getContext "2d")[type] data, options

  A3 NativeElement.newElement, w, h, {
    ctor: 'Custom'
    type: 'Chart'
    render: render gen
    update: update gen
    model: { w, h, data, options } }

localRuntime.Native.Chartjs.values = {
  toArray
  showRGBA
  chartRaw : F5 chartRaw
}
