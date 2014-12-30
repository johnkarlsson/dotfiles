{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses, TypeSynonymInstances, FlexibleContexts, NoMonomorphismRestriction #-}

import Control.Monad
import Data.Monoid (All (All))
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad

import XMonad.Hooks.DynamicLog (dynamicLogXinerama, xmobar)
import XMonad.Hooks.ManageDocks

import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.DynamicLog

-- import XMonad.Actions.Volume
import XMonad.Actions.CycleWS
import XMonad.Actions.CycleWindows

import System.IO
import System.Exit
import XMonad.Util.Dmenu

import XMonad.Config.Gnome
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.NoBorders
-- import XMonad.Layout.Spacing
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
--    , appName =? "xmobar" -->
--                 (ask >>=
--                  \win -> liftX (withDisplay $ \dpy -> io $ raiseWindow dpy win) >>
--                  idHook)
    ]

quitWithWarning :: X ()
quitWithWarning = do
    let m = "confirm quit"
    s <- dmenu [m]
    when (m == s) (io (exitWith ExitSuccess))

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [
      ((modm .|. controlMask, xK_h),       sendMessage $ pullGroup L)
    , ((modm .|. controlMask, xK_l),       sendMessage $ pullGroup R)
    , ((modm .|. controlMask, xK_k),       sendMessage $ pullGroup U)
    , ((modm .|. controlMask, xK_j),       sendMessage $ pullGroup D)
    , ((modm .|. controlMask, xK_m),       withFocused (sendMessage . MergeAll))
    , ((modm .|. controlMask, xK_u),       withFocused (sendMessage . UnMerge))
    , ((modm .|. controlMask, xK_period),  onGroup W.focusUp')
    , ((modm .|. controlMask, xK_comma),   onGroup W.focusDown')
--  , ((modm,                 xK_s),       submap $ defaultSublMap conf)
    , ((modm .|. shiftMask, xK_q),         quitWithWarning)
    , ((modm, xK_q),                       restart "xmonad" True)
    , ((modm .|. shiftMask, xK_s),         spawn "gnome-screensaver-command --lock && sudo $HOME/dotfiles/.xmonad/sleep.sh")
    , ((modm .|. shiftMask, xK_m),         spawn "xterm -e zsh -c mutt")
    , ((modm .|. shiftMask, xK_w),         spawn "google-chrome")

    -- CycleWS
    , ((modm, xK_z),                       toggleWS)
    -- CycleWindows
    , ((mod1Mask, xK_Tab),                 cycleRecentWindows [xK_Alt_L] xK_Tab xK_Tab)

   -- multimedia keys
   --, ((0, 0x1008ff11),                    lowerVolume 3 >> return ())
   --, ((0, 0x1008ff13),                    raiseVolume 3 >> return ())
     , ((0, 0x1008ff12),                    spawn "amixer -c 1 set Master toggle;    \
                                                 \ amixer -c 1 set Headphone unmute; \
                                                 \ amixer -c 1 set Speaker unmute")
    ]

startup = do
    ewmhDesktopsStartup >> setWMName "LG3D"
--  setWMName "LG3D"

main = -- do
--    xmproc <- spawnPipe "xmobar ~/dotfiles/.xmonad/.xmobarrc"
--    xmonad $ gnomeConfig {
      xmonad =<< xmobar defaultConfig {
        modMask             = mod4Mask
      , terminal            = "xterm" 
      , layoutHook          = avoidStruts $ myLayout
      -- , layoutHook          = spacing 0 $ avoidStruts $ myLayout
      , borderWidth         = 1
      , focusFollowsMouse   = False
      , normalBorderColor   = "#000000"
      , focusedBorderColor  = "#ff0000"
      , manageHook          = myManageHook <+> manageHook gnomeConfig
      , handleEventHook     = evHook
      , keys                = myKeys <+> keys gnomeConfig
      , startupHook         = startup
--    , logHook             = dynamicLogWithPP xmobarPP
--                            { ppOutput = hPutStrLn xmproc
--                            , ppTitle = xmobarColor "green" "" . shorten 50
--                            }
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
      ptype = 4 -- The ATOM property type for changeProperty
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
