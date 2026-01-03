#!/bin/bash
set -e

read -p "Enter your project title (eg. 'My Gallery'): " project_title
sed --in-place "s|Galleri Demo|${project_title}|" composer.json
sed --in-place "s|Galleri Demo|${project_title}|" README.md

read -p "Enter your project name (eg. 'username/project-name'): " project_name
sed --in-place "s|jlbelanger/galleri-project|${project_name}|" composer.json
sed --in-place "s|jlbelanger/galleri-project|${project_name}|" package.json

printf "\n"
printf "Do you want to use a theme?\n"
printf "[1] Basic theme\n"
printf "[2] No theme\n"
read -p "Enter 1 or 2: " theme
if [[ "${theme}" == "1" ]]; then
	rm js/minimal.js
	rm css/minimal.css
	rm public/minimal.php
	rm includes/minimal-header.php
	rm includes/minimal-footer.php
elif [[ "${theme}" == "2" ]]; then
	read -p "Do you want to include Robroy lightbox? Enter [y] for yes: " lightbox
	if [[ "${lightbox}" != "y" ]]; then
		rm js/minimal.js
	else
		rm js/main.js
		mv js/minimal.js js/main.js
		sed --in-place 's|\n\t\t"@jlbelanger/robroy": "jlbelanger/robroy#main",||' package.json
		sed --in-place 's|@import '\.\./node_modules/@jlbelanger/robroy/css/robroy';||' css/minimal.css
	fi

	rm css/style.css
	mv css/minimal.css css/style.css
	rm public/index.php
	mv public/minimal.php public/index.php
	rm includes/header.php
	rm includes/footer.php
	mv includes/minimal-header.php includes/header.php
	mv includes/minimal-footer.php includes/footer.php
fi
sed --in-place "s|Galleri Demo|${project_title}|" includes/header.php

printf "\n"
read -p "Enter the absolute path to the project, including a leading and trailing slash (eg. '/var/www/galleri/'): " project_path
printf "\n"
sed --in-place "s|/path/to/galleri/|${project_path}|" public/.htaccess
cp .env.example .env
sed --in-place "s|/path/to/galleri/|${project_path}|" .env

mkdir build

read -p "Enter the username you want to use to login: " username
htpasswd -c .htpasswd "${username}"
printf "\n"

sed --in-place 's|\t"scripts": {\n\t\t"post-create-project-cmd": \[\n\t\t\t"\./setup\.sh"\n\t\t\]\n\t},||' composer.json

npm install
printf "\n"
npm run build
mkdir build/images
mkdir build/json

printf "Done!\n"

rm setup.sh
