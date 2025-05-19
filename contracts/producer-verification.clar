;; Producer Verification Contract
;; Validates energy generators on the grid

(define-data-var admin principal tx-sender)

;; Map to store verified producers
(define-map verified-producers principal
  {
    name: (string-utf8 100),
    capacity: uint,
    location: (string-utf8 100),
    verified: bool
  }
)

;; Public function to register a new producer (only admin can verify)
(define-public (register-producer (name (string-utf8 100)) (capacity uint) (location (string-utf8 100)))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u1))
    (ok (map-set verified-producers tx-sender
      {
        name: name,
        capacity: capacity,
        location: location,
        verified: false
      }
    ))
  )
)

;; Public function to verify a producer
(define-public (verify-producer (producer principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u2))
    (match (map-get? verified-producers producer)
      producer-data (ok (map-set verified-producers producer
                        (merge producer-data {verified: true})))
      (err u3)
    )
  )
)

;; Read-only function to check if a producer is verified
(define-read-only (is-verified-producer (producer principal))
  (match (map-get? verified-producers producer)
    producer-data (get verified producer-data)
    false
  )
)

;; Read-only function to get producer details
(define-read-only (get-producer-details (producer principal))
  (map-get? verified-producers producer)
)

;; Function to transfer admin rights
(define-public (transfer-admin (new-admin principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u4))
    (ok (var-set admin new-admin))
  )
)
