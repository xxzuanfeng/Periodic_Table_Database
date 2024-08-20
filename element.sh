#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
fi

ARRAY_NUMBER=(1 2 3 4 5 6 7 8 9 10)
ARRAY_SYMBOL=(H He Li Be B C N O F Ne)
ARRAY_NAME=(Hydrogen Helium Lithium Beryllium Boron Carbon Nitrogen Oxygen Fluorine Neon)
VAR=$1
if [[ ${ARRAY_NUMBER[@]/${VAR}/} != ${ARRAY_NUMBER[@]} ]]
then
  ATOMIC_NUMBER=$1
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number='$ATOMIC_NUMBER';") 
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number='$ATOMIC_NUMBER'")
  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")
  MELTING_POINT_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")
  BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")
  TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")
  TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
elif [[ ${ARRAY_SYMBOL[@]/${VAR}/} != ${ARRAY_SYMBOL[@]} ]]
then
  SYMBOL=$1
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$SYMBOL'")
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number='$ATOMIC_NUMBER'")
  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")
  MELTING_POINT_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")
  BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")
  TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")
  TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
elif [[ ${ARRAY_NAME[@]/${VAR}/} != ${ARRAY_NAME[@]} ]]
then
  NAME=$1
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$NAME'")
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number='$ATOMIC_NUMBER';") 
  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")
  MELTING_POINT_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")
  BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")
  TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")
  TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")  
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
elif [[ $1 ]]
then
  echo "I could not find that element in the database."
fi