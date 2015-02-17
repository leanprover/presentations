;; emacs org-mode batch configuration
(require 'cask "~/.cask/cask.el")
(cask-initialize "./")
(setq working-dir (f-dirname (f-this-file)))
(add-to-list 'load-path working-dir)
(setq make-backup-files nil)

;;; ORG mode
(require 's)
(require 'f)
(require 'org)
(require 'ox-reveal)
(require 'dash)
(require 'dash-functional)
(add-to-list 'load-path (f-join working-dir ".." "elisp"))
(setq org-reveal-root "//leanprover.github.io/presentations/reveal.js-3.0.0/")

(setq org-reveal-title-slide-template
"<h1 id='title-name'>%t</h1>
<h2 id='author-list'>%a</h2>
<h2 id='date'>%d</h2>")

(setq org-reveal-head-preamble "
<script type=\"text/javascript\" src=\"///cdnjs.cloudflare.com/ajax/libs/snap.svg/0.3.0/snap.svg-min.js\"></script>
<script type=\"text/javascript\">MathJax.Hub.Config({\"HTML-CSS\": {scale: 80 }})</script>
</script><script src=\"///cdn.jsdelivr.net/polymer.platform/0.4.2/platform.js\"></script>
<link rel=\"import\" href=\"./juicy-ace-editor.html\">
<link rel=\"stylesheet\" href=\"./css/code.css\">
")

(setq org-reveal-postamble
"<script>(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','//www.google-analytics.com/analytics.js','ga');ga('create', 'UA-59814431-1', 'auto');ga('send', 'pageview');</script>")
