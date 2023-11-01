import XMonad
import XMonad.Layout.Spacing
import XMonad.Actions.NoBorders
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ docks myConfig
    
myConfig = def 
    { terminal = myTerminal
    , workspaces = myWorkspaces
    , modMask = myModMask
    , keys = myKeys
    , focusFollowsMouse = myFocusFollowsMouse
    , focusedBorderColor = myFocusedBorderColor
    , normalBorderColor = myNormalBorderColor
    , borderWidth = myBorderWidth
    , layoutHook = myLayoutHook
    }

myTerminal = "kitty"
myBrowser = "brave"
myEditor = "kitty nvim"
myFileExplorer = "kitty lf"
myWorkspaces = ["1","2","3","4","5","6","7","8","9"]
myModMask = mod4Mask
myFocusFollowsMouse = True
myBorderWidth = 3
myNormalBorderColor = "#444444"
myFocusedBorderColor = "#ffffff"
myLayoutHook = avoidStruts $ spacingWithEdge 10 $ layoutHook def

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modMask, xK_d), spawn "dmenu_run")
    , ((modMask, xK_w), spawn myBrowser)
    , ((modMask, xK_v), spawn myEditor)
    , ((modMask, xK_r), spawn myFileExplorer)
    , ((modMask, xK_j), windows W.focusDown)
    , ((modMask, xK_k), windows W.focusUp)
    , ((modMask, xK_h), sendMessage Shrink)
    , ((modMask, xK_l), sendMessage Expand)
    , ((modMask, xK_f), toggleFull)
    , ((modMask, xK_space), windows W.swapMaster)
    , ((modMask, xK_q), kill)
    ]
    ++
    [ ((m .|. modMask, k), windows $ f i) 
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)] 
    ]

toggleFull = withFocused (\windowId -> do {
   floats <- gets (W.floating . windowset);
   if windowId `M.member` floats
   then do
       withFocused $ toggleBorder           
       withFocused $ windows . W.sink        
   else do
       withFocused $ toggleBorder           
       withFocused $ windows . (flip W.float $ W.RationalRect 0 0 1 1)
})
