mineTwitterer
=============

twitters your bitcoin miner's mining results to twitter using Perl

INSTALLATION
============

Try to call 'perl mineTwitterer.pl'. If it fails saying that required libraries are missing, then install those libraries (i.e. using 'cpan <LibraryName>' for linux).

On my ubuntu machine I had to run:
sudo cpan REST::Client
sudo cpan JSON
sudo cpan Net::Twitter::Lite::WithAPIv1_1
sudo cpan Net::OAuth

AUTO-START
==========

Put mineTwitterer.sh under /etc/cron.daily/ and make it executable to let your script twitter daily.
