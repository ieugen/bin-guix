(define-module (bin-guix packages gum)
   #:use-module (guix packages)
   #:use-module (guix download)
   #:use-module (guix build-system copy)
   #:use-module (guix licenses))

(define-public gum
  (package
    (name "gum")
    (version "0.9.0")
    (source (origin
             (method url-fetch)
             (uri (string-append "https://github.com/charmbracelet/gum/releases/download/v"
             version "/gum_" version "_Linux_x86_64.tar.gz"))
             (sha256
              (base32 "0jvsjamz8rlrjymcbmd8wi7b6a0bn10ckd437zj9na5a8x56ig4p"))))
    (build-system copy-build-system)
    (supported-systems '("x86_64-linux" "i686-linux"))
    (arguments
     `(#:install-plan '(("../gum" "bin/")
                        ;; we should install the other provided completions
                        ("../completions/gum.bash" "share/bash-completion/completions/gum")
                        ("../manpages/" "share/man/man1/"))))
    (synopsis "A tool for glamorous shell scripts ribbon")
    (description "Gum provides highly configurable, ready-to-use utilities to help you write useful shell scripts and dotfiles aliases with just a few lines of code.")
    (home-page "https://github.com/charmbracelet/gum")
    (license expat)))
