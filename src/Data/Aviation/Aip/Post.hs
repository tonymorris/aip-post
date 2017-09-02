module Data.Aviation.Aip.Post where


import Control.Exitcode
import Control.Monad.IO.Class(MonadIO(liftIO))
import Data.Aviation.Aip.AipDocuments(distributeAipDocuments)
import System.Process
import Papa


{-

# png to .pdf
gs -dNOPAUSE -dBATCH -sDEVICE=pngalpha -r192 -sOutputFile='page-pngalpha2-%00d.png' ~/Desktop/aip/aip/current/aipchart/vtc/Brisbane_Sunshine_VTC.pdf

convert -density 200 ~/Desktop/aip/aip/current/aipchart/vtc/Brisbane_Sunshine_VTC.pdf Brisbane_Sunshine_VTC-x.png

# rotate
convert -rotate "-45" Brisbane_Sunshine_VTC-1.png Brisbane_Sunshine_VTC-x.png

# crop
convert +repage Brisbane_Sunshine_VTC-x.png -crop 1200x600+6000+5700 Brisbane_Sunshine_VTC-x-cropped.png

-}

run ::
  MonadIO f =>
  FilePath
  -> FilePath
  -> ExitcodeT0 f
run er ot =
  do  x <- liftIO (distributeAipDocuments er ot)
      mapM_ eachfile x

eachfile ::
  MonadIO f =>
  FilePath
  -> ExitcodeT f [FilePath]
eachfile f =
  let r ::
        MonadIO f =>
        [(FilePath -> Bool, FilePath -> ExitcodeT0 f)]
      r =
        [
          (("current/aipchart/vnc/Brisbane_VNC.pdf" `isSuffixOf`), \x -> "ls" !-> [x])
        ]
  in  mapM (\(p, x) -> if p f then f <$ x f else pure f) r

undefined = undefined

(!->) ::
  MonadIO f =>
  String
  -> [String]
  -> ExitcodeT0 f
(!->) s ss =
  fromExitCode (liftIO (rawSystem s ss))

infixl 5 !->
