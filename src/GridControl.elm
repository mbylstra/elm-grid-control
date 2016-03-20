module GridControl where

import Html exposing (..)
import Html.Attributes exposing (style, class)
import Html.Events exposing (onMouseDown, onMouseUp, onMouseEnter, onMouseLeave)

-- import Array
import Matrix exposing (Matrix)

import GridControl.Cell as Cell exposing (Action(MouseEnter), UpdateParams)


-- MODEL

type alias Model =
  { cells : Matrix Cell.Model
  , mouseDown : Bool
  , currColumnIndex : Maybe Int
  }

init : Int -> Int -> Model
init width height =
  { cells = Matrix.repeat width height (Cell.init False)
  , mouseDown = False
  , currColumnIndex = Nothing
  }


-- UPDATE

type Action
  = MouseDown
  | MouseUp
  | MouseLeave
  | MouseLeaveColumn Int
  | CellAction { x : Int, y : Int} Cell.Action


update : Action -> Model -> Model
update action model =
  case Debug.log "action" action of
    MouseLeave ->
      { model | currColumnIndex = Nothing, mouseDown = False }

    MouseLeaveColumn columnId ->
      { model | currColumnIndex = Nothing }

    CellAction pos cellAction ->
      case cellAction of
        Cell.MouseEnter ->
          -- looks like we'll have big problems if Cell.MouseEnter and MouseEnterColumn are fired at the same time!
          -- if mouseDown, then iterate through each cell in the column. If y does not match, then turn off, else turn on
          case model.mouseDown of
            False ->
              model -- do nothing
            True ->
              let
                getValue x y val =
                  if x == pos.x
                  then
                    if y == pos.y then True else False
                  else
                    val
                newCells = Matrix.indexedMap getValue model.cells
              in
                -- we iterate through each cell in the column (mapColumn?, set Column?
                -- consider a mapRow and mapColumn function for Matrix. (and indexedMapColumn)
                { model | cells = newCells, currColumnIndex = Just pos.x }
        Cell.MouseDown ->
          let
            getValue x y val =
              if x == pos.x
              then
                if y == pos.y then (not val) else False
              else
                val
            newCells = Matrix.indexedMap getValue model.cells
          in
            -- we iterate through each cell in the column (mapColumn?, set Column?
            -- consider a mapRow and mapColumn function for Matrix. (and indexedMapColumn)
            { model | cells = newCells, currColumnIndex = Just pos.x }


        _ -> -- These are private actions, so pass them on
          -- wow: a huge amount of boilerplate below!
          let
            cellModel = Matrix.get pos.x pos.y
          in
            { model |
              cells = Matrix.update
                pos.x
                pos.y
                (Cell.update cellAction { mouseDown = model.mouseDown })
                model.cells
            }
    MouseDown ->
      { model | mouseDown = True }
    MouseUp ->
      { model | mouseDown = False }


-- VIEW


view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ class "grid"
    , onMouseDown address MouseDown
    , onMouseUp address MouseUp
    , onMouseLeave address MouseLeave
    ]
    ( Matrix.indexedMapColumnsLists
      (\x column ->
        (columnView address x column)
      )
      model.cells
    )


columnView : Signal.Address Action -> Int -> List Cell.Model -> Html
columnView address x column =
  div
    [ class "column"
    , onMouseLeave address (MouseLeaveColumn x)
    ]
    ( List.indexedMap
      (\y cell ->
        (Cell.view (Signal.forwardTo address (CellAction {x=x, y=y})) cell)
      )
      column
    )
