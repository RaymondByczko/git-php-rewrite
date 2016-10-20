<?php
/**
  * @file gitshaxml.php
  * @location git-php-rewrite/document_root/php-bin/
  * @author Raymond Byczko
  * @company self
  * @change_history started on 2016-10-18 October 18, 2016
  * @purpose To produce sha1 values for a certain file that match
  * that produced by git.  The return output is in xml format.
  */
header('Content-Type: text/xml');
echo '<?xml version="1.0" ?>'."\n";
echo '<!DOCTYPE git-php-rewrite:gitshaxml>'."\n";
$error_detected = false;
$pt = $_SERVER['REQUEST_URI'];
$dr = $_SERVER['DOCUMENT_ROOT'];
$fileToCheck = $_GET['ftc'];
// echo '<pre>gitshapost:start</pre>';
// echo '<pre>'.'pt='.$pt.'</pre>';
// echo '<pre>'.'dr='.$dr.'</pre>';
// echo '<pre>'.'ftc='.$fileToCheck.'</pre>';

$realPathName = $dr.'/'.$fileToCheck;
// echo '<pre>'.'realPathName='.$realPathName.'</pre>';
$fe = file_exists($realPathName);
$error_message = 'NO_ERROR_DETECTED';
$error_code = 0; // presume success - 0
if ($fe == false)
{
	$error_detected = true;
	$error_message =  'File does not exist: '.$realPathName;
	$error_code = 1;
}
else
{
	// echo '<pre>This file does exist: '.$realPathName.'</pre>';
}

$sha1ge = '';
if ($errorDetected == false)
{
	$filecontents = file_get_contents($realPathName);
	$filesize = strlen($filecontents);
	$gitentity = 'blob '.$filesize."\000".$filecontents;
	$sha1ge = sha1($gitentity);
}
else
{
	$sha1ge = 'NOT_AVAILABLE';
}
echo "<git-php-rewrite:gitshaxml xmlns:git-php-rewrite='https://github.com/RaymondByczko/git-php-rewrite'>"."\n";
echo '<whoisreporting>';
echo 'gitshaxml.php';
echo '</whoisreporting>'."\n";
echo '<infoabout>';
echo $realPathName;
echo '</infoabout>'."\n";
echo '<gitshavalue>';
echo $sha1ge;
echo '</gitshavalue>'."\n";
echo '<errorcode>';
echo $error_code;
echo '</errorcode>'."\n";
echo '<error_message>';
echo $error_message;
echo '</error_message>'."\n";
echo '</git-php-rewrite:gitshaxml>'."\n";
?>
