{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances #-}

module SideDecorations where
    -- Border on one side import

import qualified XMonad.StackSet as W
import XMonad.Layout.Decoration
import XMonad.Util.Types
import Graphics.X11.Xlib.Types

data SideDecoration a = SideDecoration Direction2D
    deriving (Show, Read)

instance Eq a => DecorationStyle SideDecoration a where
    shrink b (Rectangle _ _ dw dh) (Rectangle x y w h)
        | SideDecoration U <- b = Rectangle x (y + fi dh) w (h - dh)
        | SideDecoration R <- b = Rectangle x y (w - dw) h
        | SideDecoration D <- b = Rectangle x y w (h - dh)
        | SideDecoration L <- b = Rectangle (x + fi dw) y (w - dw) h

    pureDecoration b dw dh _ st _ (win, Rectangle x y w h)
        | win `elem` W.integrate st && dw < w && dh < h = Just $ case b of
            SideDecoration U -> Rectangle x y w dh
            SideDecoration R -> Rectangle (x + fi (w - dw)) y dw h
            SideDecoration D -> Rectangle x (y + fi (h - dh)) w dh
            SideDecoration L -> Rectangle x y dw h
        | otherwise = Nothing

    
myDecoTheme :: Theme
myDecoTheme = def
                { fontName             = "xft:Mononoki Nerd Font:bold:size=9:antialias=true:hinting=true"
                 , activeColor         = "#D8A704" --46d9ff
                 , inactiveColor       = "#999"
                 , activeBorderColor   = "#D8A704" --98be65
                 , inactiveBorderColor = "#999"
                 , activeTextColor     = "#282c34"
                 , inactiveTextColor   = "#d0d0d0"
                 , decoWidth           = 5
                }

myDecorate :: Eq a => l a -> ModifiedLayout (Decoration SideDecoration DefaultShrinker) l a
myDecorate = decoration shrinkText myDecoTheme (SideDecoration L)
