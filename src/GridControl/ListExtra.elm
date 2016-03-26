module GridControl.ListExtra where

{-|
  Split a list into lists of length N. If length is not a
  divisor of the length of the list, the last list will shorter than the other
  chunks. Returns [] if length is less than 1.
-}
splitByN : Int -> List a -> List (List a)
splitByN length list =
  if length > 0 then
    case ((List.take length list), (List.drop length list)) of
      ([], []) -> []
      (h, []) -> [h]
      (h, t) -> h :: splitByN length t
  else
    []
-- Credit goes to @bergle from elmlang.slack.com
