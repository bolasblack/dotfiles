(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'load-path "~/.emacs.d/plugins/conf/")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;扩展载入
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 模仿 Vim 中 (.) 的功能
(require 'dot-mode)

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

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete//ac-dict")
(ac-config-default)
(auto-complete-mode 1)

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
