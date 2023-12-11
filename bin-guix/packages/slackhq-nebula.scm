(define-module (bin-guix packages slackhq-nebula)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix licenses:)
  #:use-module (gnu packages compression))


(define-public nebula
  (package
   (name "nebula")
   (version "1.8.0")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://github.com/slackhq/nebula/releases/download/v"
                                version "/nebula-linux-amd64.tar.gz"))
            (sha256
             (base32 "1f2d0y69nlmyy4i33jzg7fxdqbxz50lbwh46fhcdlwb09pg39s6g"))))
   (build-system copy-build-system)
   (arguments
    `(#:install-plan '(("nebula" "bin/")
                       ("nebula-cert" "bin/"))))
   (synopsis "performant, scalable network overlay")
   (description "Nebula is a scalable overlay networking tool with a focus on performance,
 simplicity and security. It is intended to be more robust than current virtual
 networking solutions by providing peer-to-peer connectivity and NAT traversal
 mechanisms. Nebula uses state-of-the-art cryptography based on the \"Noise\"  protocol.")
   (home-page "https://github.com/slackhq/nebula")
   (license licenses:expat)))
