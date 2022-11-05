#!/bin/bash
set -e

read -p "Enter your project title (eg. 'My Gallery'): " project_title
sed --in-place "s|Robroy Photo Gallery Demo|${project_title}|" public/403.html
sed --in-place "s|Robroy Photo Gallery Demo|${project_title}|" public/404.html
sed --in-place "s|Robroy Photo Gallery Demo|${project_title}|" composer.json

read -p "Enter your project name (eg. 'username/project-name'): " project_name
sed --in-place "s|jlbelanger/robroy-project|${project_name}|" composer.json

printf "\n"
printf "Which theme do you want to use?\n"
printf "[1] Dark\n"
printf "[2] Light\n"
printf "[3] Minimal (no theme)\n"
read -p "Enter 1, 2, or 3: " theme
if [[ "${theme}" == "1" ]]; then
	rm scss/light.scss
	rm public/light.html
	rm public/css/light.min.css

	rm scss/minimal.scss
	rm public/minimal.min.css
	rm public/css/minimal.min.css

	mv public/dark.html public/index.html
elif [[ "${theme}" == "2" ]]; then
	rm scss/dark.scss
	rm public/dark.html
	rm public/css/dark.min.css

	rm scss/minimal.scss
	rm public/minimal.min.css
	rm public/css/minimal.min.css

	mv public/light.html public/index.html

	sed --in-place "s|dark.min.css|light.min.css|" public/403.html
	sed --in-place "s|dark.min.css|light.min.css|" public/404.html
elif [[ "${theme}" == "3" ]]; then
	rm scss/light.scss
	rm public/light.html
	rm public/css/light.min.css

	rm scss/dark.scss
	rm public/dark.html
	rm public/css/dark.min.css

	mv public/minimal.html public/index.html

	sed --in-place "s|dark.min.css|minimal.min.css|" public/403.html
	sed --in-place "s|dark.min.css|minimal.min.css|" public/404.html
fi
sed --in-place "s|Robroy Photo Gallery Demo|${project_title}|" public/index.html

read -p "Enter the absolute path to the project (eg. '/var/www/robroy/'): " project_path
sed --in-place "s|/path/to/robroy/|${project_path}|" public/.htaccess
cp .env.example .env
sed --in-place "s|/path/to/robroy/|${project_path}|" .env

mkdir public/images
mkdir public/json

read -p "Enter the username you want to use to login: " username
htpasswd -c .htpasswd "${username}"

rm setup.sh
