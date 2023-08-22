(define-module (bin-guix packages babashka)
   #:use-module (guix packages)
   #:use-module (guix download)
   #:use-module (guix build-system copy)
   #:use-module ((guix licenses) #:prefix licenses:))

(define-public babashka
  (package
    (name "babashka")
    (version "1.3.183")
    (source (origin
             (method url-fetch)
             (uri (string-append "https://github.com/babashka/babashka/releases/download/v"
                                 version "/babashka-" version "-linux-amd64-static.tar.gz" ))
             (sha256
              (base32 "1a7had0j6skc2gfnm5fpr365jr8ssl1sr4wg5j5srpadic23i4yg"))))
    (build-system copy-build-system)
    (supported-systems '("x86_64-linux" "i686-linux"))
    (arguments
     `(#:install-plan '(("bb" "bin/"))))
    (synopsis "Native, fast starting Clojure interpreter for scripting")
    (description "Babashka is a native Clojure interpreter for scripting with fast startup. Its main goal is to leverage Clojure in places where you would be using bash otherwise.")
    (home-page "https://babashka.org/")
    (license licenses:epl1.0)))
