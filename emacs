(add-to-list 'load-path "~/.emacs.d/plugins/conf/")
(add-to-list 'load-path "~/.emacs.d/plugins/")

;; 针对某种后缀名打开 mode 
;(add-to-list'auto-mode-alist '("\\.org\\'".org-mode))

;;;;;;

;; 全局设定
(require 'global-setting)
;; 快捷键设置
(require 'kbd-setting)
;; emacs 的标签的实现
(require 'tabbar-setting)
;; php mode 的相关设置
(require 'php-mode-setting)
;; w3m 相关设置
(require 'emacs-w3m-setting)
;; 使支持 txt2tags 语法
(require 't2t-mode)
;; 模仿 Vim 中 (.) 的功能
(require 'dot-mode)
;; 高亮光标周围所有配对的括号
(require 'highlight-parentheses)
(highlight-parentheses-mode 1)
;; number window 给 buffer 上所有窗口编号
(require 'window-numbering)
(window-numbering-mode 1)
;; highlight-tail 相关设置
(require 'highlight-tail-setting)
;; auto-complete 相关设置
(require 'auto-complete-setting)
;; for YAsnippet
(require 'yasnippet-setting)
;;设置主题
(require 'color-theme-setting)

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
