;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; IceTF - Artisan module. (c) Kili @Icesus, 2009, 2010.
;;
;; Module for logging, carpentry, etc. artisan things.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/def -aCyellow -mregexp -t"^You find a [a-z ]+ that will yield a good trunk\\.$" icetf_tree_found

/def -aCyellow -mregexp -t"^TIMBER! The [a-z ]+ tree falls at your feet\\.$" icetf_felling_done

/def -aCyellow -mregexp -t"^At last your log is hewn into a timber\\.$" icetf_hewing_done

/def -aCyellow -mregexp -t"^At last you manage to get [0-9]+ planks from the log\\.$" icetf_sawing_done

/def -aCyellow -mregexp -t"^You have finished the [a-z ]+\\.$" icetf_build_done
