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

;; ģ�� Vim �� (.) �Ĺ���
(require 'dot-mode)


;; ���������Χ������Ե�����
(require 'highlight-parentheses)
(highlight-parentheses-mode 1)


;; number window �� buffer �����д��ڱ��
(require 'window-numbering)
(window-numbering-mode 1)


;; color-theme �������
(require 'color-theme)
(load-file "~/.emacs.d/plugins/themes/color-theme-example.el")
(load-file "~/.emacs.d/plugins/themes/color-theme-library.el")
(load-file "~/.emacs.d/plugins/themes/color-theme-colorful-obsolescence.el")
(color-theme-colorful-obsolescence)


;; YAsnippet ���������
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
;; ��ݼ�����
(global-set-key (kbd "<M-down>") 'tabbar-backward-group)
(global-set-key (kbd "<M-up>") 'tabbar-forward-group)
(global-set-key (kbd "<M-left>") 'tabbar-backward)
(global-set-key (kbd "<M-right>") 'tabbar-forward)

;;;; ����tabbar���
;; ����Ĭ������: ����, ������ǰ����ɫ����С
;(set-face-attribute 'tabbar-default-face nil
;                    ;:family "Vera Sans YuanTi Mono"
;                    :background "gray0"
;                    :foreground "gray30"
;                    ;:height 0.3
;                    )
;; ������߰�ť��ۣ�����ߴ�С����ɫ
;(set-face-attribute 'tabbar-button-face nil
;                    :inherit 'tabbar-default
                    ;:box '(:line-width 0 :color "gray30")
;                    )
;; ���õ�ǰtab��ۣ���ɫ�����壬����С����ɫ
;(set-face-attribute 'tabbar-selected-face nil
;                    :inherit 'tabbar-default
;                    :foreground "black"
;                    :background "gray"
                    ;:box '(:line-width 0 :color "gray")
                    ;; :overline "black"
                    ;; :underline "black"
;                    :weight 'bold
;                    )
;; ���÷ǵ�ǰtab��ۣ�����С����ɫ
;(set-face-attribute 'tabbar-unselected-face nil
;                    :inherit 'tabbar-default
                    ;:box '(:line-width 0 :color "black")
;                    )




;; php mode ���������
;(require 'php-mode-setting)
;; w3m �������
;(require 'emacs-w3m-setting)
;; ʹ֧�� txt2tags �﷨
;(require 't2t-mode)
;; highlight-tail �������
;(require 'highlight-tail-setting)


(provide 'pluginsConf)