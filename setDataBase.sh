#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=postgres -t --no-align -c"
# CREATE_DATABASE=$($PSQL "CREATE DATABASE worldcup")
# echo $CREATE_DATABASE
PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
CREATE_TABLE=$($PSQL "CREATE TABLE IF NOT EXISTS teams( team_id SERIAL PRIMARY KEY,
name VARCHAR NOT NULL UNIQUE )")
echo $CREATE_TABLE
CREATE_TABLE=$($PSQL "CREATE TABLE IF NOT EXISTS games( game_id SERIAL PRIMARY KEY,
year INT NOT NULL,
round VARCHAR NOT NULL,
winner_id INT NOT NULL REFERENCES teams(team_id),
opponent_id INT NOT NULL REFERENCES teams(team_id),
winner_goals INT NOT NULL,
opponent_goals INT NOT NULL)")
echo $CREATE_TABLE

