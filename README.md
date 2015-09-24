# Elm bindings to Chartjs.

This package allows you to mix [Chartjs](http://www.chartjs.org/) canvas based charts into your [Elm](http://elm-lang.org/) application. The api is modeled after `Graphics.Element` and is well typed (in most cases).

Bindings exist for all 6 Chartjs chart types

- Line
- Bar
- Radar
- Polar
- Pie
- Doughnut

Currently listening for events in charts is not supported, but will be soon.

### Usage

```elm
import Chartjs.Line as Line

view : Model -> Html
view model = div []
  [ fromElement <| Line.chart' 700 300 model.stuff ]
```

### Examples

```
elm reactor
```

To see the examples.
