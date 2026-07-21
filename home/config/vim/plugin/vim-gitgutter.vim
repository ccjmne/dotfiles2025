vim9script

g:gitgutter_signs = 0
g:gitgutter_highlight_linenrs = 1

au ColorScheme * hi link GitGutterAddLineNr    Added
au ColorScheme * hi link GitGutterChangeLineNr Changed
au ColorScheme * hi link GitGutterDeleteLineNr Removed

nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)
omap ih <Plug>(GitGutterTextObjectInnerPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
