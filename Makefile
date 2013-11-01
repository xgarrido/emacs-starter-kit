# Name of your emacs binary
EMACS=emacs

BATCH=$(EMACS) --batch --no-init-file					\
  --eval '(require (quote org))'					\
  --eval "(org-babel-do-load-languages 'org-babel-load-languages	\
        '((sh . t)))"							\
  --eval "(setq org-confirm-babel-evaluate nil)"			\
  --eval '(setq starter-kit-dir default-directory)'

FILES = starter-kit.org			\
	starter-kit-elpa.org		\
	starter-kit-window.org		\
	starter-kit-defuns.org		\
	starter-kit-bindings.org

FILESO = $(FILES:.org=.el)

all: el
	$(BATCH) --eval '(mapc (lambda (x) (byte-compile-file (symbol-name x))) (quote ($(FILESO))))'

el: $(FILES)
	$(BATCH) --eval '(mapc (lambda (x) (org-babel-load-file (symbol-name x))) (quote ($(FILES))))'

%.el: %.org
	$(BATCH) --eval '(org-babel-load-file "$<")'

doc: html

html:
	@mkdir -p doc/stylesheets
	@$(BATCH) --eval '(org-babel-tangle-file "starter-kit-publish.org")'
	@$(BATCH) --eval '(org-babel-load-file   "starter-kit-publish.org")'
	@rm starter-kit-publish.el
	@find doc -name *.*~ | xargs rm -f
	@(cd doc && tar czvf /tmp/org-starter-kit-publish.tar.gz .)
	@git checkout gh-pages
	@tar xzvf /tmp/org-starter-kit-publish.tar.gz
	@if [ -n "`git status --porcelain`" ]; then git commit -am "update doc" && git push; fi
	@git checkout master
	echo "Documentation published to doc/"

clean:
	rm -f *.elc *.aux *.tex *.pdf starter-kit*.el starter-kit*.html doc/*html *~ .starter-kit*.part.org
	rm -rf doc
