tagnames = {"term", "web", "im", "comm", "razno"} --na prviot ekran
tagnames2 = {"1", "2", "3" } --na vtoriot ekran

os.setlocale(os.getenv('LANG'), 'all')

primary_screen=1

-- startup
awful.util.spawn("nitrogen --restore", false)
