;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; IceTF - Prots module. (c) Kili @Icesus, 2009.
;;
;; Module for tracking boosts, protections, etc.etc. for current player.
;;
;; This module requires the following modules:
;;   - icetf-party.tf
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/loaded IceTF::Prots

;; Report prot Up/Down in party report channel
/set iprots_party_report=1



;; idefprot - Define Protection / Boost
;;
; /idefprot arguments:
;     -n"<text>" = Long name of boost, the one shown in "score -e" command
;     -s"<text>" = Short name of boost, use known short nickname or something unique derived from name
;     -i"<text>" = Identifier of boost to distinct between different variations of boost
;     -u"<text>" = Line of the boost up message (regexp)
;     -d"<text>" = Line of the boost down message (regexp)
;     -r"<text>" = Line of the boost recharge/replenish message (regexp)

/def idefprot = \
    /if (!getopts("n:s:i:u:d:r:", "")) /return 0 %; /endif %; \
    /if (opt_n =~ "") /echo IceTF: Error in idefprot: Missing long name (-n) %; /break %; /endif %; \
    /if (opt_s =~ "") /echo IceTF: Error in idefprot: Definition "%{opt_n}" missing short name (-s) %; /break %; /endif %; \
    /if (opt_u =~ "") /echo IceTF: Error in idefprot: Definition "%{opt_n}" missing up message (-u) %; /break %; /endif %; \
    /if (opt_d =~ "") /echo IceTF: Error in idefprot: Definition "%{opt_n}" missing down message (-d) %; /break %; /endif %; \
    /if (opt_i !~ "") \
        /let long_name %{opt_n} (%{opt_i}) %; \
        /let trig_name iprot_%{opt_s}_%{opt_i} %; \
    /else \
        /let long_name %{opt_n} %; \
        /let trig_name iprot_%{opt_s} %; \
    /endif %; \
    /eval /def -F -mregexp -t"%{opt_u}" %{trig_name}_up = \
        /substitute -p @{Cgreen}%%%{P0}@{n} (@{Cbrightblue}%{long_name} UP@{n}) %%%; \
        /set %{trig_name}_timer $[time()] %%%; \
        /if (iprots_party_report & iparty_enabled) \
            @party report %{long_name} UP %%%; \
        /endif %; \
    /eval /def -F -mregexp -t"%{opt_d}" %{trig_name}_down = \
        /if (%{trig_name}_timer =~ "") /break %%%; /endif %%%; \
        /substitute -p @{Cgreen}%%%{P0}@{n} (@{Cbrightblue}%{long_name} DOWN@{n}) %%%; \
        /if (iprots_party_report & iparty_enabled) \
            @party report %{long_name} DOWN %%%; \
        /endif %%%; \
        /unset %{trig_name}_timer %; \
    /if (opt_r !~ "") \
        /eval /def -F -mregexp -t"%{opt_r}" %{trig_name}_recharge = \
            /if (%{trig_name}_timer =~ "") /break %%%; /endif %%%; \
            /substitute -p @{Cgreen}%%%{P0}@{n} (@{Cbrightblue}%{long_name} RECHARGED@{n}) %%%; \
            /set %{trig_name}_timer $[time()] %%%; \
            /if (iprots_party_report & iparty_enabled) \
                @party report %{long_name} recharged %%%; \
            /endif %; \
    /endif



;;;
;;; Priest of Air
;;;

;; Life Boost
/idefprot -n"Life boost" \
          -s"LB" \
          -u"^You feel much safer." \
          -d"^The life boost fades, making you feel threatened."

;;;
;;; Teaching of Elements
;;;

;; Aspect of Elements (maybe also Floating effect with air?)
/idefprot -n"Aspect of elements" \
          -s"AoE" \
          -i"air" \
          -u"^You open your mouth and utter 'Adefyv Peiadc' with sound of an immense thunderstorm and instantly after that your mortal form turns into an aspect of air elemental!" \
          -d"^You turn back into your normal form." \
          -r"^You replenish elemental aspect."

/idefprot \
    -n"Gift of elements" \
    -s"GoE" \
    -i"air" \
    -u"^The essence of Pthuule fills your spirit and you feel gifted by the elements." \
    -d"^You feel a loss as gift of elements ceases to affect you."

