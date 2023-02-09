(define-module (bin-guix packages datalevin)
   #:use-module (guix packages)
   #:use-module (guix download)
   #:use-module (guix build-system copy)
   #:use-module ((guix licenses) #:prefix licenses:)
   #:use-module (gnu packages compression))

(define-public datalevin
  (package
    (name "datalevin")
    (version "0.8.4")
    (source (origin
             (method url-fetch)
             (uri (string-append "https://github.com/juji-io/datalevin/releases/download/"
                                 version "/dtlv-" version "-ubuntu-latest-amd64.zip"))
             (sha256
              (base32 "0jax7gyd8dgb9yjm0y4hbv3ydd5fbpxd8ry8cda8drhvkkiqj127"))))
    (build-system copy-build-system)
    (arguments
     `(#:install-plan '(("dtlv" "bin/"))
       ;; datalevin fails w/ RUNPATH error because of shared libraries
       ;; remove this once we have static binary
       #:validate-runpath? #f))
    (native-inputs
     `(("unzip" ,unzip)))
    (inputs
     `(("zlib" ,zlib)))
    (synopsis "A simple, fast and versatile Datalog database")
    (description "The rationale is to have a simple, fast and open source Datalog query engine running on durable storage. It is our observation that many developers prefer the flavor of Datalog popularized by Datomic® over any flavor of SQL, once they get to use it. Perhaps it is because Datalog is more declarative and composable than SQL, e.g. the automatic implicit joins seem to be its killer feature.")
    (home-page "https://github.com/juji-io/datalevin")
    (license licenses:epl1.0)))
