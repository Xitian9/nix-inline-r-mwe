{-# LANGUAGE QuasiQuotes #-}

module MWE where

import Language.R
import Language.R.QQ

main :: IO ()
main = withEmbeddedR defaultConfig $ do
    runRegion $ do
        [r| library(dplyr)
            print("Test")
        |]
        return ()
