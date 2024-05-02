(require :cffi)
(require :cffi-libffi)
(require :cl-ppcre)

(cffi:define-foreign-library libsimple-xapian
  (t (:default "libsimple-xapian")))

(setq cffi:*foreign-library-directories* (list #P"/home/p-hasan/work/qt/simple-xapian/build/"))

(cffi:use-foreign-library libsimple-xapian)


(sb-ext:exit)

