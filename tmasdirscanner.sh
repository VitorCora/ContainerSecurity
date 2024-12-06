#!/bin/bash

# Input the path variable
# Update the folder path with the desired path to scan
folder={/path/to/images_to_scan}

cd ~
cd $folder

# Find all software image files recursively and store them in an array
files=($(find . -type f \( -iname "*.iso" -o -iname "*.tar" -o -iname "*.tar.gz" -o -iname "*.tgz" -o -iname "*.tar.bz2" -o -iname "*.tar.xz" -o -iname "*.zip" -o -iname "*.rar" -o -iname "*.7z" -o -iname "*.img" -o -iname "*.vmdk" -o -iname "*.vhd" -o -iname "*.qcow2" -o -iname "*.nrg" -o -iname "*.mds" -o -iname "*.mdf" -o -iname "*.cue" -o -iname "*.bin" -o -iname "*.dmg" -o -iname "*.udf" \)))

# Print the number of files found
echo "Found ${#files[@]} files"

# Loop through each file and run the tmas command
for file in "${files[@]}"; do
    echo "Processing $file"
    # Replace slashes with underscores for the output file name
    output_file=$(echo "$file" | tr '/' '_')
    tmas scan file:"$file" -V -vv > "scan_result_${output_file}.json"
done
