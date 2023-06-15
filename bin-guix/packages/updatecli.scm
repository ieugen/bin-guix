(define-module (bin-guix packages updatecli)
   #:use-module (guix packages)
   #:use-module (guix download)
   #:use-module (guix build utils)
   #:use-module (guix build-system copy)
   #:use-module ((guix licenses) #:prefix licenses:))

(define-public updatecli
  (package
    (name "updatecli")
    (version "0.52.0")
    (source (origin
             ;; https://lists.gnu.org/archive/html/help-guix/2020-12/msg00218.html
             (method url-fetch/tarbomb) ;; contents are not in a firectory => url-fetch/tarbomb
             (uri (string-append "https://github.com/updatecli/updatecli/releases/download/v" version
                                 "/updatecli_Linux_x86_64.tar.gz"))
             (sha256
              (base32 "02ily73fpcdzjyx11ls0jdqd381flm53cf3555z7plhqaa01nwl4"))))
    (build-system copy-build-system)
    (supported-systems '("x86_64-linux"))
    (arguments
     `(#:install-plan '(("updatecli" "bin/")
                        ("manpages/updatecli.1.gz" "share/man/man1/")
                        ("completions/updatecli.bash" "etc/completion/bash/updatecli")
                        ("completions/updatecli.fish" "etc/completion/fish/updatecli")
                        ("completions/updatecli.zsh" "etc/completion/zsh/updatecli"))))
    (synopsis "A Declarative Dependency Management tool")
    (description "Updatecli is a tool used to apply file update strategies.")
    (home-page "https://github.com/updatecli/updatecli")
    (license licenses:asl2.0)))
