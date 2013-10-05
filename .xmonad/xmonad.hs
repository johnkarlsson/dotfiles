{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses, TypeSynonymInstances, FlexibleContexts, NoMonomorphismRestriction #-}

import Control.Monad
import Data.Monoid (All (All))
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.BoringWindows
import XMonad.Layout.Reflect
import XMonad.Layout.Column

-- myLayout = smartBorders $ layoutHook gnomeConfig
myLayout = windowNavigation
                $ smartBorders
                $ boringWindows
                $ subLayout [0,1,2] (Mirror $ Column 1) (layoutHook gnomeConfig)


-- http://charlieharvey.org.uk/src/xmonad.hs.txt
myManageHook = composeAll [
      isFullscreen --> doFullFloat
    ]

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [
    ((modm .|. controlMask,   xK_h),       sendMessage $ pullGroup L)
    , ((modm .|. controlMask, xK_l),       sendMessage $ pullGroup R)
    , ((modm .|. controlMask, xK_k),       sendMessage $ pullGroup U)
    , ((modm .|. controlMask, xK_j),       sendMessage $ pullGroup D)
    , ((modm .|. controlMask, xK_m),       withFocused (sendMessage . MergeAll))
    , ((modm .|. controlMask, xK_u),       withFocused (sendMessage . UnMerge))
    , ((modm .|. controlMask, xK_period),  onGroup W.focusUp')
    , ((modm .|. controlMask, xK_comma),   onGroup W.focusDown')
--  , ((modm,                 xK_s),       submap $ defaultSublMap conf)
    ]


main = xmonad $ gnomeConfig {
    modMask             = mod4Mask
  , layoutHook          = myLayout
  , borderWidth         = 2
  , focusFollowsMouse   = False
--, normalBorderColor   = "#cccccc"
--, focusedBorderColor  = "#3300ff"
  , manageHook          = myManageHook <+> manageHook gnomeConfig
  , handleEventHook     = evHook
  , keys                = myKeys <+> keys gnomeConfig
  , startupHook         = ewmhDesktopsStartup >> setWMName "LG3D"
--, startupHook         = setWMName "LG3D"
  }

-- Helper functions to fullscreen the window
fullFloat, tileWin :: Window -> X ()
fullFloat w = windows $ W.float w r
    where r = W.RationalRect 0 0 1 1
tileWin w = windows $ W.sink w

evHook :: Event -> X All
evHook (ClientMessageEvent _ _ _ dpy win typ dat) = do
  state <- getAtom "_NET_WM_STATE"
  fullsc <- getAtom "_NET_WM_STATE_FULLSCREEN"
  isFull <- runQuery isFullscreen win

  -- Constants for the _NET_WM_STATE protocol
  let remove = 0
      add = 1
      toggle = 2

      -- The ATOM property type for changeProperty
      ptype = 4 

      action = head dat

  when (typ == state && (fromIntegral fullsc) `elem` tail dat) $ do
    when (action == add || (action == toggle && not isFull)) $ do
         io $ changeProperty32 dpy win state ptype propModeReplace [fromIntegral fullsc]
         fullFloat win
    when (head dat == remove || (action == toggle && isFull)) $ do
         io $ changeProperty32 dpy win state ptype propModeReplace []
         tileWin win

  -- It shouldn't be necessary for xmonad to do anything more with this event
  return $ All False

evHook _ = return $ All True
