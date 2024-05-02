(require :cffi)
(require :cffi-libffi)
(require :cl-ppcre)

(cffi:define-foreign-library libsimple-xapian
  (t (:default "libsimple-xapian")))

(setq cffi:*foreign-library-directories* (list #P"/home/p-hasan/work/qt/simple-xapian/build/"))

(cffi:use-foreign-library libsimple-xapian)

(cffi:defctype xapian-pointer :pointer)

(cffi:defctype size :unsigned-int)

(defclass my-xapian ()
  ((pointer :initform (cffi:foreign-alloc :char :count 1
                                                :initial-element 0)
            :initarg :pointer)
   (c-strings :initform '())))


(cffi:define-foreign-type my-xapian-type ()
  ()
  (:actual-type xapian-pointer)
  (:simple-parser my-xapian))


(defmethod cffi:translate-to-foreign (handle (type my-xapian-type))
  (slot-value handle 'pointer))

(defmethod cffi:translate-from-foreign (ptr (type my-xapian-type))
  (make-instance 'my-xapian :pointer ptr))


(cffi:defcfun "easy_init" my-xapian)

(cffi:defcfun "easy_estimate" :int
  (handle my-xapian)
  (str :pointer))

(cffi:defcfun "easy_search" :int
  (handle my-xapian)
  (str :pointer)
  (beg :int)
  (end :int))


(cffi:defcfun "easy_perform" :int
  (handle my-xapian)
  (str :pointer)
  (beg :int)
  (end :int)
  (f   :pointer))

(cffi:defcallback easy-write size ((size size))
  (let ()
    (handler-case
        (progn (funcall (symbol-value '*easy-write-procedure*)
                        size)
               3)
      (error () (if (zerop 3) 1 0)))))


(defun my-perform (query)
  (let ((handle (easy-init)))
    (with-slots (pointer) handle
      (with-output-to-string (contents)
        (let ((*easy-write-procedure*
                (lambda (string)
                  (format t "~a TYPE : ~a~%"  string (type-of string))
                  (write-string string contents))))
          (declare (special *easy-write-procedure*))
          (unwind-protect
               (cffi:with-foreign-string (s query)
                 (easy-perform handle s 0 10 (cffi:callback easy-write))))
          (format t "OUTPUT : ~a~%" (get-output-stream-string contents)))))))


(defun my-estimate (handle query)
  (unwind-protect
       (cffi:with-foreign-string (s query)
         (easy-estimate handle s))))

(defun my-search (handle query beg end)
  (unwind-protect
       (cffi:with-foreign-string (s query)
         (easy-search handle s beg end))))

(defparameter *instance* (easy-init))
(format t "~a~%" *instance*)
;; (format t "Estimated : ~a ~%" (my-estimate *instance* "UPASS"))
;; (my-search *instance* "UPASS" 0 5)
(my-perform "UPASS")


(sb-ext:exit)

