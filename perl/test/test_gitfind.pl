#!/usr/bin/perl
# @file perl/test/test_gitfind.pl
# @author Raymond Byczko
# @company self
# @start_date 2016-04-11 April 10, 2016
# @purpose To provide support in reading from a git history.
# @change_history 2016-04-10, RByczko, Started this file.
# @change_history 2016-04-12, RByczko, Env var support.
# @change_history 2016-04-13, RByczko, Removed second Log4perl init.

use strict;
use Modern::Perl;
use Getopt::Long;
use Log::Log4perl qw(get_logger);
use Env qw(GITSEARCH_HOME GITSEARCH_LIB);

use lib($GITSEARCH_LIB);

use gitsearch;

Log::Log4perl->init($GITSEARCH_HOME."/test_gitfind.conf");

my $githash = '';
GetOptions("githash=s"=>\$githash)
or die('Error in command line options');

if (!($githash)) {
    die("Error in command line-all parameters required. Usage: --githash HHHH..");
}


setgitlocation('/usr/bin/git');
setverbosity(0);
setlengthgithash(40);
git_recurse_find $githash;
