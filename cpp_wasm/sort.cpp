#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <algorithm>
#include <chrono>

// Get current time in milliseconds
uint64_t current_time_millis() {
    return std::chrono::duration_cast<std::chrono::milliseconds>(
        std::chrono::system_clock::now().time_since_epoch()
    ).count();
}

// Read entire file, sort it, and write to a new file
void sort_file_all_at_once(const std::string& input_file, const std::string& output_file) {
    std::ifstream infile(input_file);
    std::ofstream outfile(output_file);
    std::vector<std::string> lines;

    std::string line;
    while (std::getline(infile, line)) {
        lines.push_back(line);
    }

    std::sort(lines.begin(), lines.end());

    for (const auto& sorted_line : lines) {
        outfile << sorted_line << "\n";
    }
}

// Read file line-by-line, sort each line, and write sorted line immediately
void sort_file_one_at_a_time(const std::string& input_file, const std::string& output_file) {
    std::ifstream infile(input_file);
    std::ofstream outfile(output_file);

    std::string line;
    while (std::getline(infile, line)) {
        std::sort(line.begin(), line.end());
        outfile << line << "\n";
    }
}

int main() {
    // Print start time
    uint64_t start_time = current_time_millis();
    std::cout << "Main function started at: " << start_time << " ms\n";

    // Input and output file paths
    std::string input_file = "/app/input.txt";  // Adjusted path
    std::string output_file_all_at_once = "/app/output_all_at_once.txt";
    std::string output_file_one_at_a_time = "/app/output_one_at_a_time.txt";

    // Measure time for sorting entire file at once
    auto start_all_at_once = std::chrono::high_resolution_clock::now();
    sort_file_all_at_once(input_file, output_file_all_at_once);
    auto end_all_at_once = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> duration_all_at_once = end_all_at_once - start_all_at_once;
    std::cout << "Time for sorting all at once: " << duration_all_at_once.count() << " seconds\n";

    // Measure time for sorting line-by-line
    auto start_one_at_a_time = std::chrono::high_resolution_clock::now();
    sort_file_one_at_a_time(input_file, output_file_one_at_a_time);
    auto end_one_at_a_time = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> duration_one_at_a_time = end_one_at_a_time - start_one_at_a_time;
    std::cout << "Time for sorting one at a time: " << duration_one_at_a_time.count() << " seconds\n";

    return 0;
}

