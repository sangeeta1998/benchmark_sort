package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"os"
	"sort"
	"strings"
	"time"
)

// Get current time in milliseconds
func currentTimeMillis() int64 {
	return time.Now().UnixNano() / int64(time.Millisecond)
}

// Read entire file at once, sort it, and write to a new file
func sortFileAllAtOnce(inputFile string, outputFile string) error {
	content, err := ioutil.ReadFile(inputFile)
	if err != nil {
		return err
	}

	lines := strings.Split(string(content), "\n")
	sort.Strings(lines)

	output, err := os.Create(outputFile)
	if err != nil {
		return err
	}
	defer output.Close()

	for _, line := range lines {
		if line != "" {
			output.WriteString(line + "\n")
		}
	}
	return nil
}

// Read file line-by-line, sort each line, and write sorted line immediately
func sortFileOneAtATime(inputFile string, outputFile string) error {
	input, err := os.Open(inputFile)
	if err != nil {
		return err
	}
	defer input.Close()

	output, err := os.Create(outputFile)
	if err != nil {
		return err
	}
	defer output.Close()

	scanner := bufio.NewScanner(input)
	for scanner.Scan() {
		line := scanner.Text()
		chars := strings.Split(line, "")
		sort.Strings(chars)
		output.WriteString(strings.Join(chars, "") + "\n")
	}

	if err := scanner.Err(); err != nil {
		return err
	}

	return nil
}

func main() {
    // Print the start time of the main function
    startTime := currentTimeMillis()
    fmt.Printf("Main function started at: %d ms\n", startTime)

    // Input and output file paths
    inputFile := "/app/input.txt"  // Adjusted path
    outputFileAllAtOnce := "/app/output_all_at_once.txt"
    outputFileOneAtATime := "/app/output_one_at_a_time.txt"

    // Measure sorting the whole file at once
    startAllAtOnce := time.Now()
    err := sortFileAllAtOnce(inputFile, outputFileAllAtOnce)
    if err != nil {
        fmt.Println("Error sorting all at once:", err)
    }
    fmt.Printf("Time for sorting all at once: %v\n", time.Since(startAllAtOnce))

    // Measure sorting one line at a time
    startOneAtATime := time.Now()
    err = sortFileOneAtATime(inputFile, outputFileOneAtATime)
    if err != nil {
        fmt.Println("Error sorting one at a time:", err)
    }
    fmt.Printf("Time for sorting one at a time: %v\n", time.Since(startOneAtATime))
}

