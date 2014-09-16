#!/usr/bin/perl
use File::Tee qw(tee);
use Getopt::Long;
use File::Copy;
use Socket;

my $help = "Automatic sctipt for adding host to nagios.
Useage for adding hosts
(Required arguments)
-h  / --host    short hostname
-i  / --ip      ip address
(Optional flags)
-l  / --linux
-w  / --windows
-d  / --drs
-dx / --dxsrv2  requires ports seperated by commas
                for each port to check
                2000,2001,etc

-y  / --yes     automatically adds the config to
                nagios then reloads the service \n";


my $host = '';
my $lin = '';
my $win = '';
my $drs = '';
my $conf = '';
my $dx = '';
my $dell = '';
GetOptions(
	'h|host=s' => \$host,
        'l|linux' => \$lin,
	'w|win|windows' => \$win,
	'd' => \$drs,
	'y' => \$conf,
	'dx=s' => \$dx,
	'dell' => \$dell);

@dxa = split(/,/, $dx);


tee (STDOUT, '>', "/etc/nagios/tmp_cfg/$host.cfg");

if ( $host ne "") {
$ip = inet_ntoa(inet_aton($host));
print "define host {
        usage           generic-notify
        host_name       $host
        alias           $host
        address         $ip
        check_command	check_ping!100.0,20%!500.0,60%
        }
";
} else {
die print $help;
}

%linh = ("CPU", snmp_cpustats, "Uptime", uptime_info_onl, "Memory", snmp_mem, "Disk usage /", snmp_disk_root, "Disk usage /data", snmp_disk_data );

if ( $lin == 1 ) {
	foreach $key (keys %linh){ $value = $linh{$key};
print "define service{
	use			generic-nt
	host_name		$host
	service_description	$key
	check_command		$value
	}

"
}}

%winh = ('Check disk C:', 'check_nt_disk!c', 'Check disk D:', 'check_nt_disk!d', 'Uptime', 'check_nt_uptime', 'Memory', 'check_nt_mem', 'CPU load', 'win_cpu_load');

if ( $win == 1 ) {
	foreach $key (keys %winh){ $value = $winh{$key};
print "define service{
        use                     generic-nt
        host_name               $hostname
        service_description     $key
        check_command           $value
        }

"
}}

%drsh = ('Check DRS', 'check_nt_service!DRS', 'Check DRS1', 'check_nt_service!DRS1');

if ( $drs == 1 ) {
        foreach $key (keys %drsh){ $value = $drsh{$key};
print "define service{
        use                     generic-nt
        host_name               $host
        service_description     $key
        check_command           $value
        }

"
}}

if ( @dxa > 0 ) {
	foreach (@dxa){
print "define service{
	use			generic-nt
	host_name		$host
	service_description	Check port $_
	check_command		check_tcp!$_
	}

"
}}

%dellh = ('Dell battery', 'check_perc_battery_omsm', 'Dell PSU', 'check_dell_psu', 'Dell fans', 'check_dell_fans', 'Dell temp', 'check_dell_temps');

if ( $dell == 1 ) {
	foreach $key (keys %dellh){ $value = $dellh{$key};
print "define service{
        use                     generic-nt
        host_name               $host
        service_description     $key
        check_command           $value
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
#	sub main {
#		print "Does this look correct(Y/N)?";
#		chomp ($qinput = <>);
#		if($qinput =~ m/^[Y]$/i) {
#			move("/etc/nagios/tmp_cfg/$host.cfg","/etc/nagios/servers/$host.cfg");
#			system("/etc/init.d/nagios reload");
#		} elsif ($qinput =~ m/^[N]$/i) {
#			print "Manually move the file in tmp_cfg";
#			die
#		} else {
# 			print "Invalid option";
#			die
#			}
#		}
}


exit
