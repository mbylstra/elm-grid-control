module GridControl.Cell exposing
  ( init
  , update
  , view
  , Model
  , Msg (MouseEnter, MouseDown)
  , UpdateParams
  )

import Html exposing (..)
import Html.Events exposing (onClick, onMouseDown, onMouseEnter, onMouseLeave)

import GridControl.CssClasses exposing (..)


-- MODEL

type alias Model = Bool -- Is the cell on or off?

init : Bool -> Model
init model = model

set : Model -> Model
set model = model


-- UPDATE

{- "Params" for the update function. A pattern I'm trialing -}
type alias UpdateParams =
  { mouseDown : Bool }

type Msg = MouseDown | MouseEnter | MouseLeave

update : Msg -> UpdateParams -> Model -> Model
update action params model =
  case action of
    MouseEnter ->
      if params.mouseDown
      then
        True
      else
        model
    MouseLeave ->
      model
    _ -> -- public actions
      model


-- VIEW

view : Model -> Html Msg
view model =
  div
    [ onMouseDown MouseDown
    , onMouseEnter MouseEnter
    , onMouseLeave MouseLeave
    , classList [(Cell, True), (NotDraggable, True), (Active, model)]
    ]
    []
