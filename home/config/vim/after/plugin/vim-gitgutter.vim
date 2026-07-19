vim9script

hi default link GitGutterAdd    Added
hi default link GitGutterChange Changed
hi default link GitGutterDelete Removed

nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)
omap ih <Plug>(GitGutterTextObjectInnerPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
