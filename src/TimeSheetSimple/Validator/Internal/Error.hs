module TimeSheetSimple.Validator.Internal.Error where

import CMarkGFM
import TimeSheetSimple.Validator.Internal.Located
import TimeSheetSimple.Validator.Internal.NodeTag

data ValidationError
  = UnexpectedInput NodeTag
  | UnexpectedEndOfInput
  | UnexpectedBranch NodeTag
  | UnexpectedLeaf NodeTag
  | UnexpectedNode NodeTag
  deriving (Eq, Show)

type ValidationError' = Located ValidationError

mkError ::
  (NodeTag -> ValidationError) ->
  (Maybe PosInfo) ->
  NodeType ->
  Either (Located ValidationError) a
mkError c l = Left . mkLocated l . c . mkNodeTag
