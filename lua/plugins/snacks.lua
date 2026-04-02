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
      width = 60,
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
      sections = {
        {
          section = "header",
        },
        { section = "keys", gap = 1, padding = 1 },
        {
          pane = 2,
          icon = " ",
          desc = "Browse Repo",
          padding = 1,
          key = "b",
          action = function()
            Snacks.gitbrowse()
          end,
        },
        function()
          local in_git = Snacks.git.get_root() ~= nil
          local cmds = {
            {
              title = "Notifications",
              cmd = 'GH_HOST="github.ibm.com" gh notify -s -n5',
              action = function()
                vim.ui.open("https://github.ibm.com/notifications")
              end,
              key = "N",
              icon = " ",
              height = 5,
              enabled = true,
            },
            {
              icon = " ",
              title = "Open PRs",
              cmd = "gh pr list -L 3",
              key = "P",
              action = function()
                vim.fn.jobstart("gh pr list --web", { detach = true })
              end,
              height = 7,
            },
            {
              title = "Releases",
              cmd = "gh release list -L 3",
              key = "i",
              action = function()
                vim.fn.jobstart("gh release list --web", { detach = true })
              end,
              icon = " ",
              height = 7,
            },
            {
              icon = " ",
              title = "Git Status",
              cmd = "git --no-pager diff --stat -B -M -C",
              height = 10,
            },
          }
          return vim.tbl_map(function(cmd)
            return vim.tbl_extend("force", {
              pane = 2,
              section = "terminal",
              enabled = in_git,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            }, cmd)
          end, cmds)
        end,
        { section = "startup" },
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
