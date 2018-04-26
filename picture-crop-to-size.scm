;; picture-crop-to-size -- a script for GIMP
;; Author: Aleksey Vyatkin <avyatkin@gmail.com>
;; Crops a picture to get desired size

(define (script-picture-crop-to-size image layer max_width max_height)
	(let*
		(
			(width (car (gimp-drawable-width layer)))
			(height (car (gimp-drawable-height layer)))
			(offsetx (/ (- width max_width) 2))
			(offsety (/ (- height max_height) 2))
		)
		
		(gimp-image-undo-group-start image)
		(gimp-context-push)

		(if (> width max_width)
			(gimp-image-crop image max_width height offsetx 0)
		)

		(if (> height max_height)
			(gimp-image-crop image max_width max_height 0 offsety)
		)

		(gimp-layer-flatten layer)
		(gimp-context-pop)
		(gimp-image-undo-group-end image)
		(gimp-displays-flush)
	)
)
 
(script-fu-register "script-picture-crop-to-size"
"Crop to size"
"Crops a picture to get desired size"
"Aleksey Vyatkin"
"Aleksey Vyatkin"
"April 2018"
"RGB*,GRAY*"
SF-IMAGE "Image" 0
SF-DRAWABLE "Drawable" 0
SF-VALUE "Width" "1024"
SF-VALUE "Height" "800"
)

(script-fu-menu-register "script-picture-crop-to-size" "<Image>/Filters/Vyatkin/" )