;;;
;;; Sorcerer
;;;

;; Sphere of Protection
/idefprot -n"Sphere of protection" \
	  -s"SoP" \
	  -u"^A smoky, red-hued sphere of protection surrounds you." \
	  -d"^The sphere of protection around your body fades away."


;;;
;;; Priest of Water
;;;

/idefprot \
    -n"Thirst for knowledge" \
    -s"ToK" \
    -u"^You feel sudden thirst for new knowledge and feel a bit wiser." \
    -d"^You don't feel so interested about new things anymore."

/idefprot \
    -n"Embrace of the rimewind" \
    -s"RW" \
    -u"^Massive glacial gales heed your call and start to blow all around you, forming a deadly yet beautiful whirlwind of rime and snow capable of freezing and killing anything living passing too close to you." \
    -d"^The glacial winds howling around you settle."


;;;
;;; Gaesati Shapeshifters
;;;

;; Spectral claws
;; Pre: You touch yourself.
;; UP:
;;   Suddenly the air around your claws turns extremely chilly!
;;   Suddenly your claws burst into fire!
;;   Suddenly your claws start to crackle as lightning field surrounds them!
;;   Suddenly corrosive acid starts dripping from your claws!
;; DOWN:
;;   Your claws turn normal as your spell ends.

/idefprot \
    -n"Spectral claws" \
    -s"SC" \
    -i"cold" \
    -u"^Suddenly the air around your claws turns extremely chilly!" \
    -d"^Your claws turn normal as your spell ends."

/idefprot \
    -n"Spectral claws" \
    -s"SC" \
    -i"fire" \
    -u"^Suddenly your claws burst into fire!" \
    -d"^Your claws turn normal as your spell ends."

/idefprot \
    -n"Spectral claws" \
    -s"SC" \
    -i"lightning" \
    -u"^Suddenly your claws start to crackle as lightning field surrounds them!" \
    -d"^Your claws turn normal as your spell ends."

/idefprot \
    -n"Spectral claws" \
    -s"SC" \
    -i"acid" \
    -u"^Suddenly corrosive acid starts dripping from your claws!" \
    -d"^Your claws turn normal as your spell ends."


;; Senses of a Beast
;; Pre: You touch yourself.
;; UP:
;;   Suddenly your vision flashes for a second but then returns to normal.
;; DOWN:
;;   Your eyes tickle for a second and you notice that your abnormal senses are gone.


;; Hide of a beast
;; Pre: You touch yourself.
;; UP:
;;   Suddenly your fur turns totally silvery and thickens.


;;;
;;; Mages
;;;

;; Mirror image
;; Pre:
;;   Lume chants 'refleksns' and claps her tentacles briefly.
;; UP:
;;   Lume points at Kili and 9 mirror images appear around him.
;; DOWN:
;;   The party goes west to: All of your mirror images vanish!
;;   All of your mirror images vanish!



;; Floating effect
;; Pre:
;;   Lume chants 'da sink nat' and stamps her foot.
;; UP:
;;   You feel like you could walk on the water!


;;;
;;; Chronomancers
;;;

;; FIXME: Haste
;; Pre:
;;   Lume rubs her tentacles together and points them towards you singing 'tm zt'ag sloo'!

/idefprot \
    -n"Haste" \
    -s"Haste" \
    -u"^[A-Z][a-z]+ creates a subdimensional rift around you, speeding up the universe inside it." \
    -d"^You feel slower as the strange subdimensional rift disappears."

/idefprot \
    -n"Slow" \
    -s"Slow" \
    -u"^[A-Z][a-z]+ creates a subdimensional rift around you, slowing the universe inside it." \
    -d"^You feel faster as the strange subdimensional rift disappears."


;;;
;;; Unknown guild
;;;

/idefprot \
    -n"Inertia bubble" \
    -s"IB" \
    -u"^The air around you waves and ripples, blurring everything in your sight as an inertia bubble forms around you." \
    -d"^The inertia bubble around you dissolves."


;; FIXME: Unfold mind
;; UP:
;;   You feel Ilmaree's presence inside your mind, while he unfolds the unused parts of your mind and opens the untapped resources for your use.

