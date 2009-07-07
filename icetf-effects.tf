;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; IceTF - Special Effects module. (c) Kili @Icesus, 2009.
;;
;; Module for tracking special effects for current player. This module
;; should contain everything which can be seen with "score -e" command.
;;
;; This module requires the following modules:
;;   - icetf.tf
;;   - icetf-party.tf
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/loaded IceTF::Effects

;; Report effect Up/Down in party report channel
/set ieffects_party_report=1


;; idefeffect - Effect
;;
; /idefeffect arguments:
;     -n"<text>" = Long name of effect, the one shown in "score -e" command
;     -s"<text>" = Short name of effect, use known short nickname or something unique derived from name
;     -i"<text>" = Identifier of effect to distinct between different variations of effect
;     -u"<text>" = Line of the effect up message (regexp)
;     -d"<text>" = Line of the effect down message (regexp)
;     -r"<text>" = Line of the effect recharge/replenish message (regexp)

/def idefeffect = \
    /if (!getopts("n:s:i:u:d:r:", "")) /return 0 %; /endif %; \
    /if (opt_n =~ "") /echo IceTF: Error in idefeffect: Missing long name (-n) %; /break %; /endif %; \
    /if (opt_s =~ "") /echo IceTF: Error in idefeffect: Definition "%{opt_n}" missing short name (-s) %; /break %; /endif %; \
    /if (opt_u =~ "") /echo IceTF: Error in idefeffect: Definition "%{opt_n}" missing up message (-u) %; /break %; /endif %; \
    /if (opt_d =~ "") /echo IceTF: Error in idefeffect: Definition "%{opt_n}" missing down message (-d) %; /break %; /endif %; \
    /if (opt_i !~ "") \
        /let long_name %{opt_n} (%{opt_i}) %; \
        /let trig_name ieffect_%{opt_s}_%{opt_i} %; \
    /else \
        /let long_name %{opt_n} %; \
        /let trig_name ieffect_%{opt_s} %; \
    /endif %; \
    /eval /def -F -mregexp -t"%{opt_u}" %{trig_name}_up = \
        /substitute -p @{Cgreen}%%%{P0}@{n} (@{Cbrightblue}%{long_name} UP@{n}) %%%; \
        /set %{trig_name}_timer $$$[time()] %%%; \
        /if (ieffects_party_report & istatus_party) \
            @party report %{long_name} UP %%%; \
        /endif %; \
    /eval /def -F -mregexp -t"%{opt_d}" %{trig_name}_down = \
        /if (%{trig_name}_timer =~ "") /break %%%; /endif %%%; \
        /substitute -p @{Cgreen}%%%{P0}@{n} (@{Cbrightblue}%{long_name} DOWN@{n}) %%%; \
        /if (ieffects_party_report & istatus_party) \
            @party report %{long_name} DOWN %%%; \
        /endif %%%; \
        /unset %{trig_name}_timer %; \
    /eval /def -F -mregexp -t"^ %{opt_n}" %{trig_name}_score_e = \
        /if (%{trig_name}_timer =~ "") \
            /set %{trig_name}_timer $$$[time()] %%%; \
        /else \
            /test substitute("%%%{P0}", "", 1) %%%; \
        /endif %; \
    /if (opt_r !~ "") \
        /eval /def -F -mregexp -t"%{opt_r}" %{trig_name}_recharge = \
            /if (%{trig_name}_timer =~ "") /break %%%; /endif %%%; \
            /substitute -p @{Cgreen}%%%{P0}@{n} (@{Cbrightblue}%{long_name} RECHARGED@{n}) %%%; \
            /set %{trig_name}_timer $$$[time()] %%%; \
            /if (ieffects_party_report & istatus_party) \
                @party report %{long_name} recharged %%%; \
            /endif %; \
    /endif


;;;
;;; Priest of Air
;;;

;; Life Boost
/idefeffect \
    -n"Life boost" \
    -s"LB" \
    -u"^You feel (much |)safer." \
    -d"^The life boost fades, making you feel threatened."


;;;
;;; Teaching of Elements
;;;

