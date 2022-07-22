local which_key = require('which-key')
    
which_key.register({
    f = {
        name = 'File',
        f = {'<cmd>Telescope find_files<cr>', 'Open'},
        g = {'<cmd>Telescope git_files<cr>', 'Open From Git Repo'},
        r = {'<cmd>Telescope oldfiles<cr>', 'Open Recent File'},
        n = {'<cmd>enew<cr>', 'New'},
        s = {'<cmd>w<cr>', 'Save'},
    },
    b = {
        name = 'Buffer',
        n = {'<cmd>BufferNext<cr>', 'Next'},
        p = {'<cmd>BufferPrev<cr>', 'Prev'},
        N = {'<cmd>BufferMoveNext<cr>', 'Next'},
        P = {'<cmd>BufferMovePrev<cr>', 'Prev'},
        b = {'<cmd>Telescope buffers<cr>', 'Switch Buffer'},
    },
    ['1'] = {'<cmd>BufferGoto 1<cr>', 'Buffer 1'},
    ['2'] = {'<cmd>BufferGoto 2<cr>', 'Buffer 2'},
    ['3'] = {'<cmd>BufferGoto 3<cr>', 'Buffer 3'},
    ['4'] = {'<cmd>BufferGoto 4<cr>', 'Buffer 4'},
    ['5'] = {'<cmd>BufferGoto 5<cr>', 'Buffer 5'},
    ['6'] = {'<cmd>BufferGoto 6<cr>', 'Buffer 6'},
    ['7'] = {'<cmd>BufferGoto 7<cr>', 'Buffer 7'},
    ['8'] = {'<cmd>BufferGoto 8<cr>', 'Buffer 8'},
    ['9'] = {'<cmd>BufferGoto 9<cr>', 'Buffer 9'},
    ['0'] = {'<cmd>BufferGoto 10<cr>', 'Buffer 10'},
    Q = {'<cmd>qa!<cr>', 'Quit'},
}, {prefix = '<leader>'})

which_key.setup {
    key_labels = {
        ['<leader>'] = 'LDR',
        ['<cr>'] = 'RET',
        ['<tab>'] = 'TAB',
    }
}
