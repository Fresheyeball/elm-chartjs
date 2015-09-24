module Bar where

import Chartjs.Bar exposing (..)
import Color exposing (..)
import Signal exposing (..)
import Html exposing (..)
import Html.Events as E

data : Config
data =
  ( ["January", "February", "March", "April", "May", "June", "July"]
  , [ ( "My First dataset"
      , defStyle (rgba 220 220 220)
      , [65, 59, 80, 81, 56, 55, 40] )
    , ( "My Second dataset"
      , defStyle (rgba 151 187 205)
      , [28, 48, 40, 19, 86, 27, 90] ) ] )

data' : Config
data' =
  ( ["January", "February", "March", "April", "May", "June", "July"]
  , [ ( "My First dataset"
      , defStyle (rgba 220 220 220)
      , [65, 59, 80, 81, 0, 55, 40] )
    , ( "My Second dataset"
      , defStyle (rgba 151 187 205)
      , [28, 48, 40, 0, 86, 27, 0] ) ] )

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
