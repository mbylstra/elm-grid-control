module Test where

import Graphics.Element exposing (..)
import ElmTest exposing
  ( Test
  , suite, test, assertEqual
  , elementRunner, stringRunner
  )

import GridControl.ListExtra as ListExtra

splitByN : Test
splitByN = suite "splitByN"
  [ test "when chunkLength is divisor of list length"
      <| assertEqual
          [[1,2],[3,4]]
          (ListExtra.splitByN 2 [1, 2, 3, 4])
  , test "when chunkLength is not a divisor of list length"
      <| assertEqual
          [[1,2],[3,4],[5]]
          (ListExtra.splitByN 2 [1, 2, 3, 4, 5])
  , test "empty list"
      <| assertEqual
          []
          (ListExtra.splitByN 2 [])
  , test "chunkSize is zero"
      <| assertEqual
          []
          (ListExtra.splitByN 0 [1,2,3])
  ]

tests : Test
tests = suite "Tests"
  [ splitByN
  ]

results : String
results = stringRunner tests

main : Element
main = elementRunner tests
