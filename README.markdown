# deckset.vim

Open the current Markdown buffer in [Deckset](http://decksetapp.com/). 

deckset.vim is entirely based on [marked.vim](https://github.com/itspriddle/vim-marked)
so all credit goes to itspriddle.

**Note**: Since Deckset is available only for OS X, this plugin will not be loaded
unless you are on OS X.

## Usage

This plugin adds the following commands to Markdown buffers:

    :DecksetOpen[!]          Open the current Markdown buffer in Deckset. Call with
                            a bang to prevent Deckset from stealing focus from Vim.
                            Documents opened in Deckset are tracked and closed
                            automatically when you quit Vim.

    :DecksetQuit             Close the current Markdown buffer in Deckset. Quits
                            Deckset if there are no other documents open.

## License

Same as Vim itself, see `:help license`.
