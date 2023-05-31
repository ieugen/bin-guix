(define-module (bin-guix packages regclient)
   #:use-module (guix packages)
   #:use-module (guix download)
   #:use-module (guix build utils)
   #:use-module (guix build-system copy)
   #:use-module ((guix licenses) #:prefix licenses:))

(define-public regbot
  (package
    (name "regbot")
    (version "0.4.8")
    (source (origin
             (method url-fetch)
             (uri (string-append "https://github.com/regclient/regclient/releases/download/v"
                                 version "/regbot-linux-amd64" ))
             (file-name "regbot")
             (sha256
              (base32 "0p81d9jnhmiac61nxpnl75m6gljrwc68nlxh794r5czww9a2ax0j"))))
    (build-system copy-build-system)
    (supported-systems '("x86_64-linux" "i686-linux"))
    (arguments
     `(#:install-plan '(("regbot" "bin/"))
       #:phases (modify-phases %standard-phases
                  (add-after 'unpack 'make-file-exec
                    (lambda _
                      (for-each
                       (lambda (file)
                         (let ((stat (lstat file)))
                           ;;(display (string-append "File-> " file "\n"))
                           (chmod file #o755)))
                       (find-files "." #:directories? #f)))))))
    (synopsis "regbot is a scripting tool on top of the regclient API")
    (description "Client interface for the registry API.")
    (home-page "https://github.com/regclient/regclient")
    (license licenses:asl2.0)))


(define-public regctl
  (package
    (name "regctl")
    (version "0.4.8")
    (source (origin
             (method url-fetch)
             (uri (string-append "https://github.com/regclient/regclient/releases/download/v"
                                 version "/regctl-linux-amd64" ))
             (file-name "regctl")
             (sha256
              (base32 "1da589yks4n6pcc0sp948whqfmxwapx7n72pfdd50917h2h1s0w9"))))
    (build-system copy-build-system)
    (supported-systems '("x86_64-linux" "i686-linux"))
    (arguments
     `(#:install-plan '(("regctl" "bin/"))
       #:phases (modify-phases %standard-phases
                  (add-after 'unpack 'make-file-exec
                    (lambda _
                      (for-each
                       (lambda (file)
                         (let ((stat (lstat file)))
                           ;;(display (string-append "File-> " file "\n"))
                           (chmod file #o755)))
                       (find-files "." #:directories? #f)))))))
    (synopsis "regctl is a CLI interface to the regclient library.")
    (description "Client interface for the registry API.")
    (home-page "https://github.com/regclient/regclient")
    (license licenses:asl2.0)))

(define-public regsync
  (package
    (name "regsync")
    (version "0.4.8")
    (source (origin
             (method url-fetch)
             (uri (string-append "https://github.com/regclient/regclient/releases/download/v"
                                 version "/regsync-linux-amd64" ))
             (file-name "regsync")
             (sha256
              (base32 "1sgwzphy4qw78xi9yz5zwgwmnz71dxcdivyp41xrw0g3k6da831c"))))
    (build-system copy-build-system)
    (supported-systems '("x86_64-linux" "i686-linux"))
    (arguments
     `(#:install-plan '(("regsync" "bin/"))
       #:phases (modify-phases %standard-phases
                  (add-after 'unpack 'make-file-exec
                    (lambda _
                      (for-each
                       (lambda (file)
                         (let ((stat (lstat file)))
                           ;;(display (string-append "File-> " file "\n"))
                           (chmod file #o755)))
                       (find-files "." #:directories? #f)))))))
    (synopsis "regsync is an image mirroring tool. It will copy images between two locations")
    (description "Client interface for the registry API.")
    (home-page "https://github.com/regclient/regclient")
    (license licenses:asl2.0)))
