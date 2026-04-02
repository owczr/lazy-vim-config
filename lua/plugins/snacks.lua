return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = {
      preset = {
        header = [[
                       ,----.__                         |  
                     ,'        `.                       |  
                 _  /            :                      ,-.
                |.`:              :                    /  -
 ,'''''-._      | )               :                 _.'  --
/         '.  _.`.   (88o    _    |_           _.-''      -
|           `/    |   """   9@8o  / )-..__._.-'      ,/'`-/
\     \    ,:     `.         ""  :_/              ,-'  |   
 :     \-_/        `. `a,    ,   :              ,'    /    
  `.    Y'       ,_  \ "7888"  ,'   _.--''''---')     |    
    \ .'      _/'  `._\      ,'---.<...        /     |     
    .'      ,' '-.._   ':._,::...,'   /'     ,'      /     
   /'     ,/        '`''''           /     ,'       /      
  ,'    /  :                        /    ,'       ,-''''._ 
  |    ()   :                      |    |      .-'        '
  `.   :     ) __............____ .'    |_ .--'            
   `.   `.  ,'                   `/       `'-.__           
.--'>    : /                     |   __...-._   `\         
  .' |   `.                      "--'        ` ._/'--._    
/'    |   `.                                           'akn
.,   /|     :                                            \.
  `'' :     :\                                             
      )     :.:                                            
      : ; . ; '                                            
      '_: . '                                              
        '_:'                                               
]],
      },
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
}
