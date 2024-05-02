(require :cffi)
(require :cffi-libffi)
(require :cl-ppcre)

;; (push #P"/home/p-hasan/src/lisp/lisp-magick-wand/" asdf:*central-registry*)
;; (require "lisp-magick-wand")


(defparameter *input* "/data/aoe_images/my.png")
(defparameter *output* "/data/aoe_images/out.png")
(defparameter *lines* "/data/aoe_images/lines.txt")
(defparameter *rhos* "/data/aoe_images/rhos.txt")
(defparameter *home-work-images* '(
                           "/data/images/IMG_20221013_040208_1390.JPG"
                           "/data/images/IMG_20221013_040217_1391.JPG"
                           "/data/images/IMG_20221013_040225_1392.JPG"
                           "/data/homeworks/math3600/hw1/IMG_1335.JPG"
                           "/data/homeworks/math3600/hw1/IMG_1348.JPG"
                           "/data/homeworks/math3600/hw1/IMG_1344.JPG"
                           "/data/homeworks/math3600/hw1/IMG_1339.JPG"
                           "/data/homeworks/math3600/hw1/IMG_1338.JPG"
                           "/data/homeworks/math3600/hw1/IMG_1333.JPG"
                           "/data/homeworks/math3600/hw1/IMG_1342.JPG"
                           "/data/homeworks/math3600/hw1/IMG_1334.JPG"
                           "/data/homeworks/math3600/hw1/IMG_1347.JPG"
                           "/data/homeworks/math3600/hw1/IMG_1337.JPG"
                           "/data/homeworks/math3600/hw1/IMG_1346.JPG"
                           "/data/homeworks/math3600/hw1/IMG_1343.JPG"
                           "/data/homeworks/math3600/hw1/IMG_1341.JPG"
                           "/data/homeworks/math3600/hw1/IMG_1345.JPG"
                           "/data/homeworks/math3600/hw1/IMG_1340.JPG"
                           "/data/homeworks/math3600/hw1/IMG_1336.JPG"
                           ))

(defparameter *aoe-images* '(
                           "/data/aoe_images/Screenshot 2022-04-10 14.23.17.png"
                           "/data/aoe_images/Screenshot 2022-04-23 22.41.28.png"
                           "/data/aoe_images/Screenshot 2022-05-07 17.15.09.png"
                           "/data/aoe_images/Screenshot 2022-05-12 21.20.30.png"
                           "/data/aoe_images/Screenshot 2022-06-16 13.56.17.png"
                           "/data/aoe_images/Screenshot 2022-06-17 23.15.03.png"
                           "/data/aoe_images/Screenshot 2022-08-31 02.12.46.png"
                           "/data/aoe_images/Screenshot 2022-09-10 18.57.06.png"
                           "/data/aoe_images/Screenshot 2022-09-18 03.02.22.png"
                           "/data/aoe_images/Screenshot 2022-11-02 23.07.17.png"
                           "/data/aoe_images/Screenshot 2022-11-11 14.14.09.png"
                           "/data/aoe_images/Screenshot 2022-11-11 14.14.14.png"
                           "/data/aoe_images/Screenshot 2022-11-11 14.14.40.png"
                           "/data/aoe_images/Screenshot 2022-11-25 11.53.13.png"
                           "/data/aoe_images/Screenshot 2022-12-16 05.27.13.png"
                           "/data/aoe_images/Screenshot 2022-12-25 13.29.59.png"
                           "/data/aoe_images/Screenshot 2023-01-01 21.09.53.png"
                           "/data/aoe_images/Screenshot 2023-02-20 18.08.42.png"
                           "/data/aoe_images/Screenshot 2023-02-22 13.35.17.png"
                           "/data/aoe_images/Screenshot 2023-02-26 04.58.34.png"
                           "/data/aoe_images/Screenshot 2023-03-07 22.48.50.png"
                      ))

