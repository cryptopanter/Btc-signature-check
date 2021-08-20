(define-data-var message-hash (buff 32))
message-hash= generate
(define-public (signature-check (signature (buff 32)))
(ok (secp256k1-verify message-hash signature))

)
