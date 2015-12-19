(load "package")
(package-initialize)
(add-to-list 'package-archives
						              '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
						              '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq package-archive-enable-alist '(("melpa" deft magit)))
