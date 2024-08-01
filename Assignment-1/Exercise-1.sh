#!/bin/bash

# Define the paths
DIFF_FILE="file_diff.txt"
ADDED_FILE="added.txt"
REMOVED_FILE="removed.txt"
DEPLOY_PACKAGE_DIR="deployPackage"
ADDED_DIR="${DEPLOY_PACKAGE_DIR}/added"
REMOVED_DIR="${DEPLOY_PACKAGE_DIR}/removed"

# Create necessary directories if they don't exist
mkdir -p "${ADDED_DIR}"
mkdir -p "${REMOVED_DIR}"

# Clear previous content of added.txt and removed.txt
> "${ADDED_FILE}"
> "${REMOVED_FILE}"

# Process the diff file line by line
while IFS= read -r line || [ -n "$line" ];
do
status=`echo "$line" | awk '{print $1;}'`
if [[ "$status" == "M" || "$status" == "A" ]]; then
    echo "$status"
    filename_with_ext=$(basename "$line")
    filename="${filename_with_ext%.*}"
    echo "$filename_with_ext" >> "${ADDED_FILE}"
elif [[ "$status" == "R" || "$status" == "D" ]]; then
    filename_with_ext=$(basename "$line")
    filename="${filename_with_ext%.*}"
    echo "$filename_with_ext"   >> "${REMOVED_FILE}"
fi   
done < "$DIFF_FILE"

mv -f "${ADDED_FILE}" "${ADDED_DIR}"
mv -f "${REMOVED_FILE}" "${REMOVED_DIR}"

echo "Processing complete! Check $ADDED_FILE and $REMOVED_FILE for details."

