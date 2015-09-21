module Chartjs (chart) where

{-| Binding for Chart.js for Elm
@docs chart
-}

import Graphics.Element exposing (Element)
import Native.Chartjs

{-| its a chart  -}
chart : Int -> Int -> Element
chart = Native.Chartjs.chart
