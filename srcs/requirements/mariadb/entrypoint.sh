#!/bin/bash

# check is /var/lib/mysql empty
if [ -z "$( ls -A '/var/lib/mysql' )" ]; then
	mariadbd <<EOF
	CREATE DATABASE db_test;
	CREATE TABLE users (
		userID int AUTO_INCREMENT PRIMARY KEY,
		username varchar(255) NOT NULL
	);
	INSERT INTO users
	VALUES ("user1");
	EOF
else
	# not empty
fi
