;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; IceTF - Party module. (c) Kili @Icesus, 2009.
;;
;; Module for everything related to partying.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/loaded IceTF::Party

;; This is 1 if we are in a party, 0 if we are not
/set iparty_enabled=0


;;;
;;; Party join, create, leave, kicked out, etc. state triggers
;;;

;; We created a new party, enable party stuff
/def -F -t"You form a party called *" iparty_created = \
     /set iparty_enabled=1

;; We (or someone else) joins a party, enable party stuff
/def -F -mregexp -t"^[A-Z][a-z]+ steps to position [1-3],[1-3] and starts following the leader." iparty_join = \
     /set iparty_enabled=1

;; Left a party, disable party stuff
/def -F -t"You leave the party." iparty_leave = \
     /set iparty_enabled=0

;; We got kicked out from party, disable party stuff
/def -F -t"You have been kicked out from party." iparty_kicked = \
     /set iparty_enabled=0

;; We are not in party, disable party stuff
/def -F -t"But you are not in a party" iparty_off = \
     /set iparty_enabled=0

