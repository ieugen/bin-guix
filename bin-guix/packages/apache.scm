(define-module (bin-guix packages apache)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix licenses:))


(define-public jena
  (package
   (name "jena")
   (version "4.9.0")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://archive.apache.org/dist/jena/binaries/apache-jena-" version ".tar.gz"))
            (sha256
             (base32 "1s1976p8rfbmix8yk2k1dmgv7xfiglxjj63gwj63qqmh89s08jwi"))))
   (build-system copy-build-system)
   (supported-systems '("x86_64-linux" "i686-linux"))
   (arguments
    `(#:install-plan '(("." "jena")
                       ("bin" "bin")
                       ("log4j2.properties" "log4j2.properties")
                       ("lib" "lib"))))
   (synopsis "A free and open source Java framework for building Semantic Web and Linked Data applications.")
   (description "A free and open source Java framework for building Semantic Web and Linked Data applications.")
   (home-page "https://jena.apache.org/")
   (license licenses:asl2.0)))



(define-public jena-fuseki
  (package
   (name "jena-fuseki")
   (version "4.9.0")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://archive.apache.org/dist/jena/binaries/apache-jena-fuseki-" version ".tar.gz"))
            (sha256
             (base32 "0lh2pf1fbs3b2k796ri4dp2wnz36ksgddhy0v5sw8ygyav950vmp"))))
   (build-system copy-build-system)
   (supported-systems '("x86_64-linux" "i686-linux"))
   (arguments
    `(#:install-plan '(("." "fuseki")
                       ("bin" "bin")
                       ("webapp" "webapp")
                       ("fuseki" "bin/")
                       ("fuseki-backup" "bin/")
                       ("fuseki-server" "fuseki-server")
                       ("fuseki-server.jar" "fuseki-server.jar")
                       ("log4j2.properties" "log4j2.properties"))))
   (synopsis "Expose your triples as a SPARQL end-point accessible over HTTP. Fuseki provides REST-style interaction with your RDF data.")
   (description "Expose your triples as a SPARQL end-point accessible over HTTP. Fuseki provides REST-style interaction with your RDF data.")
   (home-page "https://jena.apache.org/")
   (license licenses:asl2.0)))
