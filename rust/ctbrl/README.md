# Concurrent Token Bucket Rate Limiter

## Problem Statement

Design and implement a thread-safe rate limiter library in Rust using the Token Bucket algorithm. The rate limiter should support multiple clients (identified by a unique string key, such as an API key or IP address) and determine whether incoming requests should be allowed or throttled.

## Requirements

1. **Core Data Structure**: A `RateLimiter` struct that maintains state for multiple clients.
2. **Token Bucket Logic**:
* * Each client has a maximum bucket capacity ($C$) and a refill rate ($R$ tokens per second).
* * Every request consumes 1 token. If tokens are available, the request is allowed and 1 token is deducted. If not, it is rejected.
* * Tokens refill continuously (or lazily upon each request evaluation) based on elapsed time.
3. **Thread Safety**: The rate limiter must be safely shareable across multiple threads (`Send` + `Sync`) using appropriate synchronization primitives (`Arc`, `Mutex`, or `RwLock`).
4. **Configuration**: Allow configuring default capacity and refill rates, as well as client-specific overrides.
5. **Testing**: Include robust unit tests verifying concurrency safety and rate-limiting accuracy over simulated time.

## Notes

* Using a lazy-evaluation token bucket approach (avoiding background threads for better scalability

* Concurrency Model: How Arc<Mutex<...>> ensures thread safety: `TODO`

* How to Run Tests: `cargo test`

* Clean Up Before Packaging:
run `cargo clean` to remove the bulky target/ directory

* Run `cargo clippy` to ensure code is free of dead imports, redundant clones, or idiomatic style warnings
