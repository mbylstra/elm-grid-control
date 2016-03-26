import Html exposing (div, button, text, node, h2, p)
import Html.Attributes exposing (style)
import StartApp.Simple as StartApp
import GridControl as GridControl
import GridControl.DefaultCss exposing (stylesText)


main =
  StartApp.start
    { model = GridControl.init 16 12
    , view = view
    , update = GridControl.update
    }




styleNode cssString =
  node "style" [] [ text cssString ]


view action model =
  div []
    [ styleNode stylesText
      --   body {
      --     padding: 40px;
      --     font-family: 'Montserrat', Arial, serif; font-weight: 400;
      --     -webkit-touch-callout: none;
      --     -webkit-user-select: none;
      --     -khtml-user-select: none;
      --     -moz-user-select: none;
      --     -ms-user-select: none;
      --     user-select: none;
      --   }
      --   h2 {
      --     font-family: 'Montserrat', Arial, serif; font-weight: 700;
      --   }
      --   .grid {
      --     cursor: default;
      --     display: flex;
      --     width: 200px;
      --     height: 200px;
      --     border: 2px solid black;
      --   }
      --   .cell {
      --     width: 20px;
      --     height: 20px;
      --     /* border: 1px solid white; */
      --   }
      --   .cell.active {
      --     background-color: rgba(255, 0, 0, 0.4);
      --   }
      -- """
    , div
        [ style
          [ ("width", "100%")
          , ("height", "300px")
          ]
        ]
        [ GridControl.view action model ]
    ]
