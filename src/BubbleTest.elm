
import StartApp.Simple exposing (start)

import Html exposing
  -- delete what you don't need
  ( Html, div, span, img, p, a, h1, h2, h3, h4, h5, h6, h6, text
  , ol, ul, li, dl, dt, dd
  , form, input, textarea, button, select, option
  , table, caption, tbody, thead, tr, td, th
  , em, strong, blockquote, hr
  )
import Html.Attributes exposing
  ( key, style, class, id, title, hidden, type', checked, placeholder, selected
  , name, href, target, src, height, width, alt
  )
import Html.Events exposing
  ( on, targetValue, targetChecked, keyCode, onBlur, onFocus, onSubmit
  , onKeyUp, onKeyDown, onKeyPress, onClick, onDoubleClick, onMouseMove
  , onMouseDown, onMouseUp, onMouseEnter, onMouseLeave, onMouseOver, onMouseOut
  )


-- MODEL

type alias Model = Bool
init = False


-- UPDATE

type Action
  = MouseLeaveParent
  | MouseLeaveChild

update : Action -> Model -> Model
update action model =
  case Debug.log "action" action of
    _ -> True


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ style [("width", "200px"), ("height", "200px"), ("background-color", "pink") ]
    , onMouseLeave address MouseLeaveParent
    ]
    [ div
      [ style [("width", "100px"), ("height", "200px"), ("background-color", "blue") ]
      , onMouseLeave address MouseLeaveChild
      ]
      []
    ]

main =
  start
    { model = init
    , update = update
    , view = view
    }
