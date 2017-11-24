{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}


module Zelinf.GitHub.Release
  ( Release(..)
  , getReleaseByTag
  ) where

import           Control.Monad.IO.Class (MonadIO)
import           Data.Aeson
import           Data.Aeson.Types       (typeMismatch)
import           Data.Text              (Text)

import           Servant.API
import           Servant.Client

import           Zelinf.GitHub.Auth
import           Zelinf.GitHub.GitHubT

data Release = Release
  { uploadUrl :: Text
  }

instance FromJSON Release where
  parseJSON = undefined

type Tag = Text

getReleaseByTag :: MonadIO m => Tag -> GitHubT m Release
getReleaseByTag tag = undefined

type GetReleaseByTagAPI = "repos" :> Capture "owner" Text :> Capture "repo" Text
                       :> "releases" :> "tags" :> Capture "tag" Tag
                       :> Header "Authentication" OAuthToken
                       :> Get '[JSON] Release

type CreateReleaseAPI = "repos" :> Capture "owner" Text :> Capture "repo" Text
                     :> "releases"
                     :> Header "Authentication" OAuthToken
                     :> ReqBody '[JSON] CreateRelease
                     :> Post '[JSON] ()

type UploadAssetAPI = "repos" :>  Capture "owner" Text :> Capture "repo" Text
                   :> "releases" :> Capture "id" Text :> "assets"
                   :> QueryParam "name" Text -- ^asset name

data CreateRelease = CreateRelease
                     Tag -- ^tag name
                     Text -- ^release name

instance ToJSON CreateRelease where
  toJSON (CreateRelease tag name) =
    object ["tag_name" .= tag, "name" .= name]
