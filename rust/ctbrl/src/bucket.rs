// Token bucket logic & inline unit tests

//use std::collections::HashMap;
//use std::sync::{Arc, Mutex};
use std::time::{Duration, Instant};

/*
Custom errors and the internal state of a single bucket. Lazy evaluation of token refill 
(calculating tokens based on the time elapsed since the last check) is more efficient 
than running a background thread for every client.
*/

#[derive(Debug, PartialEq)]
pub enum RateLimitError {
    RateLimited { retry_after: Duration },
}

pub struct Bucket {
    tokens: f64,
    capacity: f64,
    refill_rate: f64, // tokens per second
    last_update: Instant,
}

impl Bucket {
    pub fn new(capacity: f64, refill_rate: f64) -> Self {
        Self {
            tokens: capacity,
            capacity,
            refill_rate,
            last_update: Instant::now(),
        }
    }

    pub fn check_and_consume(&mut self) -> Result<(), RateLimitError> {
        let now = Instant::now();
        let elapsed = now.duration_since(self.last_update).as_secs_f64();
        self.last_update = now;

        // Refill tokens based on elapsed time
        self.tokens = (self.tokens + elapsed * self.refill_rate).min(self.capacity);

        if self.tokens >= 1.0 {
            self.tokens -= 1.0;
            Ok(())
        } else {
            // Calculate how long to wait for 1 token
            let deficit = 1.0 - self.tokens;
            let wait_secs = deficit / self.refill_rate;
            Err(RateLimitError::RateLimited {
// Handle Errors Idiomatically: Avoid .unwrap() in production code paths (except 
// inside locked mutexes where poisoning is handled or acceptable for tests).
// Use custom enum error types.
                retry_after: Duration::from_secs_f64(wait_secs),
            })
        }
    }
}