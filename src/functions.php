<?php

function mix(string $filename)
{
	$path = '../build/manifest.json';
	if (!file_exists($path)) {
		return $filename;
	}
	$json = json_decode(file_get_contents($path), true);
	return !empty($json[$filename]) ? $json[$filename] : $filename;
}

function title()
{
	global $title;
	if (empty($title)) {
		return '';
	}
	return $title . ' | ';
}
