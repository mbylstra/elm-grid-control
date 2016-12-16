module GridControl exposing (..)

import Html exposing (..)
-- import Html.Attributes exposing (style)
import Html.Events exposing (onMouseDown, onMouseUp, onMouseEnter, onMouseLeave)


-- import Array
import Matrix exposing (Matrix)
import Matrix.Extra2 exposing (toColumnsLists)

import GridControl.Cell as Cell exposing (Msg(MouseEnter), UpdateParams)

import GridControl.CssClasses exposing (..)
import GridControl.ListExtra exposing (splitByN)



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

type Msg
  = MouseDown
  | MouseUp
  | MouseLeave
  | MouseLeaveColumn Int
  | CellMsg { x : Int, y : Int} Cell.Msg


update : Msg -> Model -> Model
update action model =
  -- case Debug.log "action" action of
  case action of
    MouseLeave ->
      { model | currColumnIndex = Nothing, mouseDown = False }

    MouseLeaveColumn columnId ->
      { model | currColumnIndex = Nothing }

    CellMsg pos cellMsg ->
      case cellMsg of
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
                (Cell.update cellMsg { mouseDown = model.mouseDown })
                model.cells
            }
    MouseDown ->
      { model | mouseDown = True }
    MouseUp ->
      { model | mouseDown = False }


-- VIEW


view : { columnGroupLength: Int} -> Model -> Html Msg
view params model =
  let
    columnGroups =
      model.cells
      |> toColumnsLists
      |> splitByN params.columnGroupLength

    columnGroupView :
        {columnGroup : List (List Cell.Model), groupIndex : Int}
        -> Html Msg
    columnGroupView model =
        div [ class [ColumnGroup] ]
          (List.indexedMap
            (\i column ->
              columnView
                (model.groupIndex * params.columnGroupLength + i)
                column
            )
            model.columnGroup
          )
  in
    div
      [ class [Grid]
      , onMouseDown MouseDown
      , onMouseUp MouseUp
      , onMouseLeave MouseLeave
      ]
      (List.indexedMap
        (\i columnGroup ->
          columnGroupView {columnGroup=columnGroup, groupIndex=i}
        )
        columnGroups
      )


columnView : Int -> List Cell.Model -> Html Msg
columnView x column =
  div
    [ class [Column]
    , onMouseLeave (MouseLeaveColumn x)
    ]
    ( List.indexedMap
      (\y cell ->
        Html.map (CellMsg {x=x, y=y}) (Cell.view cell)
      )
      column
    )
