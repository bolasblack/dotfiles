;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;系统设置
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 没有 toolbar
(tool-bar-mode nil)

;; 没有 menubar,用 f12 呼出
(menu-bar-mode nil)

;; ido-mode,强化 C+x C+f
(ido-mode t)

;; 自动打开上次任务
(desktop-save-mode 1)

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

;; 如果设置为 t，光标在 TAB 字符上会显示为一个大方块 :)。
(setq x-stretch-cursor t)

;;不用 TAB 字符来indent, 这会引起很多奇怪的错误。编辑 Makefile
;;的时候也不用担心，因为 makefile-mode 会把 TAB 键设置成真正的
;;TAB 字符，并且加亮显示的。
;(setq-default indent-tabs-mode nil)
;(setq default-tab-width 4)
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

;;set the default file path
(setq default-directory "~/")

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

(provide 'global-setting)