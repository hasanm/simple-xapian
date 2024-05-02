(require :cffi)
(require :cffi-libffi)
(require :cl-ppcre)

(cffi:define-foreign-library libsimple-xapian
  (t (:default "libsimple-xapian")))

(setq cffi:*foreign-library-directories* (list #P"/home/p-hasan/work/qt/simple-xapian/build/"))

(cffi:use-foreign-library libsimple-xapian)

(cffi:defctype xapian-pointer :pointer)

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

(cffi:defcfun "easy_search" :int
  (handle my-xapian)
  (str :pointer)
  (beg :int)
  (end :int))

(defun my-search (handle query beg end)
  (unwind-protect
       (cffi:with-foreign-string (s query)
         (easy-search handle s beg end))))


(defparameter *instance* (easy-init))
(format t "~a~%" *instance*)
(my-search *instance* "UPASS" 0 5)


(sb-ext:exit)

