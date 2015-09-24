module Chartjs where

import Color exposing (Color, rgba, white)
import Graphics.Element exposing (Element)
import Native.Chartjs

type JSArray a =
  JSArray

type alias Label =
  String

type alias Labels =
  List Label

toArray : List a -> JSArray a
toArray = Native.Chartjs.toArray

showRGBA : Color -> String
showRGBA = Native.Chartjs.showRGBA

chartRaw : String -> Int -> Int -> config -> options -> Element
chartRaw = Native.Chartjs.chartRaw
