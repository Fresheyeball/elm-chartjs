module Line where

import Chartjs exposing (..)
import Color exposing (..)
import Signal exposing (..)
import Html exposing (..)
import Html.Events as E
import Debug

data : LineData
data =
  ( ["January", "February", "March", "April", "May", "June", "July"]
  , [ ( "My First dataset"
      , defLineStyle (rgba 220 220 220)
      , [65, 59, 80, 81, 56, 55, 40] )
    , ( "My Second dataset"
      , defLineStyle (rgba 151 187 205)
      , [28, 48, 40, 19, 86, 27, 90] ) ] )

data' : LineData
data' =
  ( ["January", "February", "March", "April", "May", "June", "July"]
  , [ ( "My First dataset"
      , defLineStyle (rgba 220 220 220)
      , [65, 59, 80, 81, 0, 55, 40] )
    , ( "My Second dataset"
      , defLineStyle (rgba 151 187 205)
      , [28, 48, 40, 0, 86, 27, 0] ) ] )

chart : LineData -> Html
chart d = fromElement <| Chartjs.lineChart 700 300 d

mail : Mailbox Bool
mail = mailbox False

view : Bool -> Html
view isClicked = div []
  [ chart (if (Debug.log "isClicked" isClicked) then data' else data)
  , button [E.onClick mail.address True] [text "update"] ]

main : Signal Html
main = view <~ mail.signal
