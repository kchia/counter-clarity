(impl-trait .sip010-ft-trait.sip010-ft-trait)

;; SIP010 trait on mainnet
;; (impl-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))

;; No maximum supply!
(define-fungible-token clarity-coin)

(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
	(begin
		(asserts! (is-eq tx-sender sender) err-owner-only)
		(try! (ft-transfer? clarity-coin amount sender recipient)) 
		(match memo to-print (print to-print) 0x) ;; Unwrap and print the memo if it is not none. Use match to conditionally call print if the passed memo is a some.
		(ok true)
	)
)

(define-read-only (get-name)
	(ok "Clarity Coin")
)

(define-read-only (get-symbol)
	(ok "CC")
)

(define-read-only (get-decimals)
	(ok u6)
)

(define-read-only (get-balance (who principal))
	(ok (ft-get-balance clarity-coin who)) ;; Simply wrap the built-in function that retrieves the balance.
)

(define-read-only (get-total-supply)
	(ok (ft-get-supply clarity-coin))
)

(define-read-only (get-token-uri)
	(ok none)
)

(define-public (mint (amount uint) (recipient principal))
	(begin
		(asserts! (is-eq tx-sender contract-owner) err-owner-only)
		(ft-mint? clarity-coin amount recipient)
	)
)