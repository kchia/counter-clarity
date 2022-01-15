(define-trait sip010-ft-trait
  (
    ;; Public
    ;; Transfer from the caller to a new principal
    ;; If the balance is insufficient, then it must return an err response. 
    ;; The transfer may optionally include a memo which is to be emitted using print. 
    ;; Memos are useful for off-chain indexers and apps like exchanges. If a memo is present, it should be unwrapped and emitted after the token transfer.
    (transfer (uint principal principal (optional (buff 34))) (response bool uint))

    ;; Read-only
    ;; The human readable name of the token
    ;; The name may be used in other contracts or off-chain apps.
    (get-name () (response (string-ascii 32) uint))

    ;; Read-only
    ;; the ticker symbol, or empty if none
    (get-symbol () (response (string-ascii 32) uint))

    ;; Read-only
    ;; the number of decimals used, e.g. 6 would mean 1_000_000 represents 1 token
    (get-decimals () (response uint uint))

    ;; Read-only
    ;; the balance of the passed principal
    (get-balance (principal) (response uint uint))

    ;; Read-only
    ;; the current total supply (which does not need to be a constant)
    (get-total-supply () (response uint uint))

    ;; Read-only
    ;; an optional URI that represents metadata of this token
    (get-token-uri () (response (optional (string-utf8 256)) uint))
    )
  )