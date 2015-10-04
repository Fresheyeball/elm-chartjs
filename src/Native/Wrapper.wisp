(defn- sanitizeNS [x] (do
  (if x.Native nil (set! x.Native {}))
  (if x.Native.Chartjs nil (set! x.Native.Chartjs {}))))

(defn- createNode [elementType]
  (let [n (document.createElement elementType)] (do
    (set! n.style.padding  0)
    (set! n.style.margin   0)
    (set! n.style.position :relative)
    n)))

(defn- setWrapSize [wrap wh]
  (let
    [setWH (fn [w*, h*, x] (do
      (set! (.-width  x) (+ w* "px"))
      (set! (.-height x) (+ h* "px"))))
     ratio (if window.devicePixelRatio window.devicePixelRatio 1)
     canvas wrap.firstChild]
    (do
      (setWH (* wh.w ratio) (* wh.h ratio) canvas)
      (setWH    wh.w           wh.h        wrap.style)
      (setWH    wh.w           wh.h        canvas.style))))

(defn- update [type] (fn [wrap _ model] (do
  (setWrapSize wrap model)
  (if wrap.__chart (do
    (wrap.__chart.clear) (wrap.__chart.destroy)))
  (set! wrap.__chart
    ((aget (Chart. (wrap.firstChild.getContext :2d)) type)
      model.data model.options))
  wrap)))

(defn- render [type NativeElement] (fn [model]
  (let
    [wrap (createNode :div)
     canvas (NativeElement.createNode :canvas)]
    (do
      (wrap.appendChild canvas)
      (setWrapSize wrap model)
      (setTimeout (fn [] (update type wrap model model)) 0)
      wrap))))

(defn- showRGBA [c]
  (+ "rgba(" c._0 "," c._1 "," c._2 "," c._3 ")"))

(defn- chartRaw [NativeElement] (fn [type, w, h, data, options]
  (A3 NativeElement.newElement w h {
    :ctor "Custom"
    :type "Chart"
    :render (render type NativeElement)
    :update (update type)
    :model {:w w :h h :data data :options options}})))

(defn- make [localRuntime] (let
  [NativeElement (Elm.Native.Graphics.Element.make localRuntime)
   toArray       (:toArray (Elm.Native.List.make   localRuntime))]
  (do
    (sanitizeNS localRuntime)
    (set! localRuntime.Native.Chartjs.values {
      :toArray      toArray
      :showRGBA     showRGBA
      :chartRaw (F5 (chartRaw NativeElement))}))))

(sanitizeNS Elm)
(set! Elm.Native.Chartjs.make make)
(set! Chart.defaults.global.animation false)
