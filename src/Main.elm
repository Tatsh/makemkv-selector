module Main exposing (..)
import Browser
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (type_, placeholder, value)
import Html.Events exposing (onClick, onInput)

-- Main
main =
  Browser.sandbox { init = init, update = update, view = view }

-- Model
type alias Model =
  { selectionStr : String }

init : Model
init =
  Model ""

-- Update
type Msg
    = SelectionStr String

update : Msg -> Model -> Model
update msg model =
  case msg of
     SelectionStr selectionStr ->
      { model | selectionStr = selectionStr }

-- View

view model =
  div []
    [ viewInput "text" "selection string" model.selectionStr SelectionStr
    ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []
