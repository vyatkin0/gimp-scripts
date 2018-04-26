;; file-picture-make-size -- a script for GIMP
;; Author: Aleksey Vyatkin <avyatkin@gmail.com>
;; Scales and crops a picture to get sizes 1024x800 520x340

(define (file-picture-make-size pattern)
	(let* 
		((filelist (cadr (file-glob pattern 1))))
		(while (not (null? filelist))

			(let*
				(
					(filename (car filelist))
					(image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
					(drawable (car (gimp-image-get-active-layer image)))
				)
				(script-picture-crop-to-size image drawable 1024 800)		
				(file-jpeg-save RUN-NONINTERACTIVE image drawable (string-append "cropped\\" filename) (string-append "cropped\\" filename) 1.0 0.0 0 0 "" 2 0 0 0)
				(gimp-image-delete image)
			)
			
			(let*
				(
					(filename (car filelist))
					(image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
					(drawable (car (gimp-image-get-active-layer image)))
				)
				(script-picture-make-size image drawable 520 340)
				(file-jpeg-save RUN-NONINTERACTIVE image drawable (string-append "520\\" filename) (string-append "520\\" filename) 1.0 0.0 0 0 "" 2 0 0 0)
				(gimp-image-delete image)
			)
			
			(set! filelist (cdr filelist))
		)
	)
)

(script-fu-register "file-picture-make-size"
"Batch file scale and crop"
"Scales and crops a picture from file to get desired sizes"
"Aleksey Vyatkin"
"Aleksey Vyatkin"
"April 2018"
""
SF-STRING "SF-STRING" "FileMask"
)

(script-fu-menu-register "file-picture-make-size" "<Image>/Filters/Vyatkin/")
