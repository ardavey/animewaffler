#!/usr/bin/perl
use strict;
use warnings;

use 5.010;

use CGI;
use WWW::Mechanize;

my $q = CGI->new();

my $base_url = 'http://animewaffles.tv/';
my $info_url = 'anime_detail.php?id=';

say $q->header();
say $q->start_html();

my $mech = WWW::Mechanize->new();

my @shows = qw (
  1149
  1281
);

my @links;

foreach my $id ( @shows ) {
  $mech->get( $base_url.$info_url.$id );
  my $title = $mech->title();
  $title =~ s/^Watch (.*?) Anime Online.*$/$1/;
  my $link = $mech->find_link( text_regex => qr/watch now/i );
  say $q->p(
            "$title - ",
             $q->a( { href => $base_url.$link->url() },
                    "Watch latest episode" )
          );
}

say $q->end_html();
