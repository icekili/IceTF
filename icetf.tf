;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; IceTF - Main module. (c) Kili @Icesus, 2009, 2010.
;;
;; Module for common stuff, tracking things, etc.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/loaded IceTF::Main


;;;
;;; Different statuses
;;;

;; Sleeping. 0=off, 1=on
/set istatus_sleep 0

;; Meditation. 0=off, 1=on
/set istatus_meditation 0

;; Stun. 0=off, 1=on
/set istatus_stun 0

;; Party. 0=no party, 1=in party.
/set istatus_party 0

;; Nether effect. 0=no, 1=yes
/set istatus_nether 0

;; Magical weakness. 0=no, 1=yes
/set istatus_mweakness 0

;; Casting a spell. 0=no, 1=yes
/set istatus_casting 0

;; Poisoned. 0=no, 1=yes
/set istatus_poison 0

;; Wounded. 0=no, 1=yes
/set istatus_wound 0

;; Rite of Success. 0=no, 1=yes
/set istatus_riteofsuccess 0

;;;
;;; Triggers for different statuses
;;;

;; Sleep UP
/def -F -t"You lie down for a short nap." isleep_on = \
    /set istatus_sleep=1

/def -F -t"You open your sleeping bag and lie down in it for a short nap." isleep_bag_on = \
    /set istatus_sleep=1

/def -F -t"You cannot do that while sleeping!" isleep_ongoing = \
    /set istatus_sleep=1

;; Sleep DOWN
/def -F -mregexp -t"^You wake up, feeling healed and (very |)refreshed." isleep_off = \
    /set istatus_sleep=0

/def -F -t"You aren't tired enough." isleep_not_tired = \
    /set istatus_sleep=0

/def -F -t"You are too busy to sleep." isleep_too_busy = \
    /set istatus_sleep=0


;; Meditation UP
/def -F -t"You start to clear your mind from doubts and thoughts, and begin meditating." imeditation_on = \
    /set istatus_meditation=1

;; Meditation ongoing
/def -F -t"You are meditating and unable to do that. Type 'end meditation' to stop meditating." imeditation_going = \
    /set istatus_meditation=1

;; Meditation DOWN
/def -F -t"As your spell points have been fully restored, you end your meditation."  imeditation_full_sp = \
    /set istatus_meditation=0

/def -F -t"You open your eyes and stand up." imeditation_off = \
    /set istatus_meditation=0

/def -F -t"The violent breaking of your meditation causes you to reel in confusion!" imeditation_off_stun_on = \
    /set istatus_meditation=0 %; \
    /set istatus_stun=1


;; Stun UP
/def -F -t"You get STUNNED from massive pain." istun_on = \
    /set istatus_stun=1

;; Stun UP, Casting DOWN
/def -F -t"You are unable to cast any spells while stunned." istun_on_casting_off = \
    /set istatus_stun=1 %; \
    /set istatus_casting=0

;; Stun DOWN
/def -F -t"You feel better as your head stops spinning." istun_off = \
    /set istatus_stun=0


;; Nether effect UP
/def -F -t"You have a strange feeling." inether_on = \
    /set istatus_nether=1

;; Nether effect found from score
/def -F -T" You are suffering from nether world effects." inether_from_score = \
    /set istatus_nether=1

;; Nether effect DOWN
/def -F -t"You have recovered from the nether world effects." inether_off = \
    /set istatus_nether=0


;; Magical weakness UP
/def -F -t"As your magical powers fade away, you feel weak." imweakness_on = \
    /set istatus_mweakness=1

;; Magical weakness DOWN
/def -F -t"You regain your strength with your mental power." imweakness_off = \
    /set istatus_mweakness=0


;; Casting spell
/def -F -t"You start concentrating on a spell." icasting_on = \
    /set istatus_casting=1

/def -F -t"You abort your spellcasting ritual to start a new one." icasting_new = \
    /set istatus_casting=1

/def -F -t"You are not concentrating on anything at this moment." icasting_nothing = \
    /set istatus_casting=0

/def -F -t"You don't have enough spell points to complete the spell!" icasting_nosp = \
    /set istatus_casting=0

;; Casting done
/def -F -t"You are prepared to release the spell." icasting_off = \
    /set istatus_casting=0

;; Casting off because movement
/def -F -t"Your movement forces you to stop concentrating on the spell." icasting_off2 = \
    /set istatus_casting=0

/def -F -t"You lost your concentration on your spell!" icasting_off3 = \
    /set istatus_casting=0


; Rite of Success
/def -F -t"You succeed in clearing your mind of worldly concerns." iroteofsuccess_on = \
     /set istatus_riteofsuccess=1

/def -F -t"You feel like a strange force is helping you to cast the spell." iriteofsuccess_off = \
     /set istatus_riteofsuccess=0

/def -F -t"You fail in clearing your mind of worldly concerns." iriteofsuccess_fail
