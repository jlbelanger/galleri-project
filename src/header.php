<?php require_once 'functions.php'; ?>
<!doctype html>
<html class="no-js" lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1">
		<title><?= title(); ?>Galleri Demo</title>
		<link rel="stylesheet" href="<?= mix('/css/style.min.css'); ?>">
		<script integrity="sha256-tuKyZn/3ycw/MNMDii/kvSPrelo6SCsJSecqb1n2neg=">document.documentElement.classList.remove('no-js');</script>
	</head>
	<body>
		<main>
			<header id="header">
				<div class="contain" id="header-inner">
					<a href="/" id="title">Galleri Demo</a>
					<button class="galleri-button galleri-button--secondary galleri-button-authenticate" data-action="authenticate" type="button"></button>
				</div>
			</header>
			<article>
