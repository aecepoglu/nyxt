(in-package :nyxt)

(defun format-status (window)
  (let ((buffer (current-buffer window)))
    (markup:markup
     (:span (format nil "[~{~a~^ ~}]"
                    (mapcar (lambda (m) (str:replace-all "-mode" ""
                                                         (str:downcase
                                                          (class-name (class-of m)))))
                            (modes buffer))))
     (:a :class "button" :title "Backwards" :href (lisp-url '(nyxt/web-mode:history-backwards)) "←")
     (:a :class "button" :title "Forwards" :href (lisp-url '(nyxt/web-mode:history-forwards)) "→")
     (:a :class "button" :title "Reload" :href (lisp-url '(nyxt:reload-current-buffer)) "↺")
     (:a :class "button" :title "Execute" :href (lisp-url '(nyxt:execute-command)) "⚙")
     (:a :class "button" :title "Buffers" :href (lisp-url '(nyxt::buffers)) "≡")
     (:span :class (when (eq (slot-value buffer 'load-status) :loading) "loader") "")
     (:span (if (eq (slot-value buffer 'load-status) :loading) "Loading: " ""))
     (:a :class "button"
         :href (lisp-url '(nyxt:set-url-from-current-url))
      (format nil " ~a — ~a"
              (object-display (url buffer))
              (title buffer))))))
