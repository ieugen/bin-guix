;; This file is licensed under the same license as guix:
;; GNU General Public License as published by
;; the Free Software Foundation; either version 3 of the License, or (at
;; your option) any later version.
(define-module (bin-guix packages lokke)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages pkg-config)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu))


(define-public lokke
  (let ((commit "10dfebe0d7e601760802114abb274a3dc889305a")
        (revision "1"))
    (package
     (name "lokke-next")
     (version (git-version "0.0.0" revision commit))
     (home-page "https://github.com/lokke-org/lokke")
     (source (origin
              (method git-fetch)
              (uri (git-reference (url home-page) (commit commit)))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0vd90ir7ypqhzh5swqmixvnm9napk87hp53ipxla6jiqdrlzbd5q"))))
     (build-system gnu-build-system)
     (arguments
      '(#:phases
        (modify-phases %standard-phases
                       (add-before 'bootstrap 'pre-bootstrap
                                   (lambda _
                                     (for-each patch-shebang
                                               '("setup" "gen-makefile"
                                                 "dev/gen-module-paths"
                                                 "dev/refresh"))
                                     (invoke "./setup")))
                       (add-before 'build 'set-home
                                   (lambda _
                                     (setenv "HOME" (getcwd)))))))
     (native-inputs
      (list autoconf
            automake
            libtool
            gnu-gettext
            pkg-config

            ;; Use Guile >= 3.0.8 to work around
            ;; <https://bugs.gnu.org/49305>.
            guile-3.0-latest))
     (inputs
      (list pcre2))
     (synopsis "Clojure implementation in Guile")
     (description
      "Lokke intends to provide a full dialect of Clojure for Guile.  It also
consists of a set of Guile modules providing some of Clojure's functionality
in two different guises.")
     ;; Dual license: LGPLv2.1+ or EPLv1.0+ at the user's option.
     (license (list license:lgpl2.1+ license:epl1.0)))))
