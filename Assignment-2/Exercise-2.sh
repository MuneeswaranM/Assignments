#!/bin/bash

# Check for 6 arguments
if [ $# -ne 6 ]; then
  echo "Usage: $0 <number1> <number2> <number3> <number4> <number5> <number6>"
  exit 1
fi

# Read numbers as integers
numbers=("$@")

# Menu options
echo "Choose an operation:"
echo "1. Perform subtraction (comma separated)"
echo "2. Perform multiplication (store result in JSON file)"
echo "3. Pick a random number"
echo "4. Print sorted (highest to lowest)"
echo "5. Print sorted (lowest to highest)"

read -p "Enter your choice (1-5): " choice

case $choice in
  1)
#    result=$(echo "${numbers[@]:1}" | tr ' ' '-' | bc)
    for ((i=1; i<${#numbers[@]}; i++)); do
        result[i-1]=$((${numbers[i-1]} - ${numbers[i]}))
            done
    echo "$result"
    ;;
  2)
   multiplication=$((${numbers[0]} * ${numbers[1]} * ${numbers[2]} * ${numbers[3]} * ${numbers[4]} * ${numbers[5]}))
    json_data='{'
    for ((i=0; i<6; i++)); do
    json_data+='"InputNumber'$(($i+1))': '${numbers[$i]}','
    done
    json_data="${json_data%?},"  # Remove trailing comma
    json_data+='"Multiplication": '$multiplication'}'
    echo "$json_data" > result.json
    echo "Result saved to result.json"
    ;;
  3)
    echo "${numbers[@]}" | tr ' ' '\n' | shuf -n1
    ;;
  4)
    echo "${numbers[@]}" | tr ' ' '\n' | sort -nr
    ;;
  5)
    echo "${numbers[@]}" | tr ' ' '\n' | sort
    ;;
  *)
    echo "Invalid choice"
    ;;
esac