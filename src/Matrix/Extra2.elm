module Matrix.Extra2 exposing (..)

import Array exposing (Array)
import Matrix exposing (..)


{-| Convert a matrix to an array of arrays
-}
toRows : Matrix a -> Array (Array a)
toRows matrix =
  let
    (width, _) = matrix.size
    (_, height) = matrix.size
  in
    List.map
      (\columnIndex ->
        let
          start = columnIndex * width
          end = start + width
        in
          Array.slice start end matrix.data
      )
      (List.range 0 (height-1))
    |> Array.fromList


{-| Convert a matrix to an array of arrays
-}
toColumns : Matrix a -> Array (Array a)
toColumns matrix =
  let
    (width, _) = matrix.size
    (_, height) = matrix.size
  in
    Array.map
      (\x -> getColumn x matrix |> Maybe.withDefault Array.empty)
      (Array.fromList (List.range 0 (width-1)))

{-| Convert a matrix to an array of arrays
-}
toColumnsLists : Matrix a -> List (List a)
toColumnsLists matrix =
  let
    (width, _) = matrix.size
    (_, height) = matrix.size
  in
    List.map
      (\x -> getColumn x matrix |> Maybe.withDefault Array.empty |> Array.toList)
      (List.range 0 (width - 1))

{-| Convert a matrix to a list of lists
-}
toRowsLists : Matrix a -> List (List a)
toRowsLists matrix =
  let
    (width, _) = matrix.size
    (_, height) = matrix.size
  in
    List.map
      (\columnIndex ->
        let
          start = columnIndex * width
          end = start + width
        in
          Array.slice start end matrix.data
          |> Array.toList
      )
      (List.range 0 (height - 1))

{-| Apply a function to every row, where each row is an array
-}
mapRows : (Array a -> b) -> Matrix a -> Array b
mapRows func matrix =
  let
    arrays = toRows matrix
  in
    Array.map func arrays

{-| Apply a function to every row, where each row is a list
-}
mapRowsLists : (List a -> b) -> Matrix a -> List b
mapRowsLists func matrix =
  let
    lists = toRowsLists matrix
  in
    List.map func lists

{-| Same as mapRows, but the function is also applied to the
    index of each row (starting at zero).
-}
indexedMapRows : (Int -> Array a -> b) -> Matrix a -> Array b
indexedMapRows func matrix =
  let
    rows = toRows matrix
  in
    Array.indexedMap func rows

{-| Apply a function to every column, where each column is an array
-}
mapColumns : (Array a -> b) -> Matrix a -> Array b
mapColumns func matrix =
  let
    arrays = toColumns matrix
  in
    Array.map func arrays

{-| Apply a function to every column, where each column is a list
-}
mapColumnsLists : (List a -> b) -> Matrix a -> List b
mapColumnsLists func matrix =
  let
    lists = toColumnsLists matrix
  in
    List.map func lists

{-| Same as mapColumns, but the function is also applied to the
    index of each row (starting at zero).
-}
indexedMapColumns : (Int -> Array a -> b) -> Matrix a -> Array b
indexedMapColumns func matrix =
  let
    columns = toColumns matrix
    -- _ = Debug.
  in
    Array.indexedMap func columns

indexedMapColumnsLists : (Int -> List a -> b) -> Matrix a -> List b
indexedMapColumnsLists func matrix =
  let
    columns = toColumnsLists matrix
  in
    List.indexedMap func columns
