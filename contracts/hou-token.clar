(impl-trait .sip009-nft-trait.sip009-nft-trait)

;; SIP009 NFT trait on mainnet
;; (impl-trait 'SP2PABAF9FTAJYNFZH93XENAJ8FVY99RRM50D2JG9.nft-trait.nft-trait)

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))

(define-non-fungible-token hou-token uint)

(define-data-var last-token-id uint u0)

(define-read-only (get-last-token-id)
	(ok (var-get last-token-id))
)

(define-read-only (get-token-uri (token-id uint))
	(ok none)
)

;; Something like the following is impossible because there is no to-ascii 
;; function to turn a number into an ASCII string type.
;; (concat "https://domain.tld/metadata/" (to-ascii token-id))

;; The get-owner function only has to wrap the built-in nft-get-owner?.
(define-read-only (get-owner (token-id uint))
	(ok (nft-get-owner? hou-token token-id))
)

(define-public (transfer (token-id uint) (sender principal) (recipient principal))
	(begin
		(asserts! (is-eq tx-sender sender) err-not-token-owner)
		(nft-transfer? hou-token token-id sender recipient)
	)
)

(define-public (mint (recipient principal))
	(let
		(
			(token-id (+ (var-get last-token-id) u1)) ;; increment last token id
		)
		(asserts! (is-eq tx-sender contract-owner) err-owner-only) ;; only contract owners can mint
		(try! (nft-mint? hou-token token-id recipient))
		(var-set last-token-id token-id)
		(ok token-id)
	)
)
