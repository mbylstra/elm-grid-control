module GridControl.CssClasses exposing (..)

import Html.CssHelpers exposing (withNamespace)


type CssClasses
  = Grid
  | ColumnGroup
  | Column
  | Cell
  | Active
  | NotDraggable

namespace : String
namespace = "ElmGridControl"

{ id, class, classList } = withNamespace namespace
