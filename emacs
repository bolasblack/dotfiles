;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;ϵͳ����
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; û�� toolbar
(tool-bar-mode nil);
;; û�� menubar
;(setq menu-bar-mode nil

;; �к�

;; ��������
(setq c-basic-offset 4)

;; ��������
(set-face-attribute 'default nil :font "��Ȫ��ȿ�΢�׺�-9")

;;�ر���ʱ���Ǹ����������桱��
(setq inhibit-startup-message t)

;;�� Emacs ����ֱ�Ӵ򿪺���ʾͼƬ��
(auto-image-file-mode t)

;;����Щȱʡ���õĹ��ܴ򿪡�
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'LaTeX-hide-environment 'disabled nil)

;;Ctrl+Space��Ч
(global-set-key (kbd "C-SPC")'nil)

;;�رշ��˵ĳ���ʱ����ʾ����
(setq visible-bell t)

;;��ʾ�к�
(setq column-number-mode t)

;;��һ���ܴ�� kill ring. ������ֹ��С��ɾ����Ҫ�Ķ���
(setq kill-ring-max 200)

;;�� fill-column ��Ϊ 60. ���������ָ��ö���
(setq default-fill-column 60)

;;��һ���ܴ�� kill ring. ������ֹ��С��ɾ����Ҫ�Ķ���
(setq kill-ring-max 200)

;;�� fill-column ��Ϊ 60. ���������ָ��ö���
(setq default-fill-column 60)

;;���� TAB �ַ���indent, �������ܶ���ֵĴ��󡣱༭ Makefile
;;��ʱ��Ҳ���õ��ģ���Ϊ makefile-mode ��� TAB �����ó�������
;;TAB �ַ������Ҽ�����ʾ�ġ�
;(setq-default indent-tabs-mode nil)
;(setq default-tab-width 8)
;(setq tab-stop-list ())
;(loop for x downfrom 40 to 1 do
;      (setq tab-stop-list (cons (* x 4) tab-stop-list)))

;;���� sentence-end ����ʶ�����ı�㡣������ fill ʱ�ھ�ź���������ո�
(setq sentence-end "\\([������]\\|����\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)

;;����ƥ��ʱ��ʾ����һ�ߵ����ţ������Ƿ��˵�������һ�����š�
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;������ʾƥ������š�
(show-paren-mode 1)

;;��꿿�����ָ��ʱ�������ָ���Զ��ÿ�����ס���ߡ�
(mouse-avoidance-mode 'animate)

;;ָ�벻�������л��۾���
(blink-cursor-mode -1)
(transient-mark-mode 1)

;;�ڱ�������ʾbuffer�����֣������� emacs@email.***����û�õ���ʾ��
(setq frame-title-format "emacs@%b")

;;�﷨����
(global-font-lock-mode t)

;;���еı����ļ���������~/backupsĿ¼��
(setq backup-directory-alist (quote (("." . "~/.emacs.d/backups"))))
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 5)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)
;;emacs�У��ı��ļ�ʱ��Ĭ�϶�����������ļ�����~��β���ļ�����������ȫȥ��
;;��������ȡ����Ҳ�����ƶ����ݵķ�ʽ��������õ��ǣ������е��ļ����ݶ�����һ��
;;�̶��ĵط�������ÿ�������ļ���������ԭʼ�������汾�����µ�����汾��
;;���ұ��ݵ�ʱ�򣬱����ļ��Ǹ�����������ԭ����

;;�����������ļ�
;(setq make-backup-files nil) 

;;��ʾ����
(setq display-time-day-and-date t)
;;��ʾʱ��
(display-time)
;;ʱ��Ϊ24Сʱ��
(setq display-time-24hr-format t)
;;ʱ����ʾ�������ں;���ʱ��
(setq display-time-day-and-date t)
;;ʱ��ı仯Ƶ��
(setq display-time-interval 10)

;;;}}}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;��������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;�� M+x ��Ϊ C+x C+m �� C+c C+m
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; C+w ��Ϊ��ǰɾ��һ�ʣ�ԭ����Ϊɾ������ǵ㣨 C+@ )���ֱ�Ϊ C+x C+k �� C+c C+k
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;��չ����
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;set the default file path
(setq default-directory "~/.emacsfiles/")
(add-to-list 'load-path "/")
(add-to-list 'load-path "/usr/share/emacs23/site-lisp")
(add-to-list 'load-path "/usr/share/emacs23/site-lisp/ecb")

;; ecb
(require 'ecb)
(require 'ecb-autoloads)

;; auto-complete
(add-to-list 'load-path "plugins/auto-complete/")
(require 'auto-complete)

;;��������
;(load-file "plugins/color-theme.el")
;(require 'color-theme)
;(color-theme-initialize)
;(load-file "themes/color-theme-colorful-obsolescence.el")
;(color-theme-colorful-obsolescence)

;;����w3m��չ  �����ҳ
(add-to-list 'load-path "plugins/emacs-w3m/")
(require 'w3m)
(require 'w3m-lnum)
(require 'w3m-util)

;;����muse��չ  wiki
(add-to-list 'load-path "plugins/muse/lisp/")
(require 'muse-mode)     ; load authoring mode
(require 'muse-html)     ; load publishing styles I use
(require 'muse-latex)
(require 'muse-texinfo)
(require 'muse-docbook)
(require 'muse-project)  ; publish files in projects

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;����չ����������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Org-mode,emacs 23�Ѿ�Ĭ��֧��
;(add-to-list 'auto-mode-alist '("\\.org\\" . org-mode))

;;emacs-w3m����
;�����ͳ�ʼ��w3m.el
(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(autoload 'w3m-search "w3m-search" "Search words using emacs-w3m." t)
;ʹ��mule-ucs��ֻ�����㰲װmule-ucs elisp��չ��ʱ��������ã����Կ�Unicode�������ҳ
;(setq w3m-use-mule-ucs t)
;ʹ�ù��߰�
(setq w3m-use-toolbar t)
;����cookie
(setq w3m-use-cookies t)
;�趨w3m���еĲ������ֱ�Ϊʹ��cookie��ʹ�ÿ��
(setq w3m-command-arguments '("-cookie" "-F"))
;��w3m�����ҳʱҲ��ʾͼƬ
(setq w3m-default-display-inline-images t)
;�趨w3m���������ã��Ա㷽��ʹ�ú��Ķ�����
;��ǩ��������
;(setq w3m-bookmark-file-coding-system 'chinese-iso-8bit)
;w3m�Ľ�������
;(setq w3m-coding-system 'chinese-iso-8bit)
;(setq w3m-default-coding-system 'chinese-iso-8bit)
;(setq w3m-file-coding-system 'chinese-iso-8bit)
;(setq w3m-file-name-coding-system 'chinese-iso-8bit)
;(setq w3m-terminal-coding-system 'chinese-iso-8bit)
;(setq w3m-input-coding-system 'chinese-iso-8bit)
;(setq w3m-output-coding-system 'chinese-iso-8bit)
;w3m��ʹ��tab�ģ��趨Tab�Ŀ��
(setq w3m-tab-width 8)
;�趨w3m����ҳ��ͬmozilla��Ĭ����ҳһ��
(setq w3m-home-page "http://www.google.com")

;;emacs-muse�Ĺ���
(setq muse-project-alist
      '(("website" ("wiki/" :default "index")
         (:base "html" :path "wiki/public_html")
         (:Base "pdf" :path "wiki/public_html/pdf"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;��ݼ�����
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;