mineTwitterer
=============

twitters your bitcoin miner's mining results to twitter using Perl.

The current script is configured to use the btcmp-Pool and twitter €-prices.

The script runs fine on my Ubuntu and my Minepeon Raspberry Pi.

Configuration
=============

Download and edit mineTwitterer.pl. You will have to provide your twitter-API-keys and some code to access your Pool. You can configure the text that perl should post and the currency you want to use.

Installation
============

Try to call 'perl mineTwitterer.pl'. If it fails saying that required libraries are missing, then install those libraries (i.e. using 'cpan <LibraryName>' for linux).

On my ubuntu machine I had to run:
sudo cpan REST::Client
sudo cpan JSON
sudo cpan Net::Twitter::Lite::WithAPIv1_1
sudo cpan Net::OAuth

Auto-start (Linux)
==================

Put mineTwitterer.sh under /etc/cron.daily/ and make it executable to let your script twitter daily. In most cases you will have to change the path to your perl-skript inside the file.
