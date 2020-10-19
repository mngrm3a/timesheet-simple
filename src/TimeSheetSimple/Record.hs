module TimeSheetSimple.Record where

import Data.Text (Text)
import Data.Time

newtype Project = Project {unProject :: Text} deriving (Eq, Ord, Show)

data Assignment = Assignment
  { project :: Project,
    duration :: NominalDiffTime
  }
  deriving (Eq, Show)

data Record = Record
  { date :: Day,
    dayStartTime :: TimeOfDay,
    dayEndTime :: TimeOfDay,
    breakStartTime :: TimeOfDay,
    breakEndTime :: TimeOfDay,
    assignments :: [Assignment]
  }
  deriving (Eq, Show)
