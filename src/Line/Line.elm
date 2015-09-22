module Chartjs.Line
  ( Options
  , defaultOptions
  , chart
  , Style
  , defStyle
  , defaultStyle
  ) where

import Color exposing (white, rgba, Color)
import Chartjs exposing (Label, JSArray, Labels, showRGBA, toArray)
import Graphics.Element exposing (Element)

type alias Options =
  { scaleShowGridLines : Bool
  , scaleGridLineColor : Color
  , scaleGridLineWidth : Float
  , scaleShowHorizontalLines: Bool
  , scaleShowVerticalLines: Bool
  , bezierCurve : Bool
  , bezierCurveTension : Float
  , pointDot : Bool
  , pointDotRadius : Float
  , pointDotStrokeWidth : Float
  , pointHitDetectionRadius : Float
  , datasetStroke : Bool
  , datasetStrokeWidth : Float
  , datasetFill : Bool
  , legendTemplate : String }

defaultOptions : Options
defaultOptions =
  { scaleShowGridLines = True
  , scaleGridLineColor = rgba 0 0 0 0.05
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
  , legendTemplate = "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].strokeColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>" }

{-| foo -}
type alias LineStyle =
  { fillColor: Color
  , strokeColor: Color
  , pointColor: Color
  , pointStrokeColor: Color
  , pointHighlightFill: Color
  , pointHighlightStroke: Color }

defaultLineStyle : Style
defaultLineStyle =
  defLineStyle (rgba 220 220 220)

defLineStyle : (Float -> Color) -> Style
defLineStyle f =
  { fillColor = f 0.2
  , strokeColor = f 1.0
  , pointColor = f 1.0
  , pointStrokeColor = white
  , pointHighlightFill = white
  , pointHighlightStroke = f 1.0 }

type alias Series = (Label, Style, List Float)

type alias Config = (Labels, List Series)

type alias ConfigRaw =
  { labels : JSArray String
     , datasets : JSArray
      { label : String
      , fillColor : String
      , strokeColor : String
      , pointColor : String
      , pointStrokeColor : String
      , pointHighlightFill : String
      , pointHighlightStroke : String
      , data : JSArray Float } }

decodeLineData : Config -> ConfigRaw
decodeLineData (labels, series) = let
  decodeLineSeries (label, style, d) =
    { label = label
    , fillColor = showRGBA style.fillColor
    , strokeColor = showRGBA style.strokeColor
    , pointColor = showRGBA style.pointColor
    , pointStrokeColor = showRGBA style.pointStrokeColor
    , pointHighlightFill = showRGBA style.pointHighlightFill
    , pointHighlightStroke = showRGBA style.pointHighlightStroke
    , data = toArray d}
  in { labels = toArray labels
     , datasets = toArray (List.map decodeLineSeries series) }

lineChartRaw : Int -> Int -> ConfigRaw -> Element
lineChartRaw = Native.Chartjs.lineChartRaw

lineChart : Int -> Int -> Config -> Element
lineChart w h = lineChartRaw w h << decodeLineData
