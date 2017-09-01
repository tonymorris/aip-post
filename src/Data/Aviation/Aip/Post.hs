module Data.Aviation.Aip.Post where

import Data.Aviation.Aip
import Control.Exitcode

{-

# png to .pdf
gs -dNOPAUSE -dBATCH -sDEVICE=pngalpha -r192 -sOutputFile='page-pngalpha2-%00d.png' ~/Desktop/aip/aip/current/aipchart/vtc/Brisbane_Sunshine_VTC.pdf

convert -density 200 ~/Desktop/aip/aip/current/aipchart/vtc/Brisbane_Sunshine_VTC.pdf Brisbane_Sunshine_VTC-x.png

# rotate
convert -rotate "-45" Brisbane_Sunshine_VTC-1.png Brisbane_Sunshine_VTC-x.png

# crop
convert +repage Brisbane_Sunshine_VTC-x.png -crop 1200x600+6000+5700 Brisbane_Sunshine_VTC-x-cropped.png

-}
