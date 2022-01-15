(define-trait sip009-nft-trait
	(
		;; Read-only
    ;; Returns the token ID of the last NFT that was created by the contract, limited to uint range. 
    ;; Should never return an err response.
    ;; The ID can be used to iterate through the list
		(get-last-token-id () (response uint uint))

    ;; Read-only
    ;; Takes a token ID
    ;; Returns a link that resolves to metadata for an NFT
		;; Returns none if token ID does not exist
		(get-token-uri (uint) (response (optional (string-ascii 256)) uint))

    ;; Read-only
		;; Owner of a given token identifier
    ;; Returns none if token ID does not exist
		(get-owner (uint) (response (optional principal) uint))

    ;; Public
		;; Transfer from the sender to a new principal
    ;; Returns err if token ID does not exist
		(transfer (uint principal principal) (response bool uint))
	)
)
