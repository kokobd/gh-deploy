module Zelinf.GitHub.Auth
  ( OAuthToken
  ) where

import           Data.Aeson
import           Data.Aeson.Types (typeMismatch)
import           Data.Text        (Text)
import           GHC.Generics
import           Prelude          hiding (String)

newtype OAuthToken = OAuthToken Text

instance FromJSON OAuthToken where
  parseJSON = undefined
