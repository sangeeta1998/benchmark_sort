use std::fs::{self, File};
use std::io::{self, BufRead, BufReader, Write};
use std::time::{SystemTime, UNIX_EPOCH};

fn current_time_millis() -> u128 {
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .expect("Time went backwards")
        .as_millis()
}

// Read entire file at once, sort it, and write to a new file
fn sort_file_all_at_once(input_file: &str, output_file: &str) -> io::Result<()> {
    let content = fs::read_to_string(input_file)?;
    let mut lines: Vec<&str> = content.lines().collect();
    lines.sort_unstable();

    let mut output = File::create(output_file)?;
    for line in lines {
        writeln!(output, "{}", line)?;
    }

    Ok(())
}

// Read file line-by-line, sort each line, and write each sorted line immediately
fn sort_file_one_at_a_time(input_file: &str, output_file: &str) -> io::Result<()> {
    let input = File::open(input_file)?;
    let buffered = BufReader::new(input);
    let mut output = File::create(output_file)?;

    for line in buffered.lines() {
        let line = line?;
        let mut chars: Vec<char> = line.chars().collect();
        chars.sort_unstable();
        let sorted_line: String = chars.into_iter().collect();
        writeln!(output, "{}", sorted_line)?;
    }

    Ok(())
}

fn main() -> io::Result<()> {
    // Print the start time of the main function
    let start_time = current_time_millis();
    println!("Main function started at: {} ms", start_time);

    // Input and output file paths
    let input_file = "input.txt";
    let output_file_all_at_once = "output_all_at_once.txt";
    let output_file_one_at_a_time = "output_one_at_a_time.txt";

    // Measure sorting the whole file at once
    let start_all_at_once = std::time::Instant::now();
    sort_file_all_at_once(input_file, &output_file_all_at_once)?;
    println!("Time for sorting all at once: {:?}", start_all_at_once.elapsed());

    // Measure sorting one line at a time
    let start_one_at_a_time = std::time::Instant::now();
    sort_file_one_at_a_time(input_file, &output_file_one_at_a_time)?;
    println!("Time for sorting one at a time: {:?}", start_one_at_a_time.elapsed());

    Ok(())
}