(cffi:define-foreign-library libsimple
  (t (:default "libsimple")))

(setq cffi:*foreign-library-directories* (list #P"/home/p-hasan/work/qt/simple-cv/build/"))

(cffi:use-foreign-library libsimple)
;; (cffi:load-foreign-library 'libsimple)

(cffi:defcenum imread-modes
  :IMREAD_GRAYSCALE
  :IMREAD_COLOR)


(cffi:defctype mat-pointer :pointer)
(cffi:defcfun "easy_init" mat-pointer)


(defclass my-container ()
  ((pointer :initform (easy-init)
            :initarg :pointer)
   (c-strings :initform '())
   ))

(cffi:define-foreign-type my-container-type ()
  ()
  (:actual-type mat-pointer)
  (:simple-parser my-container))


(defmethod cffi:translate-to-foreign (handle (type my-container-type))
  (slot-value handle 'pointer))

(defmethod cffi:translate-from-foreign (ptr (type my-container-type))
  (make-instance 'my-container :pointer ptr))



(cffi:defcfun "experiment" :int)

(cffi:defcfun "copy_image" :int
  (filename :pointer))

(cffi:defcfun "paste_image" :int
  (filename :pointer))

(cffi:defcfun "cut_image" :pointer
  (handle my-container)
  (x :int)
  (y :int)
  (p :int)
  (q :int))

(cffi:defcfun "load_image" :int
  (handle my-container)
  (filename :pointer)
  (read-mode :int))

(cffi:defcfun "save_image" :int
  (handle my-container)
  (filename :pointer))


(cffi:defcfun "new_lines" :int
  (handle my-container))

(cffi:defcfun "push_line" :int
  (handle my-container)
  (x1 :int)
  (x2 :int)
  (y1 :int)
  (y2 :int)
  (r :int)
  (g :int)
  (b :int)
  )

(cffi:defcfun "draw_lines" :int
  (handle my-container))

(cffi:defcfun "draw_rectangle" :int
  (x :int)
  (y :int)
  (p :int)
  (q :int))


(cffi:defcfun "adaptive_threshold" my-container
  (handle my-container))
(cffi:defcfun "my_merge" :int)
(cffi:defcfun "make_gray" :int)
(cffi:defcfun "grab_cut" :int)

(cffi:defcfun "canny_edge" :int
  (edge-thresh :int))

(cffi:defcfun "hough_lines" :int
  (edge-thresh :int)
  (min-theta :double)
  (max-theta :double))

(cffi:defcfun "hough_lines_p" :int
  (edge-thresh :int)
  (vote-thresh :int)
  (min-line-length :int)
  (max-line-gap :int))

(cffi:defcfun "gaussian_blur" :int
  (m-size :int))

(cffi:defcfun "find_contours" :int
  (m-size :int)
  (edge-thresh :int))

(cffi:defcfun "hough_circles" :int
  (dp :double)
  (param1 :double)
  (param2 :double)
  (min-radius :int)
  (max-radius :int)    
  )

(cffi:defcfun "find_inside" :int)

(defun get-minimap (handle)
  (cut-image handle 1250 1200 1750 1425)
  )

(defun get-wood (handle)
  (let ((x 10))
   (cut-image handle x 10 (+ x 135) 70))
  )

(defun get-food (handle)
  (let ((x 145))
   (cut-image handle x 10 (+ x 135) 70))
  )

(defun get-gold (handle)
  (let ((x 280))
   (cut-image handle x 10 (+ x 135) 70))
  )

(defun get-stone (handle)
  (let ((x 420))
   (cut-image handle x 10 (+ x 135) 70))
  )


(defun get-vills (handle )
  (let ((x 540))
   (cut-image handle x 10 (+ x 210) 70))
  )


(defun save-this ()
  (let ()
    (unwind-protect
         (cffi:with-foreign-string (filename *output*)
           (copy-image filename)))))

(defun my-save-image (filename)
  (unwind-protect
       (cffi:with-foreign-string (f filename)
         (paste-image f)))  
  )


(defun load-some-image (n)
  (let ((image-filenames *home-work-images*)
        )
    (unwind-protect
         (cffi:with-foreign-string (filename (nth n image-filenames))
           (copy-image filename)
           ;; (cut-image 1250 1200 1750 1425)
           ))
    (nth n image-filenames)
    ))
;; (load-image "/data/001233702.PNG")
;; (draw-rectangle 0 0 1000 500)
;; (my-merge)
;; (canny-edge 50)
;; (hough-lines 60 10d0 (+ (/ pi 6) (/ pi 2)) pi)
;; (hough-lines 60 50 10 0d0 pi)
;; (hough-lines 150 0d0 pi)
;; (hough-lines-p 60 50 10)
;; (hough-lines-p 40 50 10)
;; (gaussian-blur 101)
;; (adaptive-threshold)
;; (sb-ext:exit)




(defun load-lines ()
  (let ((filename "/data/aoe_images/lines.txt")
        (lines))
    (with-open-file (in filename)
      (loop for line = (read-line in nil)
            while line
            do (let* ((my-line (remove #\Return line))
                      (points (mapcar #'parse-integer (cl-ppcre:split "," my-line)))
                      (x1 (nth 0 points))
                      (x2 (nth 1 points))
                      (y1 (nth 2 points))
                      (y2 (nth 3 points)))
                 (push (list x1 x2 y1 y2) lines))))
    lines))


(defun load-circles ()
  (let ((filename "/data/aoe_images/circles.txt")
        (circles))
    (with-open-file (in filename)
      (loop for line = (read-line in nil)
            while line
            do (let* ((my-line (remove #\Return line))
                     (points (mapcar #'parse-integer (cl-ppcre:split "," my-line)))
                      (x (nth 0 points))
                      (y (nth 1 points))
                      (r (nth 2 points)))
                 (push (list x y r) circles))))
    circles))


(defun load-rhos ()
  (let ((filename "/data/aoe_images/rhos.txt")
        (lines))
    (with-open-file (in filename)
      (loop for line = (read-line in nil)
            while line
            do (let* ((my-line (remove #\Return line))
                      (parts (cl-ppcre:split "," my-line))
                      (rho (read-from-string (nth 0 parts)))
                      (theta (read-from-string (nth 1 parts))))
                 (format t "~10d|~10,3f~%" rho theta)
                 )))
    lines))


(defun my-load-image-with-index (index) 
  (let ((image-filenames '(
                           "/data/images/IMG_20221013_040208_1390.JPG"
                           "/data/images/IMG_20221013_040217_1391.JPG"
                           "/data/images/IMG_20221013_040225_1392.JPG"
                           ))
        (handle (make-instance 'my-container)))
    (unwind-protect
         (cffi:with-foreign-string (filename (nth index image-filenames))
           (copy-image filename)
           (hough-lines-p 40 50 50 10)           
           (let ((lines (load-lines)))
             (new-lines handle)
             (loop for line in lines
                   for i from 0
                   do (let* ((x1 (nth 0 line))
                             (x2 (nth 1 line))
                             (y1 (nth 2 line))
                             (y2 (nth 3 line))
                             (diff-x (abs (- x1 x2)))
                             (diff-y (abs (- y1 y2)))
                             (l
                               (sqrt
                                (+ (expt diff-x 2)
                                   (expt diff-y 2)
                                   ))))

                        (progn
                          ;; (format t "~a~%" line)
                          (format t "~3d ~10d|~10d|~10d|~10d|~10d|~10d|~10,3f|~10,3f~%" i x1 x2 y1 y2 diff-x diff-y slope l )
                          (push-line handle x1 x2 y1 y2 255 0 0))))
             (draw-lines handle))))))

;; (find-contours 101 40)
;; (adaptive-threshold)

(defun my-test (n)
  (let () 
    (load-some-image n)
    (let ((likely-center (find-inside)))
      (format t "likely-center ~a~%" likely-center)

      (hough-circles 1d0 50d0 50d0 30 60)
      (let ((circles (sort
                      (load-circles)
                      (lambda (x y)
                        (< (abs (- likely-center x))
                           (abs (- likely-center y))
                           )
                        )
                      :key
                      #'first))
            (more-circles)
            )
        
        (loop for item in '((0 1)
                            (0 2)
                            (1 2))
              do (let* ((a (first item))
                        (b (second item))
                        (a-circle (nth a circles))
                        (b-circle (nth b circles)))
                   (push (list (abs (- (first a-circle) (first b-circle)))
                               a-circle
                               b-circle)
                         more-circles
                         )))
        (let* ((majority (first (sort more-circles #'< :key #'first)) )
               (x (first (second majority)))
               (y1 (second (second majority)))
               (y2 (second (third majority)))
               (d (abs (- y1 y2)))
               (rx-1 (max 0( - x
                            (ceiling (/ d 8)))))
               (ry-1(- y1
                             (ceiling (/ d 3))))
               (rx-2       (+ x (ceiling (* d 1.9))))
               (ry-2 (+ y1
                             (ceiling (* d 2.25))))
               )
          (format t "More ~a : ~a , ~a , ~a, ~a~%" majority x y1 y2 d)
          (format t "Rectangle : ~a , ~a , ~a, ~a~%" rx-1 ry-1 rx-2 ry-2)          
          (draw-rectangle rx-1
                          ry-1
                          rx-2
                          ry-2)

          (cut-image rx-1 ry-1 rx-2 ry-2)
          (save-this)
          (gaussian-blur 101)
          )))))


;; (my-test 3)

;; (experiment)
;; (grab-cut)
;; (hough-lines-p 40 50 50 10)


(defun process-lines () 
  (let ((handle (make-instance 'my-container)))
    (unwind-protect
         (cffi:with-foreign-string (s "" )
           (let ((lines (load-lines)))
             (new-lines handle)
             (loop for line in lines
                   for i from 0
                   do (let* ((x1 (nth 0 line))
                             (x2 (nth 1 line))
                             (y1 (nth 2 line))
                             (y2 (nth 3 line))
                             (diff-x (abs (- x1 y1)))
                             (diff-y (abs (- x2 y2)))
                             (l
                               (sqrt
                                (+ (expt diff-x 2)
                                   (expt diff-y 2)
                                   )))
                             
                             )

                        (if (< diff-x 50)
                            (let ()
                              ;; (format t "~3d ~10d|~10d|~10d|~10d|~10d|~10d|~10,3f|~10,3f~%" i x1 x2 y1 y2 diff-x diff-y slope l )
                              (push-line handle x1 0 y1 4031 0 0 255)
                              ))))
             (draw-lines handle))))))

(defun another-test ()
  (let ()
    (my-test 1)
    (if nil (loop for image-filename in *home-work-images*
                  for i from 0
                  do (let ()
                       (my-test i)
                       (my-save-image (concatenate 'string "/data/image_outputs/" (write-to-string (+ i 1)) ".JPG")))))))

(defun pr (ptr)
  (let ((result (make-instance 'my-container)))
    (setf (slot-value result 'pointer) ptr)
    result))

(defun my-load-image (filename)
  (let ((handle (make-instance 'my-container)))
    (unwind-protect
         (cffi:with-foreign-string (out *output*)
           (cffi:with-foreign-string (f filename)
             (let ()
               (load-image handle f (cffi:foreign-enum-value 'imread-modes :IMREAD_COLOR))
               (save-image (adaptive-threshold handle) out)
               ;; (adaptive-threshold handle)
               ))))))

(my-load-image (nth  0 *home-work-images*))

(sb-ext:exit)

