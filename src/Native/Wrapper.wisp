(defn chartjs [localRuntime] (
  let [ NativeElement (Elm.Native.Graphics.Element.make localRuntime)
        toArray (.toArray (Elm.Native.List.make localRuntime)) ] (
    (set! (.-animation Chart.defaults.global.animation) false)

    )
  ))

(defn sanitizeNS [x]
  (if x.Native
    (if x.Native.Chartjs x
      (set! (.-Chartjs x.Native) {}))
    (set! (.-Native x) { :Chartjs {} })))

(sanitizeNS Elm)
(defn make [localRuntime] (
  (sanitizeNS localRuntime)
  (let [v localRuntime.Native.Chartjs.values]
    (if v v (chartjs localRuntime)))))

(set! (.-make Elm.Native.Chartjs) make)
