;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; IceTF - Alchemist module. (c) Kili @Icesus, 2009.
;;
;; Module for alchemist highlights, etc.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/loaded IceTF::Alchemist


;;;
;;; Highlights
;;;

;; Herb on the ground.
/def -P1Cgreen -mregexp -t"^.{15,15} (You notice [a-z -]+ here.)" icetf_herbs

;; Create powder ready
/def -F -aCgreen -mregexp -t"After mixing and working for a while with the ingredients you manage to create [a-z ]+." ipowder_done
