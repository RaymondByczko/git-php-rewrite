#!/usr/bin/perl
# @file perl/test/test_gitfind.pl
# @author Raymond Byczko
# @company self
# @start_date 2016-04-11 April 10, 2016
# @purpose To provide support in reading from a git history.
# @change_history 2016-04-10, RByczko, Started this file.

use strict;
use Modern::Perl;
use Getopt::Long;
use Log::Log4perl qw(get_logger);

use lib('/home/raymond/websites/remindme/perl/lib');

use gitsearch;

Log::Log4perl->init("./test_gitfind.conf");

my $githash = '';
GetOptions("githash=s"=>\$githash)
or die('Error in command line options');

if (!($githash)) {
    die("Error in command line-all parameters required");
}

Log::Log4perl->init("./test_gitfind.conf");

setgitlocation('/usr/bin/git');
setverbosity(0);
setlengthgithash(40);
git_recurse_find $githash;
