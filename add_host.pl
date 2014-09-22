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
my $sql = '';
GetOptions(
	'h|host=s' => \$host,
        'l|linux' => \$lin,
	'w|win|windows' => \$win,
	'd' => \$drs,
	'y' => \$conf,
	'dx=s' => \$dx,
	'sql=s' => \$sql,
	'dell' => \$dell);

@dxa = split(/,/, $dx);
@sqla = split(/,/, $sql);
$ip = inet_ntoa(inet_aton($host));
tee (STDOUT, '>', "/etc/nagios/tmp_cfg/$host.cfg");

sub host_def {
print  "define service{
        use                     generic-nt
        host_name               $host.hs3.hepsiian.com
        service_description	$_[0]
        check_command		$_[1]
        }
"};


if ( $host ne "") {
print "define host {
        use             generic-notify
        host_name       $host.hs3.hepsiian.com
        alias           $host
        address         $ip
        check_command	check_ping!100.0,20%!500.0,60%
        }
";
} else {
die print $help;
}

%linh = ("CPU", snmp_cpustats, "Uptime", uptime_info_only, "Memory", snmp_mem, "Disk usage /", snmp_disk_root, "Disk usage /data", snmp_disk_data );

if ( $lin == 1 ) {
	foreach $key (keys %linh){ $value = $linh{$key};
&host_def($key,$value);
}}

%winh = ('Check disk C:', 'check_snmp_disk_win!c', 'Check disk D:', 'check_snmp_disk_win!d', 'Uptime', 'check_snmp_win_uptime', 'Memory', 'check_snmp_mem_win', 'CPU load', 'win_snmp_cpu');

if ( $win == 1) {
	foreach $key (keys %winh){ $value = $winh{$key};
&host_def($key,$value);
}}

%drsh = ('Check DRS', 'check_nt_service!DRS', 'Check DRS1', 'check_nt_service!DRS1');

if ( $drs == 1) {
	foreach $key (keys %drsh){ $value = $drsh{$key};
&host_def($key,$value);
}}

if ( @dxa > 0 ) {
	foreach (@dxa){
print "define service{
	use			generic-nt
	host_name		$host.hs3.hepsiian.com
	service_description	Check DX port $_
	check_command		check_tcp!$_
	}
"
}}

if ( @sqla > 0 ) {
        foreach (@sqla){
print "define service{
        use                     generic-nt
        host_name               $host.hs3.hepsiian.com
        service_description     MYSQL Slave $_
        check_command           check_mysql_slave!$_
        }
"
}}

%dellh = ('Dell battery', 'check_perc_battery_omsm', 'Dell PSU', 'check_dell_psu', 'Dell fans', 'check_dell_fans', 'Dell temp', 'check_dell_temps');

if ( $dell == 1 ) {
	foreach $key (keys %dellh){ $value = $dellh{$key};
&host_def($key,$value);
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
