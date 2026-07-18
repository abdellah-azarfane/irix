;;; init.el -*- lexical-binding: t; -*-

(doom! :input
       ;;bidi              ; (tfel ot) thgir etirw uoy gnipleh
       ;;chinese
       ;;japanese
       ;;layout            ; auie,ctsrnm is the superior home row

       :completion
       ;;company           ; the ultimate code completion backend
       (corfu +orderless)  ; complete with cap(f), cape and a flying feather!
       ;;helm              ; the *other* search engine for love and life
       ;;ido               ; the other *other* search engine...
       ;;ivy          ; in-buffer completion
       (vertico +icons)          ; minibuffer completion

       :ui
       doom                      ; visual theme framework
       doom-dashboard            ; custom start screen
       hl-todo                   ; highlight TODO/FIXME/etc in comments
       indent-guides             ; visual indentation guides
       ligatures                 ; JetBrainsMono NF renders these natively
       modeline                  ; custom mode-line
       nav-flash                 ; blink cursor line after big motions
       ophints                   ; highlight the region an operation acts on
       (popup +defaults)         ; tame sudden yet inevitable temporary windows
       treemacs                  ; a project file drawer, like neotree but cooler
       (vc-gutter +pretty)       ; vcs diff in the fringe
       vi-tilde-fringe           ; fringe tildes to mark beyond EOB
       window-select             ; visually switch windows
       workspaces                ; tab emulation, persistence & separate workspaces
       ;;deft              ; notational velocity for Emacs
       ;;doom-quit         ; DOOM quit-message prompts when you quit Emacs
       (emoji +unicode)  ; 🙂
       ;;ligatures         ; ligatures and symbols to make your code pretty again
       ;;minimap           ; show a map of the code on the side
       ;;neotree           ; a project drawer, like NERDTree for vim
       smooth-scroll     ; So smooth you won't believe it's not butter
       ;;tabs              ; a tab bar for Emacs
       unicode           ; extended unicode support for various languages
       zen               ; distraction-free coding or writing



       :editor
       (evil +everywhere)        ; strict vim keybindings, everywhere
       file-templates            ; auto-snippets for empty files
       fold                      ; (n)vim-like code folding
       (format +onsave)          ; auto-format via clang-format/rustfmt/black on save
       multiple-cursors          ; editing in many places at once
       snippets                  ; my elves. They type so I don't have to
       word-wrap                 ; soft wrapping with language-aware indent
       ;;lispy             ; vim for lisp, for people who don't like vim
       ;;objed             ; text object editing for the innocent
       ;;parinfer          ; turn lisp into python, sort of
       ;;rotate-text       ; cycle region at point between text candidates


       :emacs
       dired                     ; making dired pretty [functional]
       electric                  ; smarter, keyword-based electric-indent
       eww                       ; the internet is gross
       ibuffer                   ; intercative buffer management
       (undo +tree)              ; persistent, tree-based undo for evil
       vc                        ; version-control and basic git integration

       :term
       eshell                    ; the elisp shell that works everywhere
       vterm                     ; the best terminal emulation in Emacs
       ;;shell             ; simple shell REPL for Emacs
       ;;term              ; basic terminal emulator for Emacs


       :checkers
       syntax                    ; tasing you for every semicolon you forget
       (spell +flyspell)         ; tasing you for misspelling mispelling
       grammar           ; tasing grammar mistake every you make


       :tools
       direnv                    ; picks up nix-shell / flake devShells per-project
       (eval +overlay)           ; run code, run (also, repls)
       lookup                    ; navigate your code and its documentation
       (lsp +peek)               ; M-x vscode
       magit                     ; a git porcelain for Emacs
       pdf                       ; pdf enhancements
       ;;ansible
       ;;biblio            ; Writes a PhD for you (citation needed)
       ;;collab            ; buffers with friends
       ;;debugger          ; FIXME stepping through code, to help you add bugs
       ;;docker
       ;;editorconfig      ; let someone else argue about tabs vs spaces
       ;;ein               ; tame Jupyter notebooks with emacs
       ;;llm               ; when I said you needed friends, I didn't mean...
       ;;lsp               ; M-x vscode
       ;;make              ; run make tasks from Emacs
       ;;pass              ; password manager for nerds
       ;;terraform         ; infrastructure as code
       ;;tmux              ; an API for interacting with tmux
       ;;tree-sitter       ; syntax and parsing, sitting in a tree...
       ;;upload            ; map local to remote projects via ssh/ftp


       :os
       (:if (featurep :system 'macos) macos)  ; improve compatibility with macOS
       tty                       ; improve the terminal Emacs experience

       :lang
       (cc +lsp +tree-sitter)              ; C/C++/Obj-C via clangd C > C++ == 1
       emacs-lisp                          ; drown in parentheses
       json                                ; JavaScript Object Notation
       markdown                            ; writing docs for people to ignore
       nix                                 ; I hereby declare "nix geht mehr!"
       (org +roam2 +pomodoro +pretty)      ; organize your plain life in plain text
       (python +lsp +pyright +tree-sitter) ; beautiful is better than ugly
       (rust +lsp +tree-sitter)            ; Fe2O3.unwrap().unwrap().unwrap().fall()
       sh                                  ; she sells {ba,z,fi}sh shells on the C xor
       yaml                                ; JSON, but readable
       data                                ; config/data formats
       (haskell +lsp)                      ; a language that's lazier than I am
       (graphql +lsp)                      ; Give querties a REST
       gdscript                            ; the language you waited for
       ;;agda                              ; types of types of types of types...
       ;;beancount                         ; mind the GAAP
       ;;clojure                           ; java with a lisp
       ;;common-lisp                       ; if you've seen one lisp, you've seen them all
       ;;coq                               ; proofs-as-programs
       ;;crystal                           ; ruby at the speed of c
       ;;csharp                            ; unity, .NET, and mono shenanigans
       ;;(dart +flutter)                   ; paint ui and no much else
       ;;dhall
       ;;elixir                            ; erlang done right
       ;;elm                               ; care for a cup of TEA?
       ;;erlang                            ; an elegant language for a more civilized age
       ;;ess                               ; emacs speaks statistics
       ;;factor
       ;;faust                             ; dsp, but you get to keep your soul
       ;;fortran                           ; in FORTRAN, GOD is REAL (unless declared INTEGER)
       ;;fsharp                            ; ML stands for Microsoft's Language
       ;;fstar                             ; (dependent) types and (monadic) effects and Z3
       ;;(go +lsp)                         ; the hipster dialect
       ;;hy                                ; readability of scheme w/ speed of python
       ;;idris                             ; a language you can depend on
       ;;janet                             ; Fun fact: Janet is me!
       ;;(java +lsp)                       ; the poster child for carpal tunnel syndrome
       javascript                        ; all(hope(abandon(ye(who(enter(here))))))
       julia                             ; a better, faster MATLAB
       ;;kotlin                            ; a better, slicker Java(Script)
       latex                             ; writing papers in Emacs has never been so fun
       ;;lean                              ; for folks with too much to prove
       ;;ledger                            ; be audit you can be
       lua                               ; one-based indices? one-based indices
       ;;nim                               ; python + lisp at the speed of c
       ;;ocaml                             ; an objective camel
       ;;php                               ; perl's insecure younger brother
       ;;plantuml                          ; diagrams for confusing people more
       ;;graphviz                          ; diagrams for confusing yourself even more
       ;;purescript                        ; javascript, but functional
       qt                                ; the 'cutest' gui framework ever
       ;;racket                            ; a DSL for DSLs
       ;;raku                              ; the artist formerly known as perl6
       ;;rest                              ; Emacs as a REST client
       ;;rst                               ; ReST in peace
       ;;(ruby +rails)                     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       ;;scala                             ; java, but good
       ;;(scheme +guile)                   ; a fully conniving family of lisps
       ;;sml
       ;;solidity                          ; do you need a blockchain? No.
       ;;swift                             ; who asked for emoji variables?
       ;;terra                             ; Earth and Moon in alignment for performance.
       ;;web                               ; the tubes
       zig                               ; C, but simpler

       :email
       ;;(mu4e +org +gmail)
       ;;notmuch
       ;;(wanderlust +gmail)

       :app
       ;;calendar
       emms
       ;;everywhere        ; *leave* Emacs!? You must be joking
       ;;irc               ; how neckbeards socialize
       (rss +org)        ; emacs as an RSS reader

       :config
       literate
       (default +bindings +smartparens))
