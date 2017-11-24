{-# LANGUAGE OverloadedStrings #-}

module Zelinf.GitHub.Release
  (
  ) where

import           Control.Monad.IO.Class (MonadIO)
import           Data.Aeson
import           Data.Aeson.Types       (typeMismatch)
import           Data.Text              (Text)

import           Servant.API
import           Servant.Client

import           Zelinf.GitHub.GitHubT

data Release = Release
  { uploadUrl :: Text
  }

instance FromJSON Release where
  parseJSON (Object v) = Release <$> v .: "upload_url"
  parseJSON others     = typeMismatch "Release" others

type Tag = Text

getReleaseByTag :: MonadIO m => Tag -> GitHubT m Release
getReleaseByTag tag = undefined

-- type GetReleaseByTagAPI =
