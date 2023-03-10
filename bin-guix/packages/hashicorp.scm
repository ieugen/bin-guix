(define-module (bin-guix packages hashicorp)
   #:use-module (guix packages)
   #:use-module (guix download)
   #:use-module (guix build-system copy)
   #:use-module ((guix licenses) #:prefix licenses:)
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
    (supported-systems '("x86_64-linux" "i686-linux"))
    (arguments
     `(#:install-plan '(("vault" "bin/"))))
    (inputs
     `(("unzip" ,unzip)))
    (synopsis "A tool for secrets management, encryption as a service, and privileged access management")
    (description "Vault is a tool for securely accessing secrets. A secret is anything that you want to tightly control access to, such as API keys, passwords, certificates, and more. Vault provides a unified interface to any secret, while providing tight access control and recording a detailed audit log.")
    (home-page "https://www.vaultproject.io/")
    (license licenses:mpl2.0)))

(define-public terraform
  (package
    (name "terraform")
    (version "1.3.7")
    ;;TODO check signature file https://releases.hashicorp.com/terraform/1.3.7/terraform_1.3.7_SHA256SUMS.sig
    (source (origin
             (method url-fetch)
             (uri (string-append "https://releases.hashicorp.com/terraform/"
                                 version "/terraform_" version "_linux_amd64.zip"))
             (sha256
              (base32 "07h2wdycd689gjiak13jw4idn8xb2d9hhmpy2fbsipqmxr6iikxq"))))
    (build-system copy-build-system)
    (supported-systems '("x86_64-linux" "i686-linux"))
    (arguments
     `(#:install-plan '(("terraform" "bin/"))))
    (native-inputs
     `(("unzip" ,unzip)))
    (synopsis "Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently.")
    (description "Terraform enables you to safely and predictably create, change, and improve infrastructure. It is an open source tool that codifies APIs into declarative configuration files that can be shared amongst team members, treated as code, edited, reviewed, and versioned.")
    (home-page "https://www.terraform.io/")
    (license licenses:mpl2.0)))

(define-public packer
  (package
    (name "packer")
    (version "1.8.5")
    ;;TODO check signature file https://releases.hashicorp.com/packer/1.8.5/packer_1.8.5_SHA256SUMS.sig
    (source (origin
             (method url-fetch)
             (uri (string-append "https://releases.hashicorp.com/packer/"
                                 version "/packer_" version "_linux_amd64.zip"))
             (sha256
              (base32 "1wpfxnwxvlqj4140dgz7ijqrlx62n8mnsbl41h0rdincwljaf5qz"))))
    (build-system copy-build-system)
    (supported-systems '("x86_64-linux" "i686-linux"))
    (arguments
     `(#:install-plan '(("packer" "bin/"))))
    (native-inputs
     `(("unzip" ,unzip)))
    (synopsis "Packer is a tool for building identical machine images for multiple platforms from a single source configuration.")
    (description "Packer is lightweight, runs on every major operating system, and is highly performant, creating machine images for multiple platforms in parallel.")
    (home-page "https://www.packer.io/")
    (license licenses:mpl2.0)))
