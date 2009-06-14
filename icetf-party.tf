;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; IceTF - Party module. (c) Kili @Icesus, 2009.
;;
;; Module for everything related to partying.
;;
;; This module requires the following modules:
;;   - icetf.tf
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/loaded IceTF::Party

;;;
;;; Party join, create, leave, kicked out, etc. state triggers
;;;

;; We created a new party, enable party stuff
/def -F -t"You form a party called *" iparty_created = \
     /set istatus_party=1

;; We (or someone else) joins a party, enable party stuff
/def -F -mregexp -t"^[A-Z][a-z]+ steps to position [1-3],[1-3] and starts following the leader." iparty_join = \
     /set istatus_party=1

;; Left a party, disable party stuff
/def -F -t"You leave the party." iparty_leave = \
     /set istatus_party=0

;; We got kicked out from party, disable party stuff
/def -F -t"You have been kicked out from party." iparty_kicked = \
     /set istatus_party=0

;; We are not in party, disable party stuff
/def -F -t"But you are not in a party" iparty_off = \
     /set istatus_party=0

;; We are already in party and someone tries to invite to another party
/def -F -aCgreen -mregexp -t"^[A-Z][a-z]+ invites you to a party but you are already in one." iparty_already \
     /set istatus_party=1
