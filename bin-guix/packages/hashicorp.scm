(define-module (bin-guix packages hashicorp)
   #:use-module (guix packages)
   #:use-module (guix download)
   #:use-module (guix build-system copy)
   #:use-module (guix licenses)
   #:use-module (gnu packages compression))

(define-public vault
  (package
    (name "vault")
    (version "1.12.2")
    (source (origin
             (method url-fetch)
             (uri (string-append "https://releases.hashicorp.com/vault/"
                   version "/vault_" version "_linux_amd64.zip"))
             (sha256
              (base32 "0rxsxnm94pfq5mp1m54air2r0lpyx7ang8smliz7m9vpwcyi8v0i"))))
    (build-system copy-build-system)
    (arguments
     `(#:install-plan '(("vault" "bin/"))))
    (inputs
     `(("unzip" ,unzip)))
    (synopsis "A tool for secrets management, encryption as a service, and privileged access management")
    (description "Vault is a tool for securely accessing secrets. A secret is anything that you want to tightly control access to, such as API keys, passwords, certificates, and more. Vault provides a unified interface to any secret, while providing tight access control and recording a detailed audit log.")
    (home-page "https://www.vaultproject.io/")
    (license mpl2.0)))
