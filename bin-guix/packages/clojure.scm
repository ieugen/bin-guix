;;
;; This file is licensed under the same license as guix - GPLv3
;; This file should be removed once guix is updated. See
;; https://issues.guix.gnu.org/67425
;; https://issues.guix.gnu.org/67426
;; https://issues.guix.gnu.org/67328
(define-module (bin-guix packages clojure)
  #:use-module (gnu packages clojure)
  #:use-module (gnu packages java)
  #:use-module (gnu packages maven)
  #:use-module (gnu packages readline)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system ant)
  #:use-module (guix build-system clojure)
  #:use-module (guix build-system copy))


(define-public clojure-tools
  (package
   (name "clojure-tools")
   (version "1.11.1.1435")
   (source
    (origin
     (method url-fetch)
     (uri (string-append "https://download.clojure.org/install/clojure-tools-"
                         version
                         ".tar.gz"))
     (sha256 (base32 "1h4v762agzhnrqs3mj7a84xlw51xv6jh8mvlc5cc83q4n9wwabs5"))
     ;; Remove AOT compiled JAR.  The other JAR only contains uncompiled
     ;; Clojure source code.
     (snippet
      `(delete-file ,(string-append "clojure-tools-" version ".jar")))))
   (build-system copy-build-system)
   (arguments
    `(#:install-plan
      '(("deps.edn" "lib/clojure/")
        ("example-deps.edn" "lib/clojure/")
        ("tools.edn" "lib/clojure/")
        ("exec.jar" "lib/clojure/libexec/")
        ("clojure" "bin/")
        ("clj" "bin/"))
      #:modules ((guix build copy-build-system)
                 (guix build utils)
                 (srfi srfi-1)
                 (ice-9 match))
      #:phases
      (modify-phases %standard-phases
                     (add-after 'unpack 'fix-paths
                                (lambda* (#:key outputs #:allow-other-keys)
                                  (substitute* "clojure"
                                               (("PREFIX") (string-append (assoc-ref outputs "out") "/lib/clojure")))
                                  (substitute* "clj"
                                               (("BINDIR") (string-append (assoc-ref outputs "out") "/bin"))
                                               (("rlwrap") (which "rlwrap")))))
                     (add-after 'fix-paths 'copy-tools-deps-alpha-jar
                                (lambda* (#:key inputs outputs #:allow-other-keys)
                                  (substitute* "clojure"
                                               (("\\$install_dir/libexec/clojure-tools-\\$version\\.jar")
                                                (string-join
                                                 (append-map (match-lambda
                                                               ((label . dir)
                                                                (find-files dir "\\.jar$")))
                                                             inputs)
                                                 ":"))))))))
   (inputs (list rlwrap
                 clojure
                 clojure-tools-deps
                 java-commons-logging-minimal))
   (home-page "https://clojure.org/releases/tools")
   (synopsis "CLI tools for the Clojure programming language")
   (description "The Clojure command line tools can be used to start a
Clojure repl, use Clojure and Java libraries, and start Clojure programs.")
   (license license:epl1.0)))


(define-public clojure-tools-deps
  (package
   (name "clojure-tools-deps")
   (version "0.18.1398")
   (home-page "https://github.com/clojure/tools.deps")
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url home-page)
                  (commit (string-append "v" version))))
            (file-name (git-file-name name version))
            (sha256
             (base32
              "00xks4kafbzif3ybr3lbpv41m4by2s7n3fghzmmss5pz3s3z9s28"))))
   (build-system clojure-build-system)
   (arguments
    `(#:source-dirs '("src/main/clojure" "src/main/resources")
      #:test-dirs '("src/test/clojure")
      #:doc-dirs '()
      ;; FIXME: Could not initialize class org.eclipse.aether.transport.http.SslSocketFactory
      #:tests? #f
      #:phases
      (modify-phases %standard-phases
                     ;; FIXME: Currently, the S3 transporter depends on ClojureScript,
                     ;; which is very difficult to package due to dependencies on Java
                     ;; libraries with non-standard build systems. Instead of actually
                     ;; packaging these libraries, we just remove the S3 transporter that
                     ;; depends on them.
                     (add-after 'unpack 'remove-s3-transporter
                                (lambda _
                                  (for-each delete-file
                                            (list
                                             (string-append
                                              "src/main/clojure/clojure/"
                                              "tools/deps/util/s3_aws_client.clj")
                                             (string-append
                                              "src/main/clojure/clojure/"
                                              "tools/deps/util/s3_transporter.clj")
                                             (string-append
                                              "src/test/clojure/clojure/"
                                              "tools/deps/util/test_s3_transporter.clj")))
                                  (substitute*
                                   "src/main/clojure/clojure/tools/deps/util/maven.clj"
                                   (("clojure.tools.deps.util.s3-transporter")
                                    "")))))))
   (propagated-inputs (list maven-resolver-api
                            maven-resolver-spi
                            maven-resolver-impl
                            maven-resolver-util
                            maven-resolver-connector-basic
                            maven-resolver-provider
                            maven-core
                            maven-resolver-transport-http
                            maven-resolver-transport-file
                            clojure-tools-gitlibs
                            clojure-tools-cli
                            clojure-data-xml))
   (synopsis "Clojure library supporting clojure-tools")
   (description "This package provides a functional API for transitive
dependency graph expansion and the creation of classpaths.")
   (license license:epl1.0)))
