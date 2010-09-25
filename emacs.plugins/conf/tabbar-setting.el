(require 'tabbar)

(tabbar-mode t)

;; 快捷键设置
;(global-set-key (kbd "") 'tabbar-backward-group)
;(global-set-key (kbd "") 'tabbar-forward-group)
;(global-set-key (kbd "") 'tabbar-backward)
;(global-set-key (kbd "") 'tabbar-forward)

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

(provide 'tabbar-setting)