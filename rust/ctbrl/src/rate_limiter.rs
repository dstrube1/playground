// Thread-safe manager & inline unit tests

/*
Wrap the client map in a thread-safe container. 
Using Arc<Mutex<HashMap<String, Bucket>>> is standard and straightforward
*/

use crate::bucket::Bucket;
use std::sync::{Arc, Mutex};
use std::collections::HashMap;
use crate::RateLimitError;

#[derive(Clone)]
pub struct RateLimiter {
	// why choose Mutex over lock-free atomics: simplicity and correctness under 
	// typical workloads, whereas atomics are better for high-contention 
	// primitive counters
    clients: Arc<Mutex<HashMap<String, Bucket>>>,
    default_capacity: f64,
    default_refill_rate: f64,
}

impl RateLimiter {
    pub fn new(default_capacity: f64, default_refill_rate: f64) -> Self {
        Self {
            clients: Arc::new(Mutex::new(HashMap::new())),
            default_capacity,
            default_refill_rate,
        }
    }

    pub fn acquire(&self, client_id: &str) -> Result<(), RateLimitError> {
        let mut clients = self.clients.lock().unwrap();
        
        let bucket = clients.entry(client_id.to_string()).or_insert_with(|| {
            Bucket::new(self.default_capacity, self.default_refill_rate)
        });

        bucket.check_and_consume()
    }
}

/*
Access modifiers:
pub (Public): Accessible anywhere inside the current crate, and by any external crate if it is part of your public API.

pub(crate): Public anywhere within the current crate, but hidden from external users if your crate is published as a library. This is ideal for helper modules shared internally.

pub(super): Visible only to the immediate parent module.
*/

// Concurrency Unit Tests
// test both basic functionality and multi-threaded behavior.

#[cfg(test)]
mod tests {
    use super::*;
    use std::thread;

    #[test]
    fn test_rate_limiter_basic() {
        let limiter = RateLimiter::new(2.0, 1.0); // 2 capacity, 1 token/sec
        
        // Should allow 2 requests immediately
        assert!(limiter.acquire("client_1").is_ok());
        assert!(limiter.acquire("client_1").is_ok());
        
        // 3rd request should fail
        assert!(matches!(
            limiter.acquire("client_1"),
            Err(RateLimitError::RateLimited { .. })
        ));
    }

    #[test]
    fn test_concurrent_access() {
        let limiter = Arc::new(RateLimiter::new(100.0, 10.0));
        let mut handles = vec![];

        // Spawn 10 threads hitting the same client key
        for _ in 0..10 {
            let l = Arc::clone(&limiter);
            let handle = thread::spawn(move || {
                for _ in 0..5 {
                    let _ = l.acquire("shared_client");
                }
            });
            handles.push(handle);
        }

        for handle in handles {
            handle.join().unwrap();
        }
    }
}