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

-- http://charlieharvey.org.uk/src/xmonad.hs.txt
--
myManageHook = composeAll [
    (className =? "Pidgin" <&&> (title =? "Pidgin" <||> title =? "Accounts")) --> doCenterFloat
  , (className =? "Pidgin") --> doShift "3"
  , (className =? "Gnome-panel" <&&> title =? "Run Application") --> doCenterFloat
  , (className =? "Gcr-prompter") --> doCenterFloat
  , (className =? "Xfce4-notifyd" -->  doIgnore)
  , isFullscreen --> doFullFloat
   ]

--myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
--    [
--        ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
--    ]

--myKeys (XConfig {modMask = mod4Mask}) = M.fromList $
--    [ ((mod4Mask, xK_p), gnomeRun) ]

main = xmonad $ gnomeConfig {
    modMask             = mod4Mask
  , layoutHook          = smartBorders (layoutHook gnomeConfig)
  , borderWidth         = 2
  , focusFollowsMouse   = False
--, normalBorderColor   = "#cccccc"
--, focusedBorderColor  = "#3300ff"
  , manageHook          = myManageHook <+> manageHook gnomeConfig
  , handleEventHook     = evHook
--, keys                = myKeys <+> keys gnomeConfig
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
