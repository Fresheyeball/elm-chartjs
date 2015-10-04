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

run

```
elm reactor
```

To see the examples.

---

## Contribute

Found a bug? Want to add a feature?

Native glue from JavaScript to Elm is in [**wisp**. Wisp](https://github.com/Gozala/wisp) is 

> Homoiconic JS with Clojure syntax, s-expressions & macros. 

Basically ClojureScript lite. 

The wisp wrapper can be found [here.](https://github.com/Fresheyeball/elm-chartjs/blob/master/src/Native/Wrapper.wisp)

### Building

First get the latest *Chartjs** run

```bash
sh update-from-bower.sh
```

Then you can build the artifact

```bash
sh make.sh
```

Check work in the reactor like normal.
