#!/usr/bin/perl

# Libraries

use REST::Client;
use JSON qw( decode_json );     # From CPAN 

use Net::Twitter::Lite::WithAPIv1_1;
use Scalar::Util 'blessed';

use Encode qw(decode decode_utf8);

#################################
# Twitter Passwords
#################################

my $nt = Net::Twitter::Lite::WithAPIv1_1->new(
  consumer_key        => 'xy',
  consumer_secret     => 'xy',
  access_token        => 'xy',
  access_token_secret => 'xy',
  ssl => 1,
decode_html_entities => 1
);

#################################
# Pool configuration
#################################

$btcmp_api_key = '';

sub get_profit() {
  my $client = REST::Client->new();
  $client->GET('http://btcmp.com/api_get_stats?key='.$btcmp_api_key);
  my $json = decode_json( $client->responseContent() );
  return $json->{'balance'};
}

#################################
# BTC exchange rate
#################################

sub get_btc_usd_price() {
  my $client = REST::Client->new();
  $client->GET('https://www.bitstamp.net/api/ticker/');
  my $json = decode_json( $client->responseContent() );
  return $json->{"bid"};
}

sub get_usd_to_eur_course() {
  my $client = REST::Client->new();
  $client->GET('https://www.bitstamp.net/api/eur_usd/');
  my $json = decode_json( $client->responseContent() );
  return 1 / $json->{"buy"};
}

sub get_btc_eur_price() {
  return get_btc_usd_price() * get_usd_to_eur_course();
}

#################################
# Text configuration
#################################

my $balance = get_profit();
my $balance_str = $balance;
$balance_str =~ s/\./,/;
my $exchange_rate = get_btc_eur_price();
my $profit = $balance * $exchange_rate;
my $profit_rounded = int(($profit * 100) + 0.5) / 100;
my $profit_rounded_str = sprintf "%.2f", $profit_rounded;
$profit_rounded_str =~ s/\./,/;
my $text = sprintf "Miner has mined $balance_str Bitcoins - with exchange rate of %d€ this makes $profit_rounded_str€\n", $exchange_rate;

#################################
# posting Tweet
#################################

$text = decode_utf8($text);

my $result = eval { $nt->update($text) };

if ( my $err = $@ ) {
  die $@ unless blessed $err && $err->isa('Net::Twitter::Lite::Error');

  warn "HTTP Response Code: ", $err->code, "\n",
       "HTTP Message......: ", $err->message, "\n",
       "Twitter error.....: ", $err->error, "\n";
}
