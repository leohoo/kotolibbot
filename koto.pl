#!/usr/bin/perl

use Text::Iconv;
use WWW::Mechanize;
use LWP::Debug qw(+ trace);
use Getopt::Long;

GetOptions("card=s" => \$card, "passwd=s" => \$passwd);
die "card & passwd required." unless $card && $passwd;

$mech = WWW::Mechanize->new();
$mech->cookie_jar(HTTP::Cookies->new()); 
$mech->agent_alias('Linux Mozilla');

$site = "http://www.library.city.koto.tokyo.jp";
$login_url='http://www.library.city.koto.tokyo.jp/csp/kotw/cal950.csp';

$mech->get($login_url);
#print $mech->text, "\n";

$mech->content =~ /window\.open\(\'(.+Phase=600)\'/;

$link = $1;
$mech->get($link);

$response = $mech->submit_form(
	fields => {
		card => $card,
		pwd => $passwd,
	}
	);

if ( ! $mech->success ) {
  die "$! -- fail to submit\n";
}

$mech->follow_link(url_regex=>qr/Phase=/, n=>0);
print $mech->text(), "\n";



