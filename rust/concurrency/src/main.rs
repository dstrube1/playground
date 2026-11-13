/*
cargo new concurrency

to create this:
cargo new hello-rust

to build, from hello-rust dir:
cargo build

to make executable:
rustc [this file]

to run:
cargo run

How concurrency works using Rust’s core concurrency primitives: std::thread, 
Arc (Atomically Reference Counted pointers), and Mutex (Mutual Exclusion).

This example simulates multiple worker threads safely incrementing a shared counter 
without data races.
*/

use std::sync::{Arc, Mutex};
use std::thread;
use std::time::Duration;

fn main() {
    println!("Main thread: Starting task...");

    // 1. Wrap our shared data in a Mutex (for safe mutation) 
    //    and an Arc (for shared ownership across multiple threads).
    let counter = Arc::new(Mutex::new(0));
    let mut handles = vec![];

    // 2. Spawn 5 concurrent threads
    for i in 1..=5 {
        let counter_clone = Arc::clone(&counter);
        
        let handle = thread::spawn(move || {
            // Simulate some work taking a moment
            thread::sleep(Duration::from_millis(100 * i));

            // Acquire the lock to safely mutate the shared counter.
            // unwrap() handles the case where another thread panicked while holding the lock.
            let mut num = counter_clone.lock().unwrap();
            *num += 1;
            
            println!("Worker thread {} finished. Current count: {}", i, *num);
        });

        handles.push(handle);
    }

    // 3. Wait for all background threads to complete using .join()
    for handle in handles {
        handle.join().unwrap();
    }

    // 4. Read the final value safely
    let final_count = counter.lock().unwrap();
    println!("All threads done! Final count: {}", *final_count);
}