vim9script

nno <Leader>-        <Cmd>History!<CR>
nno <Leader><Leader> <Cmd>Buffers!<CR>
nno <Leader>f,       <Cmd>Files! ~/git/dotfiles<CR>
nno <Leader>ff       <Cmd>Files!<CR>
nno <Leader>fg       <Cmd>Rg!<CR>
nno <Leader>fh       <Cmd>Helptags!<CR>

def FSpell()
    const suggestions = spellsuggest(expand('<cword>'))
    if empty(suggestions) | return | endif
    fzf#run(fzf#wrap({ source: suggestions, sink: (word) => execute($'norm! ciw{word}') }))
enddef
nno z= <ScriptCmd>FSpell()<CR>

def Frog(query: string)
    fzf#vim#grep2('rg --vimgrep --fixed-strings --multiline --', query, fzf#vim#with_preview(), false)
enddef
nno <Leader>fw <ScriptCmd>Frog(expand('<cword>'))<CR>
nno <Leader>Fw <ScriptCmd>Frog(expand('<cword>'))<CR>
nno <Leader>fW <ScriptCmd>Frog(expand('<cWORD>'))<CR>
nno <Leader>FW <ScriptCmd>Frog(expand('<cWORD>'))<CR>
nno <Leader>fv <ScriptCmd>Frog(join(getregion(getpos("'<"), getpos("'>"), { type: visualmode() }), "\n"))<CR>
vno <Leader>fv <ScriptCmd>Frog(join(getregion(getpos("'<"), getpos("'>"), { type: visualmode() }), "\n"))<CR>

def Thesaur()
    const bind =<< trim EOF
        enter:transform:(
           if [[ {} != *,* ]]
           then echo "accept"
           else echo "hide-preview+reload(echo {} | tr , '\n' | tail +2 | shuf)+clear-query+change-header:[Thesaurus for: \"$(echo {} | cut -d, -f1)\"]"
           fi
        )
    EOF
    fzf#run({
        source: 'cat $XDG_DATA_HOME/nvim/mthesaur.txt',
        sink: (res) => execute($'norm {mode() == 'v' ? 'c' : 'a'}{res}'),
        options: [
            '-i', '-d,', '--with-nth={1}',
            '--header', '[Complete thesaurus]',
            '--preview', 'echo {} | tr , "\n" | tail +2 | shuf | COLUMNS=$FZF_PREVIEW_COLUMNS column',
            '--bind', bind->join(';'),
            '--query', mode() == 'v' ? expand('<cword>') : '',
        ],
        tmux: '40%,40%',
    })
enddef
nno <Leader>fa <ScriptCmd>Thesaur()<CR>
vno <Leader>fa <ScriptCmd>Thesaur()<CR>
