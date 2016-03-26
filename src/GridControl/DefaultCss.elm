module GridControl.DefaultCss where

import Css exposing (..)
-- import Css.Elements exposing (..)
import Css.Namespace

import GridControl.CssClasses exposing (..)

import Css.Colors exposing (..)
-- import Css.Namespace exposing (namespace)
-- import Html.CssHelpers exposing (namespace)
-- import Color exposing (..)
import String


rawBlock : String -> List Mixin
rawBlock s =
  let
    parseDeclaration rawDeclaration =
      case String.split ":" rawDeclaration of
        key :: value :: [] ->
          Just <| property key value
        _ ->
          Nothing
  in
    s
    |> String.split ";"
    |> List.filterMap parseDeclaration

        -- body {
        --   padding: 40px;
        --   font-family: 'Montserrat', Arial, serif; font-weight: 400;
        --   -webkit-touch-callout: none;
        --   -webkit-user-select: none;
        --   -khtml-user-select: none;
        --   -moz-user-select: none;
        --   -ms-user-select: none;
        --   user-select: none;
        -- }
        -- h2 {
        --   font-family: 'Montserrat', Arial, serif; font-weight: 700;
        -- }
        -- .grid {
        --   cursor: default;
        --   display: flex;
        --   width: 200px;
        --   height: 200px;
        --   border: 2px solid black;
        -- }
        -- .cell {
        --   width: 20px;
        --   height: 20px;
        --   /* border: 1px solid white; */
        -- }
        -- .cell.active {
        --   background-color: rgba(255, 0, 0, 0.4);
        -- }

css : Stylesheet
css =
  (stylesheet << Css.Namespace.namespace namespace)
    [ (.) Grid
        [ displayFlex
        , width (pct 100)
        , height (pct 100)
        , border3 (px 2) solid (rgb 0 0 0)
        , property "cursor" "default"
        ]
    , (.) Column
      [ displayFlex
      , flexDirection column
      , property "flex" "1"
      ]
    , (.) Cell
      [ property "flex" "1"
      , margin (px 1)
      , backgroundColor (rgba 0 0 0 0.05)
      ]
    , (.) Active
      [ backgroundColor teal
      ]
    ]

-- css =
--   (stylesheet << namespace "ElmGridControl")
--     [ body
--         [ overflowX auto
--         , minWidth (px 1280)
--         ]
--
--     , (#) Grid
--         [ backgroundColor (rgb 200 128 64)
--         , color (hex "CCFFFF")
--         , width (pct 100)
--         , height (pct 100)
--         , boxSizing borderBox
--         , padding (px 8)
--         , margin zero
--         ]
--
--     , (.) Cell
--         [ margin zero
--         , padding zero
--
--         , children
--             [ li
--                 [ (display inlineBlock) |> important
--                 , color (hex "FF0000")
--                 ]
--             ]
--         ]
--     ]

stylesText : String
stylesText = .css <| compile css
