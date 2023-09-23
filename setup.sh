#!/bin/bash
set -e

read -p "Enter your project title (eg. 'My Gallery'): " project_title
sed --in-place "s|Galleri Demo|${project_title}|" composer.json
sed --in-place "s|Galleri Demo|${project_title}|" README.md

read -p "Enter your project name (eg. 'username/project-name'): " project_name
sed --in-place "s|jlbelanger/galleri-project|${project_name}|" composer.json
sed --in-place "s|jlbelanger/galleri-project|${project_name}|" package.json

printf "\n"
printf "Which theme do you want to use?\n"
printf "[1] Dark\n"
printf "[2] Light\n"
printf "[3] Minimal (no theme)\n"
read -p "Enter 1, 2, or 3: " theme
if [[ "${theme}" == "1" ]]; then
	rm js/minimal.js
	rm scss/light.scss
	rm scss/minimal.scss
	mv scss/dark.scss scss/style.scss
	rm public/minimal.php
	rm src/minimal-header.php
	rm src/minimal-footer.php
elif [[ "${theme}" == "2" ]]; then
	rm js/minimal.js
	rm scss/dark.scss
	rm scss/minimal.scss
	mv scss/light.scss scss/style.scss
	rm public/minimal.php
	rm src/minimal-header.php
	rm src/minimal-footer.php
elif [[ "${theme}" == "3" ]]; then
	read -p "Do you want to include Robroy lightbox? Enter [y] for yes: " lightbox
	if [[ "${lightbox}" != "y" ]]; then
		rm js/minimal.js
	else
		rm js/main.js
		mv js/minimal.js js/main.js
		sed --in-place 's|\n\t\t"@jlbelanger/robroy": "jlbelanger/robroy#main",||' package.json
		sed --in-place 's|@import '\.\./node_modules/@jlbelanger/robroy/src/scss/robroy';||' scss/minimal.scss
	fi

	rm scss/light.scss
	rm scss/dark.scss
	mv scss/minimal.scss scss/style.scss
	rm public/index.php
	mv public/minimal.php public/index.php
	rm src/header.php
	rm src/footer.php
	mv src/minimal-header.php header.php
	mv src/minimal-footer.php footer.php
fi
sed --in-place "s|Galleri Demo|${project_title}|" src/header.php

printf "\n"
read -p "Enter the absolute path to the project, including a leading and trailing slash (eg. '/var/www/galleri/'): " project_path
printf "\n"
sed --in-place "s|/path/to/galleri/|${project_path}|" public/.htaccess
cp .env.example .env
sed --in-place "s|/path/to/galleri/|${project_path}|" .env

mkdir build
mkdir public/images
mkdir public/json

read -p "Enter the username you want to use to login: " username
htpasswd -c .htpasswd "${username}"

sed --in-place 's|\t"scripts": {\n\t\t"post-create-project-cmd": \[\n\t\t\t"\./setup\.sh"\n\t\t\]\n\t},||' composer.json

yarn install
yarn build

printf "Done!\n"

rm setup.sh
