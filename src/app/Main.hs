{-# LANGUAGE QuasiQuotes #-}
module Main where

import Data.String.Interpolate.IsString
import Network.HTTP.Client as HC

main :: IO ()
main = do
  manager <- newManager defaultManagerSettings

  request <- HC.parseRequest [i|http://localhost:8080/|]

  response <- HC.httpLbs request manager

  putStrLn [i|Got response: #{response}|]
