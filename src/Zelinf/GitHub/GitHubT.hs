{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Zelinf.GitHub.GitHubT
  ( OAuthToken
  , GitHubT (GitHubT)
  , runGitHubT
  ) where

import           Control.Monad.IO.Class
import           Control.Monad.Reader
import           Data.Text              (Text)

type OAuthToken = Text

newtype GitHubT m a = GitHubT (ReaderT OAuthToken m a)
                      deriving (Functor, Applicative, Monad, MonadReader OAuthToken)

runGitHubT :: OAuthToken -> GitHubT m a -> m a
runGitHubT token (GitHubT theReader) = runReaderT theReader token

