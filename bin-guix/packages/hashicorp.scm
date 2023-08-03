(define-module (bin-guix packages hashicorp)
   #:use-module (guix packages)
   #:use-module (guix download)
   #:use-module (guix build-system copy)
   #:use-module ((guix licenses) #:prefix licenses:)
   #:use-module (gnu packages compression))

(define-public consul
  (package
    (name "consul")
    (version "1.15.0")
    ;;TODO check signature file https://releases.hashicorp.com/consul/1.15.0/consul_1.15.0_SHA256SUMS.sig
    (source (origin
             (method url-fetch)
             (uri (string-append "https://releases.hashicorp.com/consul/"
                                 version "/consul_" version "_linux_amd64.zip"))
             (sha256
              (base32 "094cf5d6bdzaahsf2yknbamlgd851c9s6bm92ngx221w5kzmi8v2"))))
    (build-system copy-build-system)
    (supported-systems '("x86_64-linux" "i686-linux"))
    (arguments
     `(#:install-plan '(("consul" "bin/"))))
    (native-inputs
     `(("unzip" ,unzip)))
    (synopsis "Consul is a distributed, highly available, and data center aware solution to connect and configure applications across dynamic, distributed infrastructure.")
    (description "Consul is a service networking solution that enables teams to manage secure network connectivity between services and across multi-cloud environments and runtimes. Consul offers service discovery, identity-based authorization, L7 traffic management, and service-to-service encryption.")
    (home-page "https://www.consul.io/")
    (license licenses:mpl2.0)))

(define-public packr
  (package
    (name "packer")
    (version "1.8.7")
    ;;TODO check signature file https://releases.hashicorp.com/packer/1.8.5/packer_1.8.5_SHA256SUMS.sig
    (source (origin
             (method url-fetch)
             (uri (string-append "https://releases.hashicorp.com/packer/"
                                 version "/packer_" version "_linux_amd64.zip"))
             (sha256
              (base32 "0vwlsm1s57pxxcfy2ykc0s4kwjmz1h4fkw1sgrlikdl2z0dz5lih"))))
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

(define-public terraform
  (package
    (name "terraform")
    (version "1.4.6")
    ;;TODO check signature file https://releases.hashicorp.com/terraform/1.3.7/terraform_1.3.7_SHA256SUMS.sig
    (source (origin
             (method url-fetch)
             (uri (string-append "https://releases.hashicorp.com/terraform/"
                                 version "/terraform_" version "_linux_amd64.zip"))
             (sha256
              (base32 "0fymlg2j4v8qkfdz3gd2slmz7f9sdfa17rd4icgrpqs5i4ddnyg0"))))
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

(define-public vault
  (package
    (name "vault")
    (version "1.14.1")
    (source (origin
             (method url-fetch)
             (uri (string-append "https://releases.hashicorp.com/vault/"
                   version "/vault_" version "_linux_amd64.zip"))
             (sha256
              (base32 "18vyymcz62ilfxd15sf8jjfrdahqq17w81nj4djpzq1xzhnl6cb0"))))
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
