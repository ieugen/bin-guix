(define-module (bin-guix packages babashka)
   #:use-module (guix packages)
   #:use-module (guix download)
   #:use-module (guix build-system copy)
   #:use-module (guix licenses))

(define-public babashka
  (package
    (name "babashka")
    (version "1.1.172")
    (source (origin
             (method url-fetch)
             (uri (string-append "https://github.com/babashka/babashka/releases/download/v"
                                 version "/babashka-" version "-linux-amd64-static.tar.gz" ))
             (sha256
              (base32 "0r2r1hhn6q8dxryj0p2szqw8jfxh3z2r025nnp6hbw0d881115dc"))))
    (build-system copy-build-system)
    (arguments
     `(#:install-plan '(("bb" "bin/"))))
    (synopsis "Native, fast starting Clojure interpreter for scripting")
    (description "Babashka is a native Clojure interpreter for scripting with fast startup. Its main goal is to leverage Clojure in places where you would be using bash otherwise.")
    (home-page "https://babashka.org/")
    (license epl1.0)))
