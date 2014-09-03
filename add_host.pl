#!/usr/bin/perl
use File::Tee qw(tee);
use Getopt::Long;
use File::Copy;

my $host = $ARGV[0];
my $ip = $ARGV[1];
my $lin = '';
my $win = '';
my $drs = '';
my $conf = '';
my $dx = '';
GetOptions(
        'l|linux' => \$lin,
        'w|win|windows' => \$win,
        'd' => \$drs,
        'y' => \$conf,
        'dx=s' => \$dx);

@dxa = split(/,/, $dx);

tee (STDOUT, '>', "/etc/nagios/tmp_cfg/$host.cfg");

if ( $host ne "") {
print "define host {
        use             generic-notify
        host_name       $host.
        alias           $host
        address         $ip
        check_command                   check_ping!100.0,20%!500.0,60%
        }
";
} else {
die "Error: Host required  and ip required ./add_host.pl host 1.2.3.4";
}


if ( $lin == 1) {
print "YAY LINUX but im not done yet\n"
}

if ( $win == 1) {
print "define service{
        use                     generic-nt
        host_name               $host
        service_description     Check disk C:
        check_command           check_nt_disk!c
        }
define service{
        use                     generic-nt
        host_name               $host
        service_description     Check disk D:
        check_command           check_nt_disk!d
        }
define service{
        use                     generic-nt
        host_name               $host
        service_description     Uptime
        check_command           check_nt_uptime
        }
define service{
        use                     generic-nt
        host_name               $host
        service_description     Memory
        check_command           check_nt_mem
        }
define service{
        use                     generic-nt
        host_name               $host
        service_description     CPU load
        check_command           win_cpu_load
        }
"
}

if ( $drs == 1 ) {
print "define service{
        use                     generic-nt
        host_name               $host
        service_description     Check DRS
        check_command           check_nt_service!DRS
        }
define service{
        use                     generic-nt
        host_name               $host
        service_description     Check DRS1
        check_command           check_nt_service!DRS1
        }
"
}

if ( @dxa > 0 ) {
        foreach (@dxa){
print "define service{
        use                     generic-nt
        host_name               $host
        service_description     Check DX port $_
        check_command           check_tcp!$_
        }

"
}}

if ( $conf == 1 ) {
move("/etc/nagios/tmp_cfg/$host.cfg","/etc/nagios/servers/$host.cfg");
#sleep 2;
system("chown nagios. /etc/nagios/servers/$host.cfg");
#sleep 2;
system("/etc/init.d/nagios reload >/dev/null 2>&1");
#} else {
#       sub main {
#               print "Does this look correct(Y/N)?";
#               chomp ($qinput = <>);
#               if($qinput =~ m/^[Y]$/i) {
#                       move("/etc/nagios/tmp_cfg/$host.cfg","/etc/nagios/servers/$host.cfg");
#                       system("/etc/init.d/nagios reload");
#               } elsif ($qinput =~ m/^[N]$/i) {
#                       print "Manually move the file in tmp_cfg";
#                       die
#               } else {
#                       print "Invalid option";
#                       die
#                       }
#               }
}


exit
