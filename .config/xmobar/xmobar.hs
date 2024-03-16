import Xmobar

config :: Config
config =
    defaultConfig
        { font = "BlexMono Nerd Font Mono 14" -- "JetBrainsMonoNL Nerd Font Mono 14"
        , additionalFonts = [ "BlexMono Nerd Font Mono 10" -- "JetBrainsMonoNL Nerd Font Mono 18"
                            , "BlexMono Nerd Font Mono 14" -- "JetBrainsMonoNL Nerd Font Mono 28"
                            , "BlexMono Nerd Font Mono 18" -- "JetBrainsMonoNL Nerd Font Mono 28"
                            , "BlexMono Nerd Font Mono 22" -- "JetBrainsMonoNL Nerd Font Mono 28"
                            , "BlexMono Nerd Font Mono 26" -- "JetBrainsMonoNL Nerd Font Mono 28"
                            ]
       --, borderColor = "black"
       --, border = TopB
       , bgColor = "#222020"
       , fgColor = "#bdb7b5"
       , alpha = 230
       , position = TopH 28
       , textOffset = 0
       , textOffsets = [0, 0]
       --, iconOffset = -1
       , lowerOnStart = True
       , pickBroadest = False
       , persistent = False
       , hideOnStart = False
       , iconRoot = "."
       , allDesktops = True
       , overrideRedirect = True
       , commands = [ Run $ DynNetwork [ "-t", "<box color=#15b1b1 type=Top width=2><fc=#15b1b1><rxipat></fc><hspace=5/><rx></box>\
                                             \  \
                                             \<box color=#ce78c3 type=Top width=2><fc=#ce78c3><txipat></fc><hspace=5/><tx></box>"
                                     , "-L", "0", "-l", "#bdb7b588"
                                     , "-w", "7"
                                     , "-a", "r", "-c", " "
                                     , "-S", "True"
                                     , "--"
                                     , "--tx-icon-pattern", "<fn=4>\xf0aa</fn>"
                                     , "--rx-icon-pattern", "<fn=4>\xf0ab</fn>"
                                     ] 10
                    , Run $ MultiCpu ["-t", "<box type=Top color=#aa9c30 width=2><fn=4><fc=#aa9c30>\xf0ee0</fc></fn><hspace=5/><total></box>","-H","70", "-m", "3", "-a", "r", "-c", "%   "
                              , "--high","red"] 10
                    , Run $ Memory ["-t","<box type=Top color=#e37376 width=2><fc=#e37376><fn=4>\xf035b</fn></fc><hspace=5/><used>M (<usedratio>%)</box>"] 10
                    , Run $ Date "%a %b %_d %Y %H:%M" "date" 60
                    , Run $ DiskU [("/", "<box type=Top color=#7e9be3 width=2><fc=#7e9be3><fn=4>\xf0a0</fn></fc><hspace=5/><free></box>")] ["-L", "20", "-H", "50", "-m", "1", "-p", "3"] 20
                    , Run $ CpuFreq ["-t", "<box type=Top color=#aa9c30 width=2><fn=4><fc=#aa9c30>\xf04c5</fc></fn><hspace=5/><avg>GHz</box>"] 10
                    , Run $ Kbd []
                    , Run $ Alsa "default" "Master" [ "-w", "4", "-t", "<status>", "-c", "%   ", "-a", "r", "--"
                                                  --, "--highs", "<fn=2>\xfa7d</fn>"
                                                  --, "--mediums", "<fn=2>\xfa7f</fn>"
                                                  --, "--lows", "<fn=2>\xf057f</fn>"
                                                    , "--on", "<fn=3>\xf057e</fn><hspace=5/><volume>", "-C", "#bdb7b5"
                                                    , "--off", "<fn=3>\xf075f</fn><hspace=5/><volume>", "-c", "#bdb7b588"
                                                    ]
                    , Run XMonadLog
                    , Run $ Com "bash" ["-c", "~/.config/xmobar/bluetooth.sh"] "bluetooth" 3
                    , Run $ Com "echo" ["<fn=4>\xf01e7</fn>"] "kbd-icon" 0
                    , Run $ MultiCoreTemp ["-t", "<box type=Top color=#aa9c30 width=2><fc=#aa9c30><fn=1>\xf050f</fn></fc><hspace=5/><avg>\x00b0\x43</box>", "-H", "80", "-h", "red"] 10
                    ]
       , sepChar = "%"
       , alignSep = "]["
       , template = " %XMonadLog%]%date%[\ \<action=`alacritty -e htop`><box type=Top color=#aa9c30 width=2>%multicpu% %cpufreq% %multicoretemp%</box></action>  %memory%  <action=`nautilus`>%disku%</action>  %dynnetwork%  <action=`blueman-manager`>%bluetooth%</action>  <box type=Top width=2><action=`pavucontrol`>%alsa:default:Master%</action> %kbd-icon%<hspace=5/>%kbd%</box> "
       }

main :: IO ()
main = xmobar config
