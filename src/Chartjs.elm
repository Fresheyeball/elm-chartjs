module Chartjs where

{-| Binding for Chart.js for Elm
@docs chart, Labels, LineSeries, LineData
-}

import Color exposing (Color, rgba, white)
import Graphics.Element exposing (Element)
import Native.Chartjs

{-| foo -}
type alias Label = String

{-| foo -}
type alias Labels = List Label

{-| foo -}
type alias LineStyle =
  { fillColor: Color
  , strokeColor: Color
  , pointColor: Color
  , pointStrokeColor: Color
  , pointHighlightFill: Color
  , pointHighlightStroke: Color }

defaultLineStyle : LineStyle
defaultLineStyle =
  defLineStyle (rgba 220 220 220)

defLineStyle : (Float -> Color) -> LineStyle
defLineStyle f =
  { fillColor = f 0.2
  , strokeColor = f 1.0
  , pointColor = f 1.0
  , pointStrokeColor = white
  , pointHighlightFill = white
  , pointHighlightStroke = f 1.0 }

{-| foo -}
type alias LineSeries = (Label, LineStyle, List Float)

{-| foo -}
type alias LineData =
  { labels: Labels
  , datasets: List LineSeries }

{-| its a chart  -}
chart : Int -> Int -> LineData -> Element
chart = Native.Chartjs.chart
