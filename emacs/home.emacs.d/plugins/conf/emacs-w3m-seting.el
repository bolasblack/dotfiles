;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; emacs-w3m设置
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;载入w3m扩展  浏览网页
(add-to-list 'load-path "plugins/emacs-w3m/")
(require 'w3m)
(require 'w3m-lnum)
(require 'w3m-util)

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