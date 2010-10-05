;; highlight-tail 插件的相关设置
(require 'highlight-tail)
(setq highlight-tail-colors
      '(("black" . 0)
        ("#606060" . 25)
        ("black" . 75)));))
(setq highlight-tail-posterior-type t)
(highlight-tail-mode 1)

(provide 'highlight-tail-setting)