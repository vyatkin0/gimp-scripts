;; file-picture-crop-to-size -- a script for GIMP
;; Author: Aleksey Vyatkin <avyatkin@gmail.com>
;; Crops a picture from file to get size 1024x800

(define (file-picture-crop-to-size in_filename out_filename)
	(let*
		(
			(image (car (gimp-file-load RUN-NONINTERACTIVE in_filename in_filename)))
			(drawable (car (gimp-image-get-active-layer image)))
		)
		
		(script-picture-crop-to-size image drawable 1024 800)
		
		(gimp-file-save RUN-NONINTERACTIVE image drawable out_filename out_filename)
		(gimp-image-delete image)
	)
)

(script-fu-register "file-picture-crop-to-size"
"File crop"
"Crops a picture from file to get desired size"
"Aleksey Vyatkin"
"Aleksey Vyatkin"
"April 2018"
""
SF-FILENAME "SF-FILENAME" "InFileName"
SF-STRING "SF-STRING" "OutFileName"
)

(script-fu-menu-register "file-picture-crop-to-size" "<Image>/Filters/Vyatkin/")
