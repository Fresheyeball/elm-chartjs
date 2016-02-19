module Chartjs.Line (chart, chart', Options, defaultOptions, Series, Config, Style, defStyle, defaultStyle) where

{-| API wrapper for Chartjs Line charts

# Configure
@docs Config, Series

# Render
@docs chart, chart'

# Options
@docs Options, defaultOptions

# Style
@docs Style, defStyle, defaultStyle
-}

import Color exposing (white, rgba, Color)
import Chartjs exposing (..)
import Graphics.Element exposing (Element)


{-| Options for the Line Chart
[Chartjs Docs](http://www.chartjs.org/docs/#line-chart-chart-options).
In most cases just use `defaultOptions`
-}
type alias Options =
  { scaleShowGridLines : Bool
  , scaleGridLineColor : Color
  , scaleGridLineWidth : Float
  , scaleShowHorizontalLines : Bool
  , scaleShowVerticalLines : Bool
  , bezierCurve : Bool
  , bezierCurveTension : Float
  , pointDot : Bool
  , pointDotRadius : Float
  , pointDotStrokeWidth : Float
  , pointHitDetectionRadius : Float
  , datasetStroke : Bool
  , datasetStrokeWidth : Float
  , datasetFill : Bool
  , legendTemplate : String
  , animation : Bool
  , animationSteps : Int
  , animationEasing : String
  }


type alias OptionsRaw =
  { scaleShowGridLines : Bool
  , scaleGridLineColor : String
  , scaleGridLineWidth : Float
  , scaleShowHorizontalLines : Bool
  , scaleShowVerticalLines : Bool
  , bezierCurve : Bool
  , bezierCurveTension : Float
  , pointDot : Bool
  , pointDotRadius : Float
  , pointDotStrokeWidth : Float
  , pointHitDetectionRadius : Float
  , datasetStroke : Bool
  , datasetStrokeWidth : Float
  , datasetFill : Bool
  , legendTemplate : String
  , animation : Bool
  , animationSteps : Int
  , animationEasing : String
  }


decodeOptions : Options -> OptionsRaw
decodeOptions o =
  { o | scaleGridLineColor = showRGBA o.scaleGridLineColor }


{-| Codification of the default options [Chartjs Docs](http://www.chartjs.org/docs/#line-chart-chart-options)

    chart 200 200 config defaultOptions

Pass just one option

    chart 200 200 config
      { defaultOptions | scaleShowGridLines = False }

-}
defaultOptions : Options
defaultOptions =
  { scaleShowGridLines = True
  , scaleGridLineColor = rgba 0 0 0 5.0e-2
  , scaleGridLineWidth = 1.0
  , scaleShowHorizontalLines = True
  , scaleShowVerticalLines = True
  , bezierCurve = True
  , bezierCurveTension = 0.4
  , pointDot = True
  , pointDotRadius = 4.0
  , pointDotStrokeWidth = 1.0
  , pointHitDetectionRadius = 20.0
  , datasetStroke = True
  , datasetStrokeWidth = 2.0
  , datasetFill = True
  , legendTemplate = "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].strokeColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>"
  , animation = False
  , animationSteps = 60
  , animationEasing = "easeOutQuart"
  }


{-| Style for a data line on the chart
[Chartjs Docs](http://www.chartjs.org/docs/#line-chart-data-structure)
-}
type alias Style =
  { fillColor : Color
  , strokeColor : Color
  , pointColor : Color
  , pointStrokeColor : Color
  , pointHighlightFill : Color
  , pointHighlightStroke : Color
  }


{-| A default style for lines, a light grey affair
-}
defaultStyle : Style
defaultStyle =
  defStyle (rgba 220 220 220)


{-| Convience function for making styles based on
a single color.

    myStyle = defStyle (RGBA 45 45 45)

-}
defStyle : (Float -> Color) -> Style
defStyle f =
  { fillColor = f 0.2
  , strokeColor = f 1.0
  , pointColor = f 1.0
  , pointStrokeColor = white
  , pointHighlightFill = white
  , pointHighlightStroke = f 1.0
  }


{-| A Series to plot. Chartjs speak this is a dataset.
[Chartjs Docs](http://www.chartjs.org/docs/#line-chart-data-structure)
-}
type alias Series =
  ( Label, Style, List Float )


{-| Complete data model needed for rendering
Chartjs referrs to this as simply `data` in their docs
-}
type alias Config =
  ( Labels, List Series )


type alias ConfigRaw =
  { labels : JSArray String
  , datasets :
      JSArray
        { label : String
        , fillColor : String
        , strokeColor : String
        , pointColor : String
        , pointStrokeColor : String
        , pointHighlightFill : String
        , pointHighlightStroke : String
        , data : JSArray Float
        }
  }


decodeConfig : Config -> ConfigRaw
decodeConfig ( labels, series ) =
  let
    decode ( label, style, d ) =
      { label = label
      , fillColor = showRGBA style.fillColor
      , strokeColor = showRGBA style.strokeColor
      , pointColor = showRGBA style.pointColor
      , pointStrokeColor = showRGBA style.pointStrokeColor
      , pointHighlightFill = showRGBA style.pointHighlightFill
      , pointHighlightStroke = showRGBA style.pointHighlightStroke
      , data = toArray d
      }
  in
    { labels = toArray labels
    , datasets = toArray (List.map decode series)
    }


{-| Create a Chartjs Line Chart in an Element

    chart height width myConfig defaultOptions

-}
chart : Int -> Int -> Config -> Options -> Element
chart w h c o =
  chartRaw "Line" w h (decodeConfig c) (decodeOptions o)


{-| Same as `chart` but default options are assumed
-}
chart' : Int -> Int -> Config -> Element
chart' w h c =
  chart w h c defaultOptions
