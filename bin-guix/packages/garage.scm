(define-module (bin-guix packages garage)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix licenses:))

(define-public garage
  (package
   (name "garage")
   (version "2.2.0")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://garagehq.deuxfleurs.fr/_releases/v" version
				"/x86_64-unknown-linux-musl/garage"))
            (sha256
             (base32 "1aqsjg8yf9s8pm0bbq2sy0gbnwrc4b7w3k38zs33wig8jswinxpc"))))
   (build-system copy-build-system)
   (supported-systems '("x86_64-linux" "i686-linux"))
   (arguments
    `(#:install-plan '(("garage" "bin/"))
      #:phases (modify-phases %standard-phases
		(add-after 'unpack 'make-file-exec
                           (lambda _
                             (for-each
                              (lambda (file)
                                (let ((stat (lstat file)))
                                  ;;(display (string-append "File-> " file "\n"))
                                  (chmod file #o755)))
                              (find-files "." #:directories? #f)))))))
   (synopsis "An open-source distributed object storage service tailored for self-hosting")
   (description "An open-source distributed object storage service tailored for self-hosting")
   (home-page "https://garagehq.deuxfleurs.fr")
   (license licenses:agpl3+)))
