(define-module (bin-guix packages bytecodealliance)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix licenses:))


(define-public javy
  (package
   (name "javy")
   (version "1.4.0")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://github.com/bytecodealliance/javy/releases/download/v"
                                version "/javy-x86_64-linux-v" version ".gz"))
            (sha256
             (base32 "1pydsqf9nq8q965vv6mxcx6kjlb3hksphnvl2fi05djxq17k74im"))))
   (build-system copy-build-system)
   (supported-systems '("x86_64-linux"))
   (arguments
    ;; I have no idea how to unpack the archive as javy (FileRoller does this)
    `(#:install-plan '(("javy-x86_64-linux-v1.4.0" "bin/javy"))
      ;; Requires libstdc++ and ld and libgcc - we are ignoring those
      ;; Maybe we can fix it by depending on gcc:lib
      #:validate-runpath? #f

      #:phases (modify-phases %standard-phases
                              (add-after 'unpack 'make-file-exec
                                         (lambda _
                                           (for-each
                                            (lambda (file)
                                              (let ((stat (lstat file)))
                                                ;;(display (string-append "File-> " file "\n"))
                                                (chmod file #o755)))
                                            (find-files "." #:directories? #f)))))

      ))
   (synopsis "JS to WebAssembly toolchain")
   (description "Run your JavaScript on WebAssembly. Javy takes your JavaScript code, and executes it in a WebAssembly embedded JavaScript runtime.")
   (home-page "https://github.com/bytecodealliance/javy")
   (license licenses:asl2.0)))


(define-public wasmtime
  (package
   (name "wasmtime")
   (version "18.0.1")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://github.com/bytecodealliance/wasmtime/releases/download/v"
                                version "/wasmtime-v" version "-x86_64-linux.tar.xz"))
            (sha256
             (base32 "1bc0lzni6q17a0daxdm2cc43s40s0vw153wgnqk197mbgjac0lcr"))))
   (build-system copy-build-system)
   (supported-systems '("x86_64-linux"))
   (arguments
    ;; I have no idea how to unpack the archive as javy (FileRoller does this)
    `(#:install-plan '(("wasmtime" "bin/")
                       ("wasmtime-min" "bin/")
                       ("LICENSE" "share/doc/")
                       ("README.md" "share/doc/"))
      ;; Requires libstdc++ and ld and libgcc - we are ignoring those
      ;; Maybe we can fix it by depending on gcc:lib
      #:validate-runpath? #f))
   (synopsis "A fast and secure runtime for WebAssembly")
   (description "A standalone runtime for WebAssembly")
   (home-page "https://github.com/bytecodealliance/wasmtime")
   (license licenses:asl2.0)))
