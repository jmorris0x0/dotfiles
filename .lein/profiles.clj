{:user {:plugins      [[lein-exec "0.3.6"]
                       ; to execute Clojure scripts
                       [jonase/eastwood "0.2.3"]
                      ; Clojure linter
                      ; https://github.com/jonase/eastwood
                      ; To lint: $ lein eastwood
                      ; To restrict to a certain classpath:
                      ; $ lein eastwood "{:namespaces [:source-paths]}"
                      ; You may want to test first though:
                      ; $ lein test
                      [lein-bikeshed "0.3.0" :exclusions [org.clojure/tools.namespace]]
                      ; Code-smell utility
                      ; https://github.com/dakrone/lein-bikeshed
                      ; $ lein bikeshed
                      [lein-kibit "0.1.2"]
                      ; Idiomatic Code Analyzer
                      ; https://github.com/jonase/kibit
                      ; $ lein kibit path/to/src
                      ; To run automatically when code changes:
                      ; $ lein auto kibit
                      ; [cider/cider-nrepl "0.10.1"]
                      ; Emacs IDE
                      ; [refactor-nrepl "2.1.0-alpha1"]
                      ; nREPL middleware to support editor-agnostic refactoring
                      ; https://github.com/clojure-emacs/refactor-nrepl
                      [lein-ancient "0.6.10"]
                      ; Check your Projects for outdated Dependencies
                      ; https://github.com/xsc/lein-ancient
                      ; $ lein ancient
                      ; $ lein ancient :all
                      ; $ lein ancient check-profiles
                      ; $ lein ancient upgrade :interactive
                      ; $ lein ancient upgrade :exclude crypto
        ;;              [io.aviso/pretty "0.1.26"]
                       [lein-cljfmt "0.5.3"]        
        ]
                      ; Cleans up stacktraces
                      ; https://github.com/AvisoNovate/pretty/blob/master/docs/index.rst

        :dependencies [[org.clojure/clojure "1.7.0"]
                      ; Core library
                      [org.clojure/tools.nrepl "0.2.12"]
                      ; Network repl
                      [org.clojure/tools.namespace "0.2.11"]
                      ;
      ;;                [io.aviso/pretty "0.1.26"]
                      ; Cleans up stacktraces
                      [spyscope "0.1.5"]
                      ; Allows debugging: prefix any form with #spy/p or #spy/d
                      ; and when that code is eval'ed it will print.
                      ; i.e. (apply + #spy/p (range 11 20 2))
                      [org.clojure/tools.trace "0.7.9"]
                      ; Traces code.
                      ; (defn ^:dynamic fib[n] (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2)))))
                      ; (dotrace [fib] (fib 3))
      ;;                [clj-ns-browser "1.3.1"]
                      ; Namespace browser:
                      ; (use 'clj-ns-browser.sdoc)
                      ; (sdoc) ; This actually loads it.
                      [im.chit/vinyasa "0.4.7"]
                      ; Injects code when changing namespaces.
                      [alembic "0.3.2"]
     ;;                 [lein-light-nrepl "0.3.2"]
                      ;
                      ]

        :repl-options {
                       ; :init-ns user 
                       ; :source-paths [#=(eval (str (System/getProperty "user.home") "/.lein/src"))]
                       ; Load from file so that clojure.namespaces.repl/reset does not wipe namespaces loaded from this file.
                       ; This did not work.
                       :timeout 600000
                       ;; If nREPL takes too long to load it may timeout,
                       ;; Defaults to 30000 (30 seconds)
                       ; :init (boot.core/load-data-readers!)
   ;;                    :nrepl-middleware [lighttable.nrepl.handler/lighttable-ops]
                       }

        :injections
        ; Load these automatically into whatever namespace you are using:
        [(require 'spyscope.core
                  '[vinyasa.inject :as inject]
;                  'io.aviso.repl
                  'clojure.repl
                  'clojure.main
                  'clojure.tools.trace)
         (inject/in ;; the default injected namespace is `.`

               ;; note that `:refer, :all and :exclude can be used
               [vinyasa.inject :refer [inject [in inject-in]]]

               ;; inject clojure.repl into clojure.core 
               clojure.core 
               [clojure.repl]
               ;; imports all functions in vinyasa.pull into `.`
               ;;[vinyasa.maven pull]

               ;; inject into clojure.core
               ;;clojure.core
               ;;[vinyasa.reflection .> .? .* .% .%> .& .>ns .>var]

               ;; inject into clojure.core with prefix
               ;;clojure.core >
               ;;[clojure.pprint pprint]
               ;;[clojure.java.shell sh]
               ) 
        ]}}
;
; TODO: Create repl profile.

