module Bar where

import Chartjs
import Html exposing (..)

main : Html
main = fromElement <| Chartjs.chart 200 200
