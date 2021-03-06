{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE FlexibleInstances         #-}
{-# LANGUAGE MultiParamTypeClasses     #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeSynonymInstances      #-}

import           Control.Monad
import qualified Data.Map                       as M
import           Data.Monoid                    (All (All))
import           XMonad
import qualified XMonad.StackSet                as W

import           XMonad.Hooks.ManageDocks

import           XMonad.Hooks.DynamicLog
import           XMonad.Util.Run                (spawnPipe)

-- import XMonad.Actions.Volume
import           XMonad.Actions.CycleWindows
import           XMonad.Actions.CycleWS

import           XMonad.Actions.Warp

import           System.Exit
import           System.IO
import           XMonad.Util.Dmenu

import           XMonad.Config.Gnome
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.SetWMName

import           XMonad.Layout.NoBorders

import           XMonad.Layout.BoringWindows
import           XMonad.Layout.Column
import           XMonad.Layout.Reflect

import           XMonad.Layout.Spacing
import           XMonad.Layout.SubLayouts
import           XMonad.Layout.WindowNavigation

-- myLayout = smartBorders $ layoutHook gnomeConfig
myLayout =
  windowNavigation $
  smartBorders $
  boringWindows $
  subLayout [0, 1, 2] (Mirror $ Column 1) (layoutHook defaultConfig)

-- http://charlieharvey.org.uk/src/xmonad.hs.txt
myManageHook = composeAll [isFullscreen --> doFullFloat]

--    , appName =? "xmobar" -->
--                 (ask >>=
--                  \win -> liftX (withDisplay $ \dpy -> io $ raiseWindow dpy win) >>
--                  idHook)
quitWithWarning :: X ()
quitWithWarning = do
  let m = "confirm quit"
  s <- dmenu [m]
  when (m == s) (io exitSuccess)

myKeys conf@XConfig {XMonad.modMask = modm} =
  M.fromList
  [ ((modm .|. controlMask, xK_h),      sendMessage $ pullGroup L)
  , ((modm .|. controlMask, xK_l),      sendMessage $ pullGroup R)
  , ((modm .|. controlMask, xK_k),      sendMessage $ pullGroup U)
  , ((modm .|. controlMask, xK_j),      sendMessage $ pullGroup D)
  , ((modm, xK_g),                      warpToScreen 0 0.25 0)
  , ((modm .|. controlMask, xK_m),      withFocused (sendMessage . MergeAll))
  , ((modm .|. controlMask, xK_u),      withFocused (sendMessage . UnMerge))
  , ((modm .|. controlMask, xK_period), onGroup W.focusUp')
  , ((modm .|. controlMask, xK_comma),  onGroup W.focusDown')
  , ((modm .|. shiftMask, xK_q),        quitWithWarning)
  -- , ((modm .|. shiftMask, xK_l),        spawn "xflock4")
  , ((modm .|. shiftMask, xK_l),        spawn "xtrlock")
  , ((modm
      .|. shiftMask
      .|. controlMask, xK_l),           spawn "xtrlock -b")
  , ((modm, xK_q),                      restart "xmonad" True)
  , ((modm .|. shiftMask, xK_m),        spawn "urxvt -e mutt")
  , ((modm
      .|. shiftMask
      .|. controlMask, xK_Return),      spawn "urxvt -e /bin/bash")
  , ((modm
      .|. shiftMask
      .|. controlMask
      .|. mod1Mask, xK_Return),         spawn "urxvt -e /bin/bash -c su root")
  , ((modm .|. shiftMask, xK_b),        spawn "google-chrome-stable")
  , ((modm .|. shiftMask, xK_n),        spawn "firefox")
  -- , ((modm .|. shiftMask, xK_a),        spawn "emacsclient -c -a ''")
  , ((modm .|. shiftMask, xK_s),        spawn "emacs")
  , ((modm .|. shiftMask, xK_a),        spawn "LIGHT_THEME=1 emacs")
  , ((modm, xK_z),                      toggleWS) -- CycleWS
  , ((mod1Mask, xK_Tab),                cycleRecentWindows [xK_Alt_L] xK_Tab xK_Tab) -- CycleWindows
  -- , ((0, 0x1008ff11),                   spawn "amixer -c 0 -q sset Master 3%-")
  -- , ((0, 0x1008ff13),                   spawn "amixer -c 0 -q sset Master 3%+")
  , ((0, xK_Print),                     spawn "xdotool keyup 0xff61 && scrot -s /tmp/scrot.png -e 'xclip -sel clip -t image/png /tmp/scrot.png && rm /tmp/scrot.png'")
  , ((0, 0x1008ff11),                   spawn "pamixer --decrease 6")
  , ((0, 0x1008ff13),                   spawn "pamixer --increase 6")
  , ((0, 0x1008ff03),                   spawn "/bin/bash -c 'xbacklight -dec 10 -time 75; if [[ $(xbacklight) == \"0.000000\" ]]; then xbacklight -set 0.1; fi'")
  -- , ((0, 0x1008ff03),                   spawn "xbacklight -dec 10")
  , ((0, 0x1008ff02),                   spawn "xbacklight -inc 40")
  , ((0, 0x1008ff12),                   spawn "pamixer -t")
  -- , ((0, 0x1008ff12),                   spawn "amixer -c 0 set Master toggle;    \
  --                                             \ amixer -c 0 set Headphone unmute; \
  --                                             \ amixer -c 0 set 'Bass Speaker' unmute; \
  --                                             \ amixer -c 0 set Speaker unmute")
    -- XF86AudioLowerVolume
  -- , ((0, 0x1008ff11), spawn "")
    -- XF86AudioRaiseVolume
  -- , ((0, 0x1008ff13), spawn "")
    -- XF86AudioMute
  -- , ((0, 0x1008ff12), spawn "")
    -- XF86AudioNext
  -- , ((0, 0x1008ff17), spawn "")
    -- XF86AudioPrev
  -- , ((0, 0x1008ff16), spawn "")
    -- XF86AudioStop
  -- , ((0, 0x1008ff15), spawn "")
    -- XF86AudioPlay
  -- , ((0, 0x1008ff14), spawn "xdotool key space")
  ]

startup =
  ewmhDesktopsStartup
  >> setWMName "LG3D"
  >> spawn "setxkbmap 'se2_qwerty(programmer)'"
  >> spawn "xrdb ~/.Xresources"
  -- >> spawn "feh --bg-scale ~/Downloads/photo-1418065460487-3e41a6c84dc5.jpg"
  >> spawn "feh --bg-scale ~/bg.jpg"
  -- >> spawn "xscreensaver -no-splash"
  >> spawn "xhost +"

--  setWMName "LG3D"
main -- do
 =
  xmonad
  -- =<< xmobar
    (ewmh $
     defaultConfig
     { modMask = mod4Mask
     , terminal = "urxvt"
     -- , layoutHook = avoidStruts myLayout
     -- , layoutHook = spacing 0 $ avoidStruts $ myLayout
     , layoutHook = smartSpacingWithEdge 5 $ avoidStruts $ myLayout
     , borderWidth = 2
     , focusFollowsMouse = False
     , normalBorderColor = "#000000"
     , focusedBorderColor = "#CCFF55"
     -- , focusedBorderColor = "#AA4444"
     , manageHook = myManageHook <+> manageHook gnomeConfig
     , handleEventHook = evHook
     , keys = myKeys <+> keys gnomeConfig
     , startupHook = startup
     , logHook =
         do ewmhDesktopsLogHook
            setWMName "LG3D"
     })

--    xmproc <- spawnPipe "xmobar ~/dotfiles/.xmonad/.xmobarrc"
--    xmonad $ gnomeConfig {
-- Helper functions to fullscreen the window
fullFloat, tileWin :: Window -> X ()
fullFloat w = windows $ W.float w r
  where
    r = W.RationalRect 0 0 1 1

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
  when (typ == state && fromIntegral fullsc `elem` tail dat) $ do
    when (action == add || (action == toggle && not isFull)) $ do
      io $
        changeProperty32
          dpy
          win
          state
          ptype
          propModeReplace
          [fromIntegral fullsc]
      fullFloat win
    when (head dat == remove || (action == toggle && isFull)) $ do
      io $ changeProperty32 dpy win state ptype propModeReplace []
      tileWin win
  -- It shouldn't be necessary for xmonad to do anything more with this event
  return $ All False
evHook _ = return $ All True
