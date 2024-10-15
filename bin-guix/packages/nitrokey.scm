(define-module (bin-guix packages nitrokey)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build utils)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix licenses:)
  #:use-module (gnu packages compression))

(define-public nitrokey-app2
  (package
   (name "nitrokey-app2")
   (version "2.3.2")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://github.com/Nitrokey/nitrokey-app2/releases/download/v"
                                version "/nitrokey-app-v" version "-x64-linux-binary"))
            (sha256
             (base32 "1rsbr1qmd9dfalp6yayq15n53qg3s3mfi8l956xn6mzdk288xrni"))))
   (build-system copy-build-system)
   (supported-systems '("x86_64-linux" "i686-linux"))
   (arguments
    `(#:install-plan '(("nitrokey-app-v2.3.2-x64-linux-binary" "bin/nitrokey-app2"))
      #:validate-runpath? #f
      #:phases (modify-phases %standard-phases
                              (add-after 'unpack 'make-file-exec
                                         (lambda _
                                           (for-each
                                            (lambda (file)
                                              (let ((stat (lstat file)))
                                                ;;(display (string-append "File-> " file "\n"))
                                                (chmod file #o755)))
                                            (find-files "." #:directories? #f))))) ))
   (synopsis "Manage Nitrokey 3, Nitrokey Pro and Nitrokey Storage devices.")
   (description "This application allows to manage Nitrokey 3 devicese
To manage Nitrokey Pro and Nitrokey Storage devices, use the older Nitrokey App.")
   (home-page "https://github.com/Nitrokey/nitrokey-app2")
   (license licenses:asl2.0)))
