<?php
/**
  * @file gitshapost.php
  * @location git-php-rewrite/document_root/php-bin/
  * @author Raymond Byczko
  * @company self
  * @change_history started on 2016-10-13 October 13, 2016
  * @purpose To produce sha1 values for a certain file that match
  * that produced by git.
  * @change_history 
  */
$pt = $_SERVER['REQUEST_URI'];
$dr = $_SERVER['DOCUMENT_ROOT'];
$fileToCheck = $_GET['ftc'];
echo '<pre>gitshapost:start</pre>';
echo '<pre>'.'pt='.$pt.'</pre>';
echo '<pre>'.'dr='.$dr.'</pre>';
echo '<pre>'.'ftc='.$fileToCheck.'</pre>';
// echo '<pre>gitshapost:end</pre>';
// exit(0);
// $posSuffixStart = strpos($pt, '.gitshamin');
// echo '<pre>'.'posSuffixStart='.$posSuffixStart.'</pre>';
// $realFile = substr($pt, 1, $posSuffixStart-1);
// echo '<pre>'.'realFile='.$realFile.'</pre>';

$realPathName = $dr.'/'.$fileToCheck;
echo '<pre>'.'realPathName='.$realPathName.'</pre>';
// echo '<pre>gitshapost:end</pre>';
// exit(0);
// $fe = file_exists($dr.'/'.$realFile);
$fe = file_exists($realPathName);
if ($fe == false)
{
	echo '<pre>This file does not exist: '.$realPathName.'</pre>';
}
else
{
	echo '<pre>This file does exist: '.$realPathName.'</pre>';
}

echo '<pre>gitshapost:end</pre>';
// exit(0);
// $filecontents = file_get_contents($realPN, FILE_USE_INCLUDE_PATH);
$filecontents = file_get_contents($realPathName);
$filesize = strlen($filecontents);
$gitentity = 'blob '.$filesize."\000".$filecontents;
$sha1ge = sha1($gitentity);
echo '<br>';
echo 'gitshapost.php reporting...'."\n";
echo '<br>';
echo '... file: '.$realPathName."\n";
echo '<br>';
echo '... sha1 is:'.$sha1ge."\n";
echo '<br>';
exit(0);
?>
