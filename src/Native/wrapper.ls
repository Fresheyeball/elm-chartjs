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

genLineChart = ({w, h, data}, canvas) ->
  new Chart canvas.getContext "2d" .Line data, {}

update = (wrap, oldModel, newModel) ->
  {w, h, data} = newModel
  {labels, datasets} = data
  {__chart} = wrap
  if __chart
    /*if datasets.length == oldModel.data.datasets.length
      __chart.labels = labels
      for d, i in (new Chart makeCanvas(newModel.h, newModel.w).getContext "2d" .Line newModel.data, {}).datasets
        for p, j in d.points
          if p.value !== __chart.datasets[i].points[j].value
            __chart.datasets[i].points[j].value = p.value
      __chart.update()
    else*/
    __chart.clear().destroy()
    setTimeout (-> wrap.__chart = genLineChart {w, h, data}, wrap.firstChild), 0

  return wrap

render = ({w, h, data}) ->
  wrap = createNode "div"
  wrap.style.width = px w
  wrap.style.height = px h
  canvas = makeCanvas w, h
  wrap.appendChild canvas
  setTimeout (-> wrap.__chart = genLineChart {w, h, data}, canvas), 0
  update wrap, {w, h, data}, {w, h, data}
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
