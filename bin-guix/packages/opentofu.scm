(define-module (bin-guix packages opentofu)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix licenses:)
  #:use-module (gnu packages compression))

(define-public opentofu
  (package
    (name "opentofu")
    (version "1.7.2")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://github.com/opentofu/opentofu/releases/download/v"
                                 version "/tofu_" version "_linux_amd64.zip"))
       (sha256 (base32 "0d2l7fc7y8pxa0189l0gj51yk329fvcjkrgnpm1h2b49g97kd26s"))))
    (supported-systems '("x86_64-linux"))
    (build-system copy-build-system)
    (arguments
    `(#:install-plan '(("tofu" "bin/"))))
    (native-inputs
     `(("unzip" ,unzip)))
    (home-page "https://opentofu.org/")
    (synopsis "OpenTofu lets you declaratively manage your cloud infrastructure")
    (description "OpenTofu lets you declaratively manage your cloud infrastructure.")
    (license licenses:mpl2.0)))
