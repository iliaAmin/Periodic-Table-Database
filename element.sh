!#bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

# Check if argument is provided
if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
  exit
fi

# Query for element by atomic_number, symbol, or name

ELEMENT_INFO=$($PSQL "
  SELECT atomic_number, name, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius, type
  FROM elements
  JOIN properties USING(atomic_number)
  JOIN types USING(type_id)
  WHERE atomic_number::TEXT = '$1'
     OR symbol = INITCAP('$1')
     OR name = INITCAP('$1');
")

