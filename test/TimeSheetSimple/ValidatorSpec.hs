module TimeSheetSimple.ValidatorSpec where

import Test.Hspec
import TimeSheetSimple.Validator.Internal.Error
import TimeSheetSimple.Validator.Internal.Validator

spec = describe "Validator" $ do mapM_ id [testEof1]

testEof1 = it "should fail on empty input" $ runValidator eof vs `shouldBe` Right ()
  where
    vs = ValidatorState Nothing []