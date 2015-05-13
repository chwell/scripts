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
-sv             comma sereprated services to check.
-sql            comma seperated sql ports to check.
-p / --ports  requires ports seperated by commas
                for each port to check
                2000,2001,etc.
-dsk            comma seperated additional disks.
-y  / --yes     automatically adds the config to
                nagios then reloads the service \n";

my $host = '';
my $lin = '';
my $win = '';
my $serv = '';
my $conf = '';
my $dx = '';
my $port = '';
my $dell = '';
my $sql = '';
my $dsk = '';
my $hp = '';
GetOptions(
        'h|host=s' => \$host,
        'l|linux' => \$lin,
        'w|win|windows' => \$win,
        'sv=s' => \$serv,
        'y' => \$conf,
        'dx=s' => \$dx,
        'sql=s' => \$sql,
        'dsk=s' => \$dsk,
        'dell' => \$dell,
        'p|port=s' => \$dell,
        'hp' => \$hp);

@dska = split(/,/, $dsk);
@sva = split(/,/, $serv);
@dxa = split(/,/, $dx);
@porta = split(/,/, $port);
@sqla = split(/,/, $sql);
#$ip = inet_ntoa(inet_aton($host));
tee (STDOUT, '>', "/etc/nagios/tmp_cfg/$host.cfg");

sub host_def {
print  "define service{
        use                     generic-nt
        host_name               $host
        service_description     $_[0]
        check_command           $_[1]
        }
"};


if ( $host ne "") {
$ip = inet_ntoa(inet_aton($host));
print "define host {
        use             generic-notify
        host_name       $host
        alias           $host
        address         $ip
        check_command   check_ping!100.0,20%!500.0,60%
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

%winh = ('Check disk C:', 'check_snmp_disk_win!^C -w85 -c90', 'Check disk D:', 'check_snmp_disk_win!^D -w85 -c90', 'Uptime', 'check_snmp_win_uptime', 'Memory', 'check_snmp_mem_win', 'CPU load', 'win_snmp_cpu');

if ( $win == 1) {
        foreach $key (keys %winh){ $value = $winh{$key};
&host_def($key,$value);
}}


%hph = ('Check ILO', hp_snmp);

if ( $hp == 1) {
        foreach $key (keys %hph){ $value = $hph{$key};
&host_def($key,$value);
}}



if ( @dska > 0 ) {
        foreach (@dska){
print "define service{
        use                     generic-nt
        host_name               $host
        service_description     Check disk \U$_
        check_command           check_snmp_disk_win!\^\U$_: -w85 -c90
        }
"
}}

if ( @sva > 0 ) {
        foreach (@sva){
print "define service{
        use                     generic-nt
        host_name               $host
        service_description     Check service $_
        check_command           win_snmp_service!\\\\^$_\$
        }
"
}}


if ( @dxa > 0 ) {
        foreach (@dxa){
print "define service{
        use                     generic-nt
        host_name               $host
        service_description     DX file pull $_
        check_command           check_dx!$_}
"
}}

if ( @sqla > 0 ) {
        foreach (@sqla){
print "define service{
        use                     generic-nt
        host_name               $host
        service_description     MYSQL Slave $_
        check_command           check_mysql_slave!$_
        }
"
}}

if ( @port > 0 ) {
        foreach (@porta){
print "define service{
        use                     generic-nt
        host_name               $host
        service_description     Check port $_
        check_command           check_tcp!$_
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
}


exit
