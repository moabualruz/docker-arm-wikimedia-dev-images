<?php

/**
 * Platform settings for Job Runners MediaWiki Docker.
 *
 * Don't add settings here; instead use LocalSettings.php for your local site
 * overrides, or if you want to contribute shared settings for users of the
 * development environment, PlatformSettings.php is managed in the
 * https://gitlab.wikimedia.org/releng/dev-images repository.
 */

require_once "$IP/includes/DevelopmentSettings.php";

// Use same URL scheme as in production (T248178)
$wgArticlePath = "/wiki/$1";

// Disable resource limits for TimedMediaHandler
$wgMaxShellMemory = 0;
$wgMaxShellFileSize = 0;
$wgMaxShellTime = 0;
$wgMaxShellWallClockTime = 0;
$wgTranscodeBackgroundTimeLimit = 0;
$wgTranscodeBackgroundMemoryLimit = 0;
$wgTranscodeBackgroundSizeLimit = 0;
