;; Consumer Identity Contract
;; Manages energy user profiles

(define-data-var admin principal tx-sender)

;; Map to store consumer profiles
(define-map consumers principal
  {
    name: (string-utf8 100),
    location: (string-utf8 100),
    max-consumption: uint,
    active: bool
  }
)

;; Public function to register a new consumer
(define-public (register-consumer (name (string-utf8 100)) (location (string-utf8 100)) (max-consumption uint))
  (ok (map-set consumers tx-sender
    {
      name: name,
      location: location,
      max-consumption: max-consumption,
      active: true
    }
  ))
)

;; Public function to update consumer profile
(define-public (update-consumer (name (string-utf8 100)) (location (string-utf8 100)) (max-consumption uint))
  (begin
    (asserts! (is-some (map-get? consumers tx-sender)) (err u1))
    (ok (map-set consumers tx-sender
      {
        name: name,
        location: location,
        max-consumption: max-consumption,
        active: true
      }
    ))
  )
)

;; Admin function to deactivate a consumer
(define-public (deactivate-consumer (consumer principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u2))
    (match (map-get? consumers consumer)
      consumer-data (ok (map-set consumers consumer
                        (merge consumer-data {active: false})))
      (err u3)
    )
  )
)

;; Admin function to reactivate a consumer
(define-public (reactivate-consumer (consumer principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u2))
    (match (map-get? consumers consumer)
      consumer-data (ok (map-set consumers consumer
                        (merge consumer-data {active: true})))
      (err u3)
    )
  )
)

;; Read-only function to check if a consumer is active
(define-read-only (is-active-consumer (consumer principal))
  (match (map-get? consumers consumer)
    consumer-data (get active consumer-data)
    false
  )
)

;; Read-only function to get consumer details
(define-read-only (get-consumer-details (consumer principal))
  (map-get? consumers consumer)
)

;; Function to transfer admin rights
(define-public (transfer-admin (new-admin principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u4))
    (ok (var-set admin new-admin))
  )
)
