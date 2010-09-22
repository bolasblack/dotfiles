;;加载php-mode
(require 'php-mode)

(defun my-php-mode()
  ;;设置php程序的对齐风格
  (c-set-style "K&R")
  ;;自动模式，在此种模式下当你键入｛时，会自动根据你设置的对齐风格对齐
  (c-toggle-auto-state)
  ;;此模式下，当按backspace时会删除最多的空格
  (c-toggle-hungry-state)
  ;;Tab 键的宽度设置为4
  (setq cbasic-offset 4)
  ;;在菜单中加入当前buffer的函数索引
  (imenu-add-menubar-index)
  ;;在状态条上显示当前光标在哪个函数体内部
  (which-function-mode)
)
(add-hook 'php-mode-hook 'my-php-mode)