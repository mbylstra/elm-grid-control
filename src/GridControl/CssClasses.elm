module GridControl.CssClasses where

import Html.CssHelpers exposing (withNamespace)


type CssClasses
  = Grid
  | Cell
  | Column
  | Active

namespace : String
namespace = "ElmGridControl"

{ id, class, classList } = withNamespace namespace
