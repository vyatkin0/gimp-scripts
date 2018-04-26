;; picture-make-size -- a script for GIMP
;; Author: Aleksey Vyatkin <avyatkin@gmail.com>
;; Scales and crops a picture to get desired size

(define (script-picture-make-size image layer max_width max_height)
	(let*
		(
			(width (car (gimp-drawable-width layer)))
			(height (car (gimp-drawable-height layer)))
			(aspect (/ height width))
		)
		
		(gimp-image-undo-group-start image)
		(gimp-context-push)
		(gimp-context-set-interpolation INTERPOLATION-LANCZOS)
		
		(let*
			(
				(new_height height)
				(new_width width)
			)
			
			(if (and (< max_height height ) (< max_width width ))
				(if (< max_height (* max_width aspect) )
					(begin
						(set! new_height (* max_width aspect))
						(set! new_width max_width)
						(gimp-layer-scale layer max_width new_height TRUE)
					)
					
					(begin
						(set! new_width (/ max_height aspect))
						(set! new_height max_height)
						(gimp-layer-scale layer new_width max_height TRUE)
					)
				)
			)
			
			(gimp-image-resize-to-layers image)
			
			(let* 
				(
					(offsetx (/ (- new_width max_width) 2))
					(offsety (/ (- new_height max_height) 2))
				)
				
				(if (< max_height new_height )
					(gimp-image-crop image new_width max_height 0 offsety)
					(if (< max_width new_width )
						(gimp-image-crop image max_width new_height offsetx 0)
					)
				)
			)
		)
		
		(gimp-layer-flatten layer)
		(gimp-image-resize-to-layers image)
		(gimp-context-pop)
		(gimp-image-undo-group-end image)
		(gimp-displays-flush)
	)
)

(script-fu-register "script-picture-make-size"
"Scale and crop"
"Scales and crops a picture to get desired size"
"Aleksey Vyatkin"
"Aleksey Vyatkin"
"April 2018"
"RGB*,GRAY*"
SF-IMAGE "Image" 0
SF-DRAWABLE "Drawable" 0
SF-VALUE "Width" "520"
SF-VALUE "Height" "340"
)

(script-fu-menu-register "script-picture-make-size" "<Image>/Filters/Vyatkin/" )