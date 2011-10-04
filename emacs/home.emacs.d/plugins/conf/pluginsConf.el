(defun require-extensions (action lst)
  (mapcar (lambda(ext)
	    (funcall action ext)) lst))

(require-extensions 'require
 (list 
  'tabbar 
;  'switch-window
;  'thing-edit
;  'second-sel
;  'browse-kill-ring+
;  'bbdb
;  'gnuplot
;  'muse-mode
  'ibuffer
;  'w3m-load
;  'rect-mark
;  'ido
;  'multi-term
;  'lusty-explorer
;  'oddmuse
;  'emaci
;  'move-text
;  'uniquify
;  'hide-region
))

;; 模仿 Vim 中 (.) 的功能
(require 'dot-mode)


;; 高亮光标周围所有配对的括号
(require 'highlight-parentheses)
(highlight-parentheses-mode 1)


;; number window 给 buffer 上所有窗口编号
(require 'window-numbering)
(window-numbering-mode 1)


;; color-theme 相关设置
(require 'color-theme)
(load-file "~/.emacs.d/plugins/themes/color-theme-example.el")
(load-file "~/.emacs.d/plugins/themes/color-theme-library.el")
(load-file "~/.emacs.d/plugins/themes/color-theme-colorful-obsolescence.el")
(color-theme-colorful-obsolescence)


;; YAsnippet 的相关设置
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")


;; zencoding
(require 'zencoding-mode)


;; fold.el
(require 'fold)
(fold-mode 1)


;; auto-complete
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete//ac-dict")
(ac-config-default)
(auto-complete-mode 1)


;; tabber
;(require 'tabbar)
(tabbar-mode t)
;; 快捷键设置
(global-set-key (kbd "<M-down>") 'tabbar-backward-group)
(global-set-key (kbd "<M-up>") 'tabbar-forward-group)
(global-set-key (kbd "<M-left>") 'tabbar-backward)
(global-set-key (kbd "<M-right>") 'tabbar-forward)

;;;; 设置tabbar外观
;; 设置默认主题: 字体, 背景和前景颜色，大小
;(set-face-attribute 'tabbar-default-face nil
;                    ;:family "Vera Sans YuanTi Mono"
;                    :background "gray0"
;                    :foreground "gray30"
;                    ;:height 0.3
;                    )
;; 设置左边按钮外观：外框框边大小和颜色
;(set-face-attribute 'tabbar-button-face nil
;                    :inherit 'tabbar-default
                    ;:box '(:line-width 0 :color "gray30")
;                    )
;; 设置当前tab外观：颜色，字体，外框大小和颜色
;(set-face-attribute 'tabbar-selected-face nil
;                    :inherit 'tabbar-default
;                    :foreground "black"
;                    :background "gray"
                    ;:box '(:line-width 0 :color "gray")
                    ;; :overline "black"
                    ;; :underline "black"
;                    :weight 'bold
;                    )
;; 设置非当前tab外观：外框大小和颜色
;(set-face-attribute 'tabbar-unselected-face nil
;                    :inherit 'tabbar-default
                    ;:box '(:line-width 0 :color "black")
;                    )




;; php mode 的相关设置
;(require 'php-mode-setting)
;; w3m 相关设置
;(require 'emacs-w3m-setting)
;; 使支持 txt2tags 语法
;(require 't2t-mode)
;; highlight-tail 相关设置
;(require 'highlight-tail-setting)


(provide 'pluginsConf)