;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;系统设置
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 没有 toolbar
(tool-bar-mode nil)
;; 没有 menubar
;(menu-bar-mode nil)

;; 行号 emacs23 支持
(global-linum-mode t)

;; change yes or no to y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; 设置缩进
(setq c-basic-offset 4)

;; 设置字体
(set-face-attribute 'default nil :font "文泉驿等宽微米黑-9")

;;关闭起动时的那个“开机画面”。
(setq inhibit-startup-message t)

;;让 Emacs 可以直接打开和显示图片。
(auto-image-file-mode t)

;;把这些缺省禁用的功能打开。
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'LaTeX-hide-environment 'disabled nil)

;;Ctrl+Space无效
;(global-set-key (kbd "C-SPC")'nil)

;; 设置窗口的初始大小
(setq initial-frame-alist '((top . 0) (left . 0) (width . 75) (height . 38)))

;;关闭烦人的出错时的提示声。
(setq visible-bell t)

;;显示列号
(setq column-number-mode t)

;;用一个很大的 kill ring. 这样防止不小心删掉重要的东西
(setq kill-ring-max 200)

;;把 fill-column 设为 60. 这样的文字更好读。
(setq default-fill-column 60)

;;不用 TAB 字符来indent, 这会引起很多奇怪的错误。编辑 Makefile
;;的时候也不用担心，因为 makefile-mode 会把 TAB 键设置成真正的
;;TAB 字符，并且加亮显示的。
;(setq-default indent-tabs-mode nil)
;(setq default-tab-width 8)
;(setq tab-stop-list ())
;(loop for x downfrom 40 to 1 do
;      (setq tab-stop-list (cons (* x 4) tab-stop-list)))

;;设置 sentence-end 可以识别中文标点。不用在 fill 时在句号后插入两个空格。
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)

;;括号匹配时显示另外一边的括号，而不是烦人的跳到另一个括号。
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。
(mouse-avoidance-mode 'animate)

;; 光标不闪，不恍花眼睛。
(blink-cursor-mode -1)
(transient-mark-mode 1)

;;在标题栏显示buffer的名字，而不是 emacs@email.***这样没用的提示。
(setq frame-title-format "emacs@%b")

;;语法加亮
(global-font-lock-mode t)

;;所有的备份文件都放置在~/backups目录下
(setq backup-directory-alist (quote (("." . "~/.emacs.d/backups"))))
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 5)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)
;;emacs中，改变文件时，默认都会产生备份文件（以~结尾的文件）。可以完全去掉
;;（并不可取），也可以制定备份的方式。这里采用的是，把所有的文件备份都放在一个
;;固定的地方。对于每个备份文件，保留最原始的两个版本和最新的五个版本。
;;并且备份的时候，备份文件是复件，而不是原件。

;;不产生备份文件
;(setq make-backup-files nil) 

;;显示日期
;(setq display-time-day-and-date t)
;;显示时间
;(display-time)
;;时间为24小时制
;(setq display-time-24hr-format t)
;;时间显示包括日期和具体时间
;(setq display-time-day-and-date t)
;;时间的变化频率
;(setq display-time-interval 10)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;按键设置
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;将 M+x 绑定为 C+x C+m 与 C+c C+m
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; C+w 绑定为向前删除一词，原作用为删除到标记点（ C+@ )，现变为 C+x C+k 与 C+c C+k
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;扩展载入
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;set the default file path
(setq default-directory "~/.emacs.d/")
(add-to-list 'load-path "/")
(add-to-list 'load-path "~/.emacs.d/plugins/")

;; 高亮光标周围所有配对的括号
(require 'highlight-parentheses)
(highlight-parentheses-mode 1)

;; number window 给 buffer 上所有窗口编号
(require 'window-numbering)
(window-numbering-mode 1)

;; highlight-tail
(require 'highlight-tail)
(setq highlight-tail-colors
      '(("black" . 0)
        ("#606060" . 75)
        ("black" . 100)));))
(setq highlight-tail-posterior-type t)
(highlight-tail-mode 1)

;; kill-ring-search
(autoload 'kill-ring-search "kill-ring-search"
  "Search the kill ring in the minibuffer."
  (interactive))
(global-set-key "\M-\C-y" 'kill-ring-search)

;; ecb
;(require 'ecb)
;(require 'ecb-autoloads)

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete//ac-dict")
(ac-config-default)

;; for YAsnippet
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")

;;设置主题
(require 'color-theme)
(load-file "plugins/themes/color-theme-colorful-obsolescence.el")
(load-file "plugins/themes/color-theme-example.el")
(load-file "plugins/themes/color-theme-library.el")
(color-theme-colorful-obsolescence)

;;载入w3m扩展  浏览网页
(add-to-list 'load-path "plugins/emacs-w3m/")
(require 'w3m)
(require 'w3m-lnum)
(require 'w3m-util)

;;载入muse扩展  wiki
;; 由于使用 dokuwiki 所以暂停使用 muse
;(add-to-list 'load-path "plugins/muse/lisp/")
;(require 'muse-mode)     ; load authoring mode
;(require 'muse-html)     ; load publishing styles I use
;(require 'muse-latex)
;(require 'muse-texinfo)
;(require 'muse-docbook)
;(require 'muse-project)  ; publish files in projects

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;由扩展而生的设置
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Org-mode,emacs 23已经默认支持
;(add-to-list 'auto-mode-alist '("\\.org\\" . org-mode))

;;emacs-w3m设置
;启动和初始化w3m.el
(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(autoload 'w3m-search "w3m-search" "Search words using emacs-w3m." t)
;使用mule-ucs，只有在你安装mule-ucs elisp扩展包时这个才有用，可以看Unicode解码的网页
;(setq w3m-use-mule-ucs t)
;使用工具包
(setq w3m-use-toolbar t)
;启用cookie
(setq w3m-use-cookies t)
;设定w3m运行的参数，分别为使用cookie和使用框架
(setq w3m-command-arguments '("-cookie" "-F"))
;用w3m浏览网页时也显示图片
(setq w3m-default-display-inline-images t)
;设定w3m的语言设置，以便方便使用和阅读中文
;书签解码设置
;(setq w3m-bookmark-file-coding-system 'chinese-iso-8bit)
;w3m的解码设置
;(setq w3m-coding-system 'chinese-iso-8bit)
;(setq w3m-default-coding-system 'chinese-iso-8bit)
;(setq w3m-file-coding-system 'chinese-iso-8bit)
;(setq w3m-file-name-coding-system 'chinese-iso-8bit)
;(setq w3m-terminal-coding-system 'chinese-iso-8bit)
;(setq w3m-input-coding-system 'chinese-iso-8bit)
;(setq w3m-output-coding-system 'chinese-iso-8bit)
;w3m是使用tab的，设定Tab的宽度
(setq w3m-tab-width 8)
;设定w3m的主页，同mozilla的默认主页一样
(setq w3m-home-page "http://www.google.com")

;;emacs-muse的工程
;(setq muse-project-alist
;      '(("website" ("wiki/" :default "index")
;         (:base "html" :path "wiki/public_html")
;         (:Base "pdf" :path "wiki/public_html/pdf"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;快捷键设置
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;emacs 自加的
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.32"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
