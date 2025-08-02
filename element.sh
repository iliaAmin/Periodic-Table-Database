!#bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

# Check if argument is provided
if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
  exit
fi

