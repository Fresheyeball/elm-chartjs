module Chartjs where

import Color exposing (Color, rgba, white)
import Native.Chartjs

type JSArray a = JSArray
type alias Label = String
type alias Labels = List Label

toArray : List a -> JSArray a
toArray = Native.Chartjs.toArray

showRGBA : Color -> String
showRGBA = Native.Chartjs.showRGBA
