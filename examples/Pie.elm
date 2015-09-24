module Pie where

import Chartjs.Pie exposing (..)
import Color exposing (..)
import Signal exposing (..)
import Html exposing (..)
import Html.Events as E

data : Config
data =
  [ ( "My First dataset"
    , defStyle (rgba 220 220 220)
    , 65 )
  , ( "My Second dataset"
    , defStyle (rgba 151 187 205)
    , 90 ) ]

data' : Config
data' =
  [ ( "My First dataset"
    , defStyle (rgba 220 220 220)
    , 120 )
  , ( "My Second dataset"
    , defStyle (rgba 151 187 205)
    , 30 ) ]

mail : Mailbox Bool
mail = let
  m = mailbox False
  in { m | signal <-
    foldp (always not) False m.signal }

view : Bool -> Html
view isClicked = div []
  [ fromElement <| chart 700 300 (if isClicked then data' else data) defaultOptions
  , button [E.onClick mail.address True] [text "toggle"] ]

main : Signal Html
main = view <~ mail.signal
