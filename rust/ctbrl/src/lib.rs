// Module declarations & public re-exports

// 1. Declare the submodules in the crate
mod bucket;
mod rate_limiter;

// 2. Re-export public types so users of the library have a clean import path
pub use rate_limiter::RateLimiter;
pub use bucket::RateLimitError;