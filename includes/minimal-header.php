<?php require_once 'functions.php'; ?>
<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1">
		<title><?= title(); ?>Galleri Demo</title>
		<link rel="stylesheet" href="<?= mix('/css/style.min.css'); ?>">
	</head>
	<body>
		<button data-action="authenticate" type="button"></button>
