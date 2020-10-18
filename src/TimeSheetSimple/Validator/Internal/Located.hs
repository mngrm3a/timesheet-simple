module TimeSheetSimple.Validator.Internal.Located where

import CMarkGFM (PosInfo)

data Located a = Located PosInfo a | NotLocated a deriving (Eq, Show)

mkLocated :: Maybe PosInfo -> a -> Located a
mkLocated (Just p) a = Located p a
mkLocated _ a = NotLocated a

getLocation :: Located a -> Maybe PosInfo
getLocation (Located p _) = Just p
getLocation (NotLocated _) = Nothing

getValue :: Located a -> a
getValue (Located _ v) = v
getValue (NotLocated v) = v