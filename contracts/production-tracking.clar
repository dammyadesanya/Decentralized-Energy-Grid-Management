;; Distribution Contract
;; Manages allocation of energy to consumers

(define-data-var admin principal tx-sender)

;; Map to store energy allocations by consumer and timestamp
(define-map energy-allocations
  { consumer: principal, timestamp: uint }
  { amount: uint, producer: principal }
)

;; Map to track total consumption by consumer
(define-map total-consumption principal uint)

;; Public function to allocate energy to a consumer
(define-public (allocate-energy (consumer principal) (amount uint) (producer principal))
  (let
    (
      (timestamp (get-block-info? time (- block-height u1)))
      (current-total (default-to u0 (map-get? total-consumption consumer)))
    )
    (begin
      (asserts! (is-eq tx-sender (var-get admin)) (err u1))
      ;; We would typically verify the consumer and producer here
      ;; by calling their respective contracts
      (match timestamp
        time-value (begin
          (map-set energy-allocations
            { consumer: consumer, timestamp: time-value }
            { amount: amount, producer: producer }
          )
          (map-set total-consumption consumer (+ current-total amount))
          (ok time-value)
        )
        (err u2)
      )
    )
  )
)

;; Read-only function to get energy allocation
(define-read-only (get-energy-allocation (consumer principal) (timestamp uint))
  (map-get? energy-allocations { consumer: consumer, timestamp: timestamp })
)

;; Read-only function to get total consumption for a consumer
(define-read-only (get-total-consumption (consumer principal))
  (default-to u0 (map-get? total-consumption consumer))
)

;; Function to transfer admin rights
(define-public (transfer-admin (new-admin principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u3))
    (ok (var-set admin new-admin))
  )
)
