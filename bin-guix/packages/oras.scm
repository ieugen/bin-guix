(define-module (bin-guix packages oras)
   #:use-module (guix packages)
   #:use-module (guix download)
   #:use-module (guix build-system copy)
   #:use-module ((guix licenses) #:prefix licenses:))

(define-public oras
  (package
    (name "oras")
    (version "1.0.0")
    (source (origin
             (method url-fetch)
             (uri (string-append "https://github.com/oras-project/oras/releases/download/v"
                                 version "/oras_" version "_linux_amd64.tar.gz"))
             (sha256
              (base32 "0cr1xlvqky28fl3ik8gqc9ad21piiq74q2f5vyqmw3as3vmcjcw5"))))
    (build-system copy-build-system)
    (supported-systems '("x86_64-linux" "i686-linux"))
    (arguments
     `(#:install-plan '(("oras" "bin/")
                        ;;("LICENSE" "share/doc/LICENSE")
                        )))
    (synopsis "OCI registry client - managing content like artifacts, images, packages")
    (description "ORAS works similarly to tools you may already be familiar with, such as docker. It allows you to push (upload) and pull (download) things to and from an OCI Registry, and also handles login (authentication) and token flow (authorization). What ORAS does differently is shift the focus from container images to other types of artifacts.")
    (home-page "https://oras.land/cli")
    (license licenses:asl2.0)))