;; Aspect of Elements (maybe also Floating effect with air?)
/idefeffect \
    -n"Aspect of elements" \
    -s"AoE" \
    -i"air" \
    -u"^You open your mouth and utter 'Adefyv Peiadc' with sound of an immense thunderstorm and instantly after that your mortal form turns into an aspect of air elemental!" \
    -d"^You turn back into your normal form." \
    -r"^You replenish elemental aspect."

/idefeffect \
    -n"Gift of elements" \
    -s"GoE" \
    -i"air" \
    -u"^The essence of Pthuule fills your spirit and you feel gifted by the elements." \
    -d"^You feel a loss as gift of elements ceases to affect you."


;;;
;;; Sorcerer
;;;

/idefeffect \
    -n"Sphere of protection" \
    -s"SoP" \
    -u"^A smoky, red-hued sphere of protection surrounds you." \
    -d"^The sphere of protection around your body fades away."

;; PRE: Dracu makes a circling motion with the scepter and intones 'racheace che hazor'.
/idefeffect \
    -n"Sphere of warding" \
    -s"SoW" \
    -u"^A crystal-clear sphere of warding surrounds you." \
    -d"^The sphere of warding around you fades away." \
    -r"^Your sphere of warding glimmers a second as [A-Z][a-z]+ replenishes it."


;;;
;;; Priest of Water
;;;

/idefeffect \
    -n"Thirst for knowledge" \
    -s"ToK" \
    -u"^You feel sudden thirst for new knowledge and feel a bit wiser." \
    -d"^You don't feel so interested about new things anymore."

/idefeffect \
    -n"Embrace of the rimewind" \
    -s"RW" \
    -u"^Massive glacial gales heed your call and start to blow all around you, forming a deadly yet beautiful whirlwind of rime and snow capable of freezing and killing anything living passing too close to you." \
    -d"^The glacial winds howling around you settle."


;;;
;;; Gaesati Shapeshifters
;;;

;; Spectral claws
;; Pre: You touch yourself.
/idefeffect \
    -n"Spectral claws" \
    -s"SC" \
    -i"cold" \
    -u"^Suddenly the air around your claws turns extremely chilly!" \
    -d"^Your claws turn normal as your spell ends."

/idefeffect \
    -n"Spectral claws" \
    -s"SC" \
    -i"fire" \
    -u"^Suddenly your claws burst into fire!" \
    -d"^Your claws turn normal as your spell ends."

/idefeffect \
    -n"Spectral claws" \
    -s"SC" \
    -i"lightning" \
    -u"^Suddenly your claws start to crackle as lightning field surrounds them!" \
    -d"^Your claws turn normal as your spell ends."

/idefeffect \
    -n"Spectral claws" \
    -s"SC" \
    -i"acid" \
    -u"^Suddenly corrosive acid starts dripping from your claws!" \
    -d"^Your claws turn normal as your spell ends."

;; Senses of a Beast
;; Pre: You touch yourself.
/idefeffect \
    -n"Senses of a beast" \
    -s"SoB" \
    -u"^Suddenly your vision flashes for a second but then returns to normal." \
    -d"^Your eyes tickle for a second and you notice that your abnormal senses are gone."


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

/idefeffect \
    -n"Haste" \
    -s"Haste" \
    -u"^[A-Z][a-z]+ creates a subdimensional rift around you, speeding up the universe inside it." \
    -d"^You feel slower as the strange subdimensional rift disappears."

/idefeffect \
    -n"Slow" \
    -s"Slow" \
    -u"^[A-Z][a-z]+ creates a subdimensional rift around you, slowing the universe inside it." \
    -d"^You feel faster as the strange subdimensional rift disappears."


;;;
;;; Unknown guild
;;;

/idefeffect \
    -n"Inertia bubble" \
    -s"IB" \
    -u"^The air around you waves and ripples, blurring everything in your sight as an inertia bubble forms around you." \
    -d"^The inertia bubble around you dissolves."

/idefeffect \
    -n"Shadow barrier" \
    -s"SB" \
    -u"^As [A-Z][a-z]+ finishes the chant, shadows jump from the darkness forming a barrier around you!" \
    -d"^The shadow barrier around you fades into nothingness."


;; FIXME: Unfold mind
;; UP:
;;   You feel Ilmaree's presence inside your mind, while he unfolds the unused parts of your mind and opens the untapped resources for your use.


;;;
;;; No effects
;;;
;; From score -e: No visible effects affect you.
