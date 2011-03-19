-- Na tretiot TAG mu go menuvam layout da mu bide tile sekoj pat.
awful.tag.setproperty(tags[primary_screen][3], "mwfact", 0.30)
awful.tag.setproperty(tags[primary_screen][3], "layout", awful.layout.suit.tile)

--na vtoriot tag kaj shto mi e firefox da bide floating
awful.tag.setproperty(tags[primary_screen][2], "layout", awful.layout.suit.floating)

-- Na pettiot TAG layout da bide site floating.
awful.tag.setproperty(tags[primary_screen][5], "layout", awful.layout.suit.floating)

if screen.count() > 1 then
    awful.tag.setproperty(tags[screen.count()][3], "layout", awful.layout.suit.floating)
end

-- prviot tag na vtoriot ekran da bide max
if screen.count() > 1 then
    awful.tag.setproperty(tags[screen.count()][1], "layout", awful.layout.suit.max)
end

-- vtoriot tag na vtoriot ekran da bide tiled za mnogu terminali
if screen.count() > 1 then
    awful.tag.setproperty(tags[screen.count()][2], "layout", awful.layout.suit.fair.horizontal)
end


awful.rules.rules = {
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    -- FIREFOX
    { rule = { class = "Firefox" },
      properties = { tag = tags[primary_screen][2], border_width = 2, floating = true } },
    { rule = { class = "Firefox", instance = "Navigator", role = "browser" },
      properties = { floating = false, border_width = 0 } },
    { rule = { class = "Minefield" },
      properties = { tag = tags[primary_screen][2], border_width = 2, floating = true } },
    { rule = { class = "Minefield", instance = "Navigator", role = "browser" },
      properties = { floating = false, border_width = 0 } },
    { rule = { class = "Minefield", instance = "Navigator"},
      properties = { floating = false, border_width = 0 } },

    -- Terminali, Ako ima dva ekrana na vtoriot ekran na prviot tag. Ako ima eden na prviot
    { rule = { class = "URxvt" },
        properties = { border_width = 2, size_hints_honor = false },
        callback = function(c)
                        if screen.count() > 1 then
                            awful.client.movetotag(tags[screen.count()][1], c)
                        else
                            awful.client.movetotag(tags[primary_screen][1], c)
                        end
                    end},

    --drugite xterm terminali
   { rule = { class = "XTerm" },
        properties = { border_width = 2, size_hints_honor = false },
        callback = function(c)
                        if screen.count() > 1 then
                           awful.client.movetotag(tags[screen.count()][1], c)
                        else
                            awful.client.movetotag(tags[primary_screen][1], c)
                        end
                    end},

    --ssh_do_doma
    { rule = { class = "XTerm", name="ne_me_gasi" },
            properties = { floating = true, border_width = 2, size_hints_honor = true },
            callback = function(c)
                        awful.client.movetotag(tags[screen.count()][5], c)
                    end},

    -- CSSH
    -- site cssh terminali i cssh kontrolata
    { rule = { class = "Cssh" },
        properties = { border_width = 2, size_hints_honor = true },
        callback = function(c)
                    if screen.count() > 1 then
                           awful.client.movetotag(tags[screen.count()][2], c)
                    else
                            awful.client.movetotag(tags[primary_screen][5], c)
                    end
                end},
    
    { rule = { class = "XTerm", name="^CSSH:" },
        properties = { border_width = 2, size_hints_honor = true },
        callback = function(c)
                        if screen.count() > 1 then
                            awful.client.movetotag(tags[screen.count()][2], c)
                        else
                            awful.client.movetotag(tags[primary_screen][5], c)
                        end
                    end},
    
    --ssh_do_domav
    { rule = { class = "XTerm", name="ne_me_gasi" },
      properties = { tag = tags[primary_screen][5], floating = true, border_width = 2, size_hints_honor = true } },

    -- IRC
    { rule = { class = "Konversation" },
      properties = { tag = tags[primary_screen][4] } },
    
    -- Skype i Pidgin
    { rule = { class = "Skype" },
        properties = { tag = tags[primary_screen][3] } },
    { rule = { class = "Skype", role="MainWindow" },
        properties = { tag = tags[primary_screen][3], floating = true } },

    { rule = { class = "Pidgin" },
        properties = { tag = tags[primary_screen][3] } },
    { rule = { class = "Pidgin", role="buddy_list" },
        properties = { tag = tags[primary_screen][3], floating = true } },

     -- rdesktop, Ako ima dva ekrana na vtoriot ekranna prviot tag. Ako ima eden na pettiot
     { rule = { class = "rdesktop" }, 
        callback = function(c) 
                        if screen.count() > 1 then
                            awful.client.movetotag(tags[screen.count()][1], c) 
                        else
                            awful.client.movetotag(tags[1][5], c)
                        end
                    end},
 
}

