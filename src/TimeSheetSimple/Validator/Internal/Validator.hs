{-# LANGUAGE TupleSections #-}

module TimeSheetSimple.Validator.Internal.Validator where

import CMarkGFM
import Control.Monad.Trans.State.Strict
import TimeSheetSimple.Validator.Internal.Error

data ValidatorState = ValidatorState
  { posInfo :: Maybe PosInfo,
    input :: [Node]
  }
  deriving (Eq, Show)

type Validator a = State ValidatorState (Either ValidationError' a)

runValidator :: Validator a -> ValidatorState -> Either ValidationError' a
runValidator = evalState

eof :: Validator ()
eof = StateT $ \s@(ValidatorState _ ns) -> pure $ case ns of
  [] -> (Right (), s)
  (Node l' t _ : _) -> unexpectedInputError l' t

leaf :: (NodeType -> Maybe a) -> Validator a
leaf p = StateT $ \(ValidatorState l nss) -> pure $ case nss of
  (Node l' t css) : ns -> case css of
    [] -> case p t of
      Just a -> (Right a, ValidatorState l' ns)
      _ -> unexpectedNodeError l' t
    _ -> unexpectedBranchError l' t
  [] -> unexpectedEndOfInputError l undefined

branch :: (NodeType -> Maybe a) -> (a -> Validator b) -> Validator b
branch p v = StateT $ \(ValidatorState l nss) -> pure $ case nss of
  (Node l' t css) : ns -> case css of
    _ : _ -> case p t of
      Just a -> (runValidator (v a) (ValidatorState l' css), ValidatorState l' ns)
      _ -> unexpectedNodeError l' t
    _ -> unexpectedLeafError l' t
  [] -> unexpectedEndOfInputError l undefined

unexpectedInputError,
  unexpectedEndOfInputError,
  unexpectedBranchError,
  unexpectedLeafError,
  unexpectedNodeError ::
    Maybe PosInfo ->
    NodeType ->
    (Either ValidationError' a, ValidatorState)
unexpectedInputError l = (,undefined) . mkError UnexpectedInput l
unexpectedEndOfInputError l = (,undefined) . mkError (const UnexpectedEndOfInput) l
unexpectedBranchError l = (,undefined) . mkError UnexpectedBranch l
unexpectedLeafError l = (,undefined) . mkError UnexpectedLeaf l
unexpectedNodeError l = (,undefined) . mkError UnexpectedNode l