# @file perl/lib/gitsearch.pm
# @company self
# @author Raymond Byczko
# @purpose This file defines a module to access a git repository.
# @start_date 2016-04-10 April 10, 2016  This is a very rough draft.
# @change_history 2016-04-11 April 11, 2016 Added git_recurse_find.
# Adjust packagename to gitsearch. Added verbosity. Added get/set for
# lengthgithash.
#

use strict;
package gitsearch;
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(getgitlocation setgitlocation git_recurse git_recurse_find setverbosity getverbosity setlengthgithash getlengthgithash);
our @EXPORT_OK = qw(getgitlocation setgitlocation git_recurse git_recurse_find setverbosity getverbosity setlengthgithash getlengthgithash);

use Log::Log4perl qw(get_logger);

my $logger = get_logger("gitsearch");

### GIT
my $gitlocation='/usr/bin/git';
sub setgitlocation {
	$gitlocation = shift(@_);
}
sub getgitlocation()
{
	return $gitlocation;
}


### VERBOSITY setting 
# 1 is true
# 0 is false
my $verbosity=1; #set as true
sub setverbosity {
	$verbosity = shift(@_);
}
sub getverbosity()
{
	return $verbosity;
}

### LENGTH GIT HASH setting 
my $lengthGIThash=40;
sub setlengthgithash {
	$lengthGIThash = shift(@_);
}
sub getlengthgithash()
{
	return $lengthGIThash;
}

# @purpose To get the account information given account id.
# Before this function is called it is important to set up
# the database env properly.  This can be done with the
# supplied methods as indicated.
#
#	setdatabase("database");
#	sethostname("localhost");
#	setuser("databaseuser");
#	setpassword("databasepassword");
#
# The return value is an array of hash refs.  Each hash ref points to
# a hash with the following keys:
#		reminder_id
#		reminder_datatime
#		message
#
sub getaccount_id {
} 


# @purpose To recurse through all commits, and show each file and has
# in each commit.  This is a rather verbose way of doing things.
# Its the prototype for further development.
#
# Before this function is called it is important to set up
# the env properly.  This can be done with the
# supplied methods as indicated.
#
#	setgitlocation('/usr/bin/git');
#	setverbosity(0); # 0 is false
#	setlengthgithash(40);
#	git_recurse;
#
sub git_recurse {
	my $GITLOGFH;
	open(GITLOGFH, $gitlocation.' log --format=oneline |')
	or die "Unable to launch git log";
	my $logct = 0;
	while (my $linegitlog = <GITLOGFH>)
	{
		my $line = $linegitlog;
		my $GIThash;
		$logct=$logct+1;
		print 'logct='.$logct.'; '.$line."\n";
		$GIThash = substr $line, 0, $lengthGIThash;
		print 'GIThash='.$GIThash."\n";

		my $GITLSTREEFH;
		open(GITLSTREEFH, $gitlocation.' ls-tree -r '.$GIThash.' --full-tree |')
		or die "Unable to launch git ls-tree";
		while (my $linetree = <GITLSTREEFH>)
		{
			# my $linetree = <GITLSTREEFH>;
			my @words;
			@words = split ' ', $linetree;
			my $GIThashFile = $words[2];
			my $GITFile = $words[3];
			print '...GIThashFile='.$GIThashFile."\n";
			print '...GITFile='.$GITFile."\n";
		
		}
		close(GITLSTREEFH);
		
	}
	close(GITFH);
	print 'logct (total)='.$logct."\n";
}


# @purpose Given a hash value, this subroutine will search through
# each commit1 as given by 'git log --format=oneline', and look
# for a file with a git hash that matches the one supplied.
#
# Each commit is researched with git ls-tree -r <commit1> --full-tree.
#
sub git_recurse_find {
	my $gitHashValue = shift(@_);
	my $lenGHV = length $gitHashValue;
	my $logger = get_logger('gitsearch');
	$logger->info('git_recurse_find');

	my $GITLOGFH;
	open(GITLOGFH, $gitlocation.' log --format=oneline |')
	or die "Unable to launch git log";
	my $logct = 0;
	while (my $linegitlog = <GITLOGFH>)
	{
		my $line = $linegitlog;
		my $GIThash;
		$logct=$logct+1;
		if ($verbosity) {
			print 'logct='.$logct.'; '.$line."\n";
		}
		$GIThash = substr $line, 0, $lengthGIThash;
		if ($verbosity) {
			print 'GIThash='.$GIThash."\n";
		}

		my $GITLSTREEFH;
		open(GITLSTREEFH, $gitlocation.' ls-tree -r '.$GIThash.' --full-tree |')
		or die "Unable to launch git ls-tree";
		while (my $linetree = <GITLSTREEFH>)
		{
			# my $linetree = <GITLSTREEFH>;
			my @words;
			@words = split ' ', $linetree;
			my $GIThashFile = $words[2];
			my $GITFile = $words[3];
			my $partGHF = substr $GIThashFile, 0, $lenGHV;
			if ($partGHF eq $gitHashValue)
			{
				print '...found; '."\n";
				print '... ...COMMITHASH='.$GIThash."\n";
				print '... ... ...gitHashValue='.$gitHashValue."\n";
				print '... ... ...GIThashFile='.$GIThashFile."\n";
				print '... ... ...GITFile='.$GITFile."\n";
			}
			if ($verbosity)
			{
				print '...GIThashFile='.$GIThashFile."\n";
				print '...GITFile='.$GITFile."\n";
			}
		
		}
		close(GITLSTREEFH);
		
	}
	close(GITFH);
	print 'logct (total)='.$logct."\n";
}
