
sanitizeNS = (x) -> x.Native ||= {}; x.Native.Chartjs ||= {}
sanitizeNS Elm
localRuntime <- (make) -> Elm.Native.Chartjs = {make}
sanitizeNS localRuntime
return v if v = localRuntime.Native.Chartjs.values

NativeElement = Elm.Native.Graphics.Element.make localRuntime
{toArray}     = Elm.Native.List.make             localRuntime

Chart.defaults.global.animation = false

createNode = (elementType) ->
  n = document.createElement elementType
  n.style.padding  = 0
  n.style.margin   = 0
  n.style.position = "relative"
  return n

setWrapSize = (wrap, {w, h}) !->
  setWH = (w_, h_, x) !->
    x.width  = "#{w_}px"
    x.height = "#{h_}px"
  ratio  = window.devicePixelRatio || 1
  canvas = wrap.firstChild
  setWH w * ratio, h * ratio, canvas
  setWH w,         h,         wrap.style
  setWH w,         h,         canvas.style

update = (type, wrap, _, model) -->
  setWrapSize wrap, model
  wrap.__chart.clear!.destroy! if wrap.__chart
  wrap.__chart = new Chart(wrap.firstChild.getContext "2d")[type] model.data, model.options
  return wrap

render = (type, model) -->
  wrap = createNode "div"
  canvas = NativeElement.createNode 'canvas'
  wrap.appendChild canvas
  setWrapSize wrap, model
  setTimeout (-> update type, wrap, model, model), 0
  return wrap

showRGBA = ({_0,_1,_2,_3}) ->
  "rgba(#{_0},#{_1},#{_2},#{_3})"

chartRaw = F5 (type, w, h, data, options) ->
  A3 NativeElement.newElement, w, h,
    ctor   : 'Custom'
    type   : 'Chart'
    render : render type
    update : update type
    model  : { w, h, data, options }

localRuntime.Native.Chartjs.values =
  { toArray, showRGBA, chartRaw }
