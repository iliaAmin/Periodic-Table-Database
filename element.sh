#!/bin/bash

# Check if an argument was provided
if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
  exit
fi

# Run the query and capture the result
RESULT=$(psql --username=freecodecamp --dbname=periodic_table -t --no-align -c "
  SELECT atomic_number, name, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius, type
  FROM elements
  JOIN properties USING(atomic_number)
  JOIN types USING(type_id)
  WHERE atomic_number::TEXT = '$1'
     OR LOWER(symbol) = LOWER('$1')
     OR LOWER(name) = LOWER('$1');
")

# Check if the query returned anything
if [[ -z $RESULT ]]; then
  echo "I could not find that element in the database."
else
  # Parse and format the result
  IFS="|" read -r ATOMIC_NUMBER NAME SYMBOL MASS MELTING BOILING TYPE <<< "$RESULT"
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
fi
