(define-data-var message-hash (buff 32))
message-hash= generate
;; message should be signed back by user and put as input into below function as signature.
(define-public (signature-check (signature (buff 32)))
(ok (secp256k1-verify message-hash signature))

)
