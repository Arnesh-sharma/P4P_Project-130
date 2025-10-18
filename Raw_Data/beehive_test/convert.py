import csv
import re
import sys

def convert_to_csv(input_file, output_file):
    # Regex to capture d0–d5 values like "d0=123.4" or "d0: 123.4"
    pattern = re.compile(r'd(\d)\s*[:=]\s*([-+]?\d*\.?\d+(?:[eE][-+]?\d+)?)')

    with open(input_file, 'r', encoding='utf-8', errors='ignore') as infile, \
         open(output_file, 'w', newline='') as outfile:
        
        writer = csv.writer(outfile)
        header = [f"d{i}" for i in range(6)]
        writer.writerow(header)

        for line in infile:
            matches = pattern.findall(line)
            if matches:
                row = {f"d{i}": "" for i in range(6)} 
                for idx, val in matches:
                    row[f"d{idx}"] = val
                writer.writerow([row[f"d{i}"] for i in range(6)])

    print(f"Conversion complete: {output_file}")

if __name__ == "__main__":
    # Example usage:
    # python convert_to_csv.py beetest_5 beetest_5_output.csv
    if len(sys.argv) != 3:
        print("Usage: python convert.py <input_file> <output_file>")
    else:
        convert_to_csv(sys.argv[1], sys.argv[2])
