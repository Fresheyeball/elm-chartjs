module Line where

import Chartjs exposing (..)
import Color exposing (..)
import Html exposing (..)
import Debug

data : LineData
data =
  { labels =
    ["January", "February", "March", "April", "May", "June", "July"]
  , datasets =
    [ ( "My First dataset"
      , defLineStyle (rgba 220 220 220)
      , [65, 59, 80, 81, 56, 55, 40] )
    , ( "My Second dataset"
      , defLineStyle (rgba 151 187 205)
      , [28, 48, 40, 19, 86, 27, 90] ) ] }

main : Html
main = fromElement <| Chartjs.chart 200 200 (Debug.log "data" data)
