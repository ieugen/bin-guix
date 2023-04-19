(define-module (bin-guix packages protojure)
   #:use-module (guix packages)
   #:use-module (guix download)
   #:use-module (guix build-system copy)
   #:use-module ((guix licenses) #:prefix licenses:))

(define-public protoc-gen-clojure
  (package
    (name "protoc-gen-clojure")
    (version "v2.1.2")
    (source (origin
             (method url-fetch)
             (uri (string-append "https://github.com/protojure/protoc-plugin/releases/download/"
                                 version "/protoc-gen-clojure"))
             (sha256
              (base32 "0vzz78fd4awbsc5iykych9yqd86yab18f8fbbgydrw556lmhv8hh"))))
    (build-system copy-build-system)
    (supported-systems '("x86_64-linux" "i686-linux"))
    (arguments
     `(#:install-plan '(("protoc-gen-clojure" "bin/"))))
    (synopsis "Protojure protoc compiler plugin")
    (description "Protoc compiler plugin to generate native Clojure support for Google Protocol Buffers and GRPC.")
    (home-page "https://github.com/protojure/protoc-plugin")
    (license licenses:asl2.0)))
