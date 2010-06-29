"Koga kje otvoram ro fajl so obichen juzer da mozham da go sochuvam.
command W w !sudo tee % > /dev/null

set tabstop=4
set softtabstop=4
set expandtab
set background=dark
set fileformat=unix
syntax enable

"Da pamti koja posledna linija sum ja gledal vo fajlovite
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

start
