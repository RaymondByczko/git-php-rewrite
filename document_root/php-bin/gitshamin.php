<?php
/**
  * @file gitshamin.php
  * @author Raymond Byczko
  * @company self
  * @change_history Originally started on 2014-02-13 Feb 13
  * This is a copy/modification gitsha1.php
  * @purpose To produce sha1 values for a certain file that match
  * that produced by git.
  * @change_history 2016-04-13, RByczko, Changed extension from gitsha1 to gitshamin.
  * @change_history 2016-04-13, RByczko, Debug echo utilized.
  */
$pt = $_SERVER['REQUEST_URI'];
$dr = $_SERVER['DOCUMENT_ROOT'];
echo '<pre>'.'pt='.$pt.'</pre>';
echo '<pre>'.'dr='.$dr.'</pre>';
$posSuffixStart = strpos($pt, '.gitshamin');
echo '<pre>'.'posSuffixStart='.$posSuffixStart.'</pre>';
$realFile = substr($pt, 1, $posSuffixStart-1);
echo '<pre>'.'realFile='.$realFile.'</pre>';

$realPN = $dr.'/'.$realFile;
echo '<pre>'.'realPN='.$realPN.'</pre>';
// $fe = file_exists($dr.'/'.$realFile);
$fe = file_exists($realPN);
if ($fe == false)
{
	echo '<p>';
	echo 'This file does not exist: '.$dr.'/'.$realFile;
	return;
}
// $filecontents = file_get_contents($realPN, FILE_USE_INCLUDE_PATH);
$filecontents = file_get_contents($realPN);
$filesize = strlen($filecontents);
$gitentity = 'blob '.$filesize."\000".$filecontents;
$sha1ge = sha1($gitentity);
echo '<br>';
echo 'gitshamin.php reporting...'."\n";
echo '<br>';
echo '... file: '.$realFile."\n";
echo '<br>';
echo '... sha1 is:'.$sha1ge."\n";
echo '<br>';
exit(0);
?>
