;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;

;; Guard against Emacs 24

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(when (< emacs-major-version 24)
  (error "Starter Kit needs at least GNU Emacs 24.X, but this is Emacs %s.
          Please install GNU Emacs 24.X to use Starter Kit"
         emacs-version))

;; load the starter kit from the `after-init-hook' so all packages are loaded
(add-hook 'after-init-hook
          `(lambda ()
             ;; See http://orgmode.org/manual/Conflicts.html for new bindings
             ;; and discussion why this has to be set before loading org
             ;; http://comments.gmane.org/gmane.emacs.orgmode/53820
             (setq org-replace-disputed-keys t)
             ;; remember this directory
             (setq starter-kit-dir
                   ,(file-name-directory (or load-file-name (buffer-file-name))))
             ;; load up the starter kit
             (require 'org)
             (org-babel-load-file (expand-file-name "starter-kit.org" starter-kit-dir))))

;;; init.el ends here
(put 'scroll-left 'disabled nil)
