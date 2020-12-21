;; -*- coding: utf-8; lexical-binding: t; -*-
;; part of Xah Lee's emacs init file.
;; 2011-05-28
;; Xah Lee
;; ∑ http://xahlee.org/

(defun xah-make-blogger-entry ()
  "Make a blogger entry.

Copy the current buffer or text selection.
Create a new buffer. Make it html-mode.
Paste it in.
Remove the header and footer.
Fix all relative links to http://xahlee.org/ links.
add a “Perm URL with updates: ‹link›” sentence at top.

This new content is ready to be posted to blogger.
Version 2017-02-02"
  (interactive)
  (let* (
         p1 p2
         mainText
         (thisFilePath (or (buffer-file-name) default-directory))
         (currentDir (file-name-directory thisFilePath))
         (newBuff (generate-new-buffer "*blogger temp*"))
         cssStr permLink)

    (if (use-region-p)
        (setq p1 (region-beginning) p2 (region-end))
      (setq p1 (point-min) p2 (point-max)))

    (setq mainText (buffer-substring-no-properties p1 p2))

    (switch-to-buffer newBuff)
    (html-mode)

    (insert mainText)

    ;; get css declaration, if any
    (let (p3 p4 )
      (goto-char 1)
      (if (search-forward "<style type=\"text/css\">" nil t)
          (progn
            (search-backward "<style" )
            (setq p3 (point))
            (search-forward "</style>")
            (setq p4 (point))
            (setq cssStr (buffer-substring-no-properties p3 p4)))
        (progn
          (setq cssStr ""))))

    ;; remove beginning to <body>
    (goto-char 1)
    (when (search-forward "<body>" nil t)
      (delete-region 1 (point)))

    ;; remove footer to end
    (goto-char (point-max))
    (when (search-backward "<footer>" nil t)
      (delete-region (point) (point-max)))

    ;; remove disqus tag to end
    (goto-char (point-max))
    (when (search-backward "<div id=\"disqus_thread\">" nil t)
      (delete-region (point) (point-max)))

    ;; change amazong ad id
    (xah-replace-pairs-region (point-min) (point-max) [["?tag=xahh-20" "?tag=xahblg-20"]] )

    ;; remove header, author, etc.
    (xah-replace-regexp-pairs-region (point-min) (point-max)
                                     [
                                      ["<nav id=\"t5\">[ \n[:graph:]]+</nav>" ""]
                                      ["<article>" ""]
                                      ["</article>" ""]
                                      ["<nav class=\"n1\"><a href=\"\\([^\"]+?\\)\">\\([^\"]+?\\)</a></nav>" ""]
                                      ["<h1>[^<]+?</h1>" ""]
                                      ["<div class=\"byline\"><address class=\"author\">[-<>/ ,…time0-9]+?</time></div>" ""]
                                      ["<!-- http://xahlee.blogspot.com/\\([^ ]+?\\) -->" ""]
                                      ["<footer>\\([^<]+?\\)</footer>" ""]
                                      ]
                                     )

    ;; change relative links to full http://… URL
    (goto-char 1)
    (while (search-forward "href=\"" nil t)
      (when (not (looking-at "http"))
        (let (bds myLink fPath)
          (setq bds (bounds-of-thing-at-point 'filename))
          (setq myLink (buffer-substring-no-properties (car bds) (cdr bds)))
          (setq fPath (expand-file-name (concat currentDir myLink)))
          (delete-region (car bds) (cdr bds))
          (insert (xahsite-filepath-to-url fPath)))))

    ;; change inline image links from relative to http://xahlee.org/ URL
    (goto-char 1)
    (while (search-forward "src=\"" nil t)
      (when (not (looking-at "http"))
        (let (bds myLink fPath)
          (setq bds (bounds-of-thing-at-point 'filename))
          (setq myLink (buffer-substring-no-properties (car bds) (cdr bds)))
          (setq fPath (expand-file-name (concat currentDir myLink)))
          (delete-region (car bds) (cdr bds))
          (insert (xahsite-filepath-to-url fPath)))))

    ;; (compute-url-from-relative-link thisFilePath)

    ;; insert perm link at top
    (when (and
           (not (string-match "blog\.html$" thisFilePath))
           (not (string-match "Vocabulary_dir" thisFilePath)))
      (goto-char 1)
      (setq permLink (xahsite-filepath-to-url thisFilePath))
      (insert "<p>Perm URL with updates: " "<a href=\"" permLink "\">" permLink "</a>" "</p>\n\n"))

    ;; insert css string
    (goto-char 1)
    (insert cssStr "\n\n")

    (xah-replace-regexp-pairs-region (point-min) (point-max) [["\n\n+" "\n\n"]])

    (goto-char 1)

    (kill-new (buffer-string))))
