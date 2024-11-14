#!/bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

echo "$($PSQL "TRUNCATE TABLE games, teams;")"

function insert_rows {
  local team_name=$1;
  local team_id=$($PSQL "SELECT team_id FROM teams WHERE name='$team_name'")
  if [[ -z $team_id ]];then
      # team not present add it to teams table
      local placeholder=$($PSQL "INSERT INTO teams(name) VALUES('$team_name')");
      # return the team_id that was inserted to the table
      team_id=$($PSQL "SELECT team_id FROM teams WHERE name='$team_name'")
  fi
    echo "$team_id"
}

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOAL OPPONENT_GOAL
do
	if [[ $YEAR != 'year' ]]; then
    WINNER_TEAM_ID=$(insert_rows "$WINNER")
    OPPONENT_TEAM_ID=$(insert_rows "$OPPONENT")
    INSERT_INTO_GAMES=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id, winner_goals, opponent_goals) VALUES( $YEAR, '$ROUND', $WINNER_TEAM_ID, $OPPONENT_TEAM_ID, $WINNER_GOAL, $OPPONENT_GOAL)")
    echo "$INSERT_INTO_GAMES"  
  fi
done

