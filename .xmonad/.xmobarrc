Config { font = "-*-Fixed-Bold-R-Normal-*-13-*-*-*-*-*-*-*"
       , bgColor = "black"
       , fgColor = "grey"
       , position = TopW L 90
       , commands = [ Run Weather "LJLJ" ["-t"," C","-L","64","-H","77","--normal","green","--high","red","--low","lightblue"] 36000
                    , Run Cpu ["-L","3","-H","50","--normal","green","--high","red"] 10
                    , Run Network "wlan1" ["-L","0","-H","32","--normal","green","--high","red"] 10
                    , Run Memory ["-t","Mem: %"] 10
                    , Run Swap [] 10
                    , Run Date "%a %b %_d %l:%M" "date" 10
                    , Run Battery ["-t","Batt: % / ","-L","25","-H","75","-h","green","-n","yellow","-l","red","--","-c","energy_full"] 10
                    , Run StdinReader
                    , Run CommandReader "/usr/bin/ledmon" "LED"
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{ %LED% %cpu% | %battery% | %memory% * %swap% | %wlan1%   %date% | %LJLJ%"
       }
