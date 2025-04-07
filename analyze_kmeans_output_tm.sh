#!/bin/bash


# Function to display usage
usage() {
    echo "Usage: Run the script and provide the file names when prompted."
    echo "Example:"
    echo "  Input: input.txt"
    echo "  Output: output.txt"
    exit 1
}

# Prompt the user for input and output file names
echo "Enter the input file name of kmeans:"
read input_file

echo""
echo""
echo "Note: put the output file name for tm as extracted_frame_tm.dat"
echo""
echo""

echo "Enter the output file name of kmeans:"
read output_file

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' does not exist."
    usage
fi


# Extract data for Representative Frame and Percentage
rep_frames=$(grep "Representative Frame =" "$input_file" | awk -F'=' '{print $2}' | tr -d ' ')
percentages=$(grep "Percentage =" "$input_file" | awk -F'=' '{print $3}' | tr -d ' ')

# Combine the two outputs into columns and save to the output file
paste <(echo "$rep_frames") <(echo "$percentages") > "$output_file"

echo "Numbers extracted and saved to $output_file."
echo""
echo""

cat > run.inp <<ini
frame_cv1_cv2_wt_tm_for_structure.dat
frame_cv1_cv2_wt_tm.dat
extracted_frame_tm.dat
ini


f95 Extract_Frame_CV1_CV2_For_Structure_of_Free_Energy_Profile.F90
./a.out <run.inp

rm -rf run.inp extracted_frame_tm.dat a.out
