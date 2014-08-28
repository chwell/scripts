#!/bin/bash

# This is used to install older versions, Uncomment the version below
#if [ -z "$1" ]; then 
#              echo 'usage: ./cdp_install.sh [3-5] ex: ./cdp_install.sh 5 *installs cdp agent v5*'
#              exit
#fi
ARCH=`uname -m`
#D64='/root/cdpinstall/deb-linux64'
#D32='/root/cdpinstall/deb-linux32'
#R64='/root/cdpinstall/rpm-linux64'
#R32='/root/cdpinstall/rpm-linux32'
#
#
# installation checking
if [ -f /usr/bin/unzip ]; then
	echo "unzip installed"
elif [ -f /etc/debian_version ]; then
	echo "installing unzip"
	apt-get install -y unzip
elif [ -f /etc/redhat-release ]; then
	echo "installing unzip"
	yum install -y unzip
fi

####################################### Version 3 ####################################
#if [ "$1" == "3" ]; then
#	if [ $ARCH == 'x86_64' ]; then
#		mkdir /root/cdpinstall
#		pushd /root/cdpinstall/
#		wget http://download.r1soft.com/d/enterprise-agent/.3.18.3-linux64/R1Soft-EnterpriseAgent/R1Soft-EnterpriseAgent-linux64-3.18.3.zip
#			if [ -f "R1Soft-EnterpriseAgent-linux64-3.18.3.zip" ]; then
#				unzip R1Soft-EnterpriseAgent-linux64-3.18.3.zip -d /root/cdpinstall/
#			fi
#				if [ -f /etc/debian_version ]; then
#					pushd /root/cdpinstall/deb-linux64/
#					dpkg -i *.deb
#					#dpkg -i r1soft-setup-amd64-3.18.3.deb
#					#dpkg -i r1soft-cdp-async-agent-2-6-amd64-3.18.3.deb
#					#dpkg -i r1soft-cdp-agent-amd64-3.18.3.deb
#					#dpkg -i r1soft-cdp-enterprise-agent-amd64-3.18.3.deb
#					iptables -I INPUT -p tcp -m tcp --dport 1167 -j ACCEPT
#					/usr/bin/r1soft-setup --get-module && /etc/init.d/cdp-agent restart
#					echo "Debian 64bit installed v3"
#                                elif [ -f /etc/redhat-release ]; then
#                                        pushd /root/cdpinstall/rpm-linux64/
#					rpm -i r1soft-setup-3.18.3.x86_64.rpm
#					rpm -i r1soft-cdp-async-agent-2-6-3.18.3.x86_64.rpm
#					rpm -i r1soft-cdp-agent-3.18.3.x86_64.rpm
#					rpm -i r1soft-cdp-enterprise-agent-3.18.3.x86_64.rpm
#					iptables -I INPUT -p tcp -m tcp --dport 1167 -j ACCEPT
#					/usr/bin/r1soft-setup --get-module && /etc/init.d/cdp-agent restart
#					echo "RedHat 64bit installed v3"
#				else 
#					echo "unknown distro bye"
#					exit 1
#				fi
#	elif [ $ARCH == 'i386' ]; then
#                mkdir /root/cdpinstall/
#		pushd /root/cdpinstall/
#                wget http://download.r1soft.com/d/enterprise-agent/.3.18.3-linux32/R1Soft-EnterpriseAgent/R1Soft-EnterpriseAgent-linux32-3.18.3.zip
#                        if [ -f "R1Soft-EnterpriseAgent-linux32-3.18.3.zip" ]; then
#                                unzip R1Soft-EnterpriseAgent-linux32-3.18.3.zip -d /root/cdpinstall/
#                                if [ -f /etc/debian_version ]; then
#                                        pushd /root/cdpinstall/deb-linux32/
#					dpkg -i *.deb
#                                        #dpkg -i r1soft-setup-i386-3.18.3.deb
#                                        #dpkg -i r1soft-cdp-async-agent-2-6-i386-3.18.3.deb
#                                        #dpkg -i r1soft-cdp-agent-i386-3.18.3.deb
#                                        #dpkg -i r1soft-cdp-enterprise-agent-i386-3.18.3.deb
#					iptables -I INPUT -p tcp -m tcp --dport 1167 -j ACCEPT
#					/usr/bin/r1soft-setup --get-module && /etc/init.d/cdp-agent restart
#					echo "Debian 32bit installed v3"
#                                elif [ -f /etc/redhat-release ]; then
#                                        pushd /root/cdpinstall/rpm-linux32/
#                                        rpm -i r1soft-setup-3.18.3.i386.rpm
#                                        rpm -i r1soft-cdp-async-agent-2-6-3.18.3.i386.rpm
#                                        rpm -i r1soft-cdp-agent-3.18.3.i386.rpm
#                                        rpm -i r1soft-cdp-enterprise-agent-3.18.3.i386.rpm
#					iptables -I INPUT -p tcp -m tcp --dport 1167 -j ACCEPT
#					/usr/bin/r1soft-setup --get-module && /etc/init.d/cdp-agent restart
#					echo "RedHat 32bit installed v3"
#                                else
#                                        echo "unknown distro bye"
#                                        exit 1
#                                fi
#			else 
#				echo "download error"
#				exit 1
#			fi
#	else
#		echo "unknown architecture"
#		exit 1
#	fi
############################################ Version 4 ####################################
#elif [ "$1" == "4" ]; then
#        if [ $ARCH == 'x86_64' ]; then
#                mkdir /root/cdpinstall
#		pushd /root/cdpinstall/
#                wget http://download.r1soft.com/d/enterprise-agent/4.2.1-linux64/R1Soft-EnterpriseAgent/R1Soft-EnterpriseAgent-linux64-4.2.1.zip
#                        if [ -f "R1Soft-EnterpriseAgent-linux64-4.2.1.zip" ]; then
#                                unzip R1Soft-EnterpriseAgent-linux64-4.2.1.zip -d /root/cdpinstall/
#                        fi
#                                if [ -f /etc/debian_version ]; then
#                                        pushd /root/cdpinstall/deb-linux64/
#                                        dpkg -i *.deb
#					#dpkg -i r1soft-setup-amd64-4.2.1.deb
#                                        #dpkg -i r1soft-cdp-async-agent-2-6-amd64-4.2.1.deb
#                                        #dpkg -i r1soft-cdp-agent-amd64-4.2.1.deb
#                                        #dpkg -i r1soft-cdp-enterprise-agent-amd64-4.2.1.deb
#                                        iptables -I INPUT -p tcp -m tcp --dport 1167 -j ACCEPT
#					/usr/bin/r1soft-setup --get-module
#					echo "Debian 64bit installed v4"
#                                elif [ -f /etc/redhat-release ]; then
#                                        pushd /root/cdpinstall/rpm-linux64/
#                                        rpm -i r1soft-setup-4.2.1.x86_64.rpm
#                                        rpm -i r1soft-cdp-async-agent-2-6-4.2.1.x86_64.rpm
#                                        rpm -i r1soft-cdp-agent-4.2.1.x86_64.rpm
#                                        rpm -i r1soft-cdp-enterprise-agent-4.2.1.x86_64.rpm
#                                        iptables -I INPUT -p tcp -m tcp --dport 1167 -j ACCEPT
#					/usr/bin/r1soft-setup --get-module && /etc/init.d/cdp-agent restart
#					echo "RedHat 64bit installed v4"
#                                else
#                                        echo "unknown distro bye"
#                                        exit 1
#                                fi
#        elif [ $ARCH == 'i386' ]; then
#                mkdir /root/cdpinstall
#		pushd /root/cdpinstall/
#                wget http://download.r1soft.com/d/enterprise-agent/4.2.1-linux32/R1Soft-EnterpriseAgent/R1Soft-EnterpriseAgent-linux32-4.2.1.zip
#                        if [ -f "R1Soft-EnterpriseAgent-linux32-4.2.1.zip" ]; then
#                                unzip R1Soft-EnterpriseAgent-linux32-4.2.1.zip -d /root/cdpinstall/
#                                if [ -f /etc/debian_version ]; then
#					pushd /root/cdpinstall/deb-linux32/
#					dpkg -i *.deb
#                                        #dpkg -i r1soft-setup-i386-4.2.1.deb
#                                        #dpkg -i r1soft-cdp-async-agent-2-6-i386-4.2.1.deb
#                                        #dpkg -i r1soft-cdp-agent-i386-4.2.1.deb
#                                        #dpkg -i r1soft-cdp-enterprise-agent-i386-4.2.1.deb
#                                        iptables -I INPUT -p tcp -m tcp --dport 1167 -j ACCEPT
#					/usr/bin/r1soft-setup --get-module && /etc/init.d/cdp-agent restart
#					echo "Debian 32bit installed v4"
#                                elif [ -f /etc/redhat-release ]; then
#                                        pushd /root/cdpinstall/rpm-linux32/
#                                        rpm -i r1soft-setup-4.2.1.i386.rpm
#                                        rpm -i r1soft-cdp-async-agent-2-6-4.2.1.i386.rpm
#                                        rpm -i r1soft-cdp-agent-4.2.1.i386.rpm
#                                        rpm -i r1soft-cdp-enterprise-agent-4.2.1.i386.rpm
#                                        iptables -I INPUT -p tcp -m tcp --dport 1167 -j ACCEPT
#					/usr/bin/r1soft-setup --get-module && /etc/init.d/cdp-agent restart
#					echo "RedHat 32bit installed v4"
#                                else
#                                        echo "unknown distro bye"
#                                        exit 1
#                                fi
#                        else
#                                echo "download error"
#                                exit 1
#                        fi
#        else
#                echo "unknown architecture"
#                exit 1
#        fi
############################################ Version 5 ####################################
#elif [ "$1" == "5" ]; then
        if [ $ARCH == 'x86_64' ]; then
                mkdir /root/cdpinstall
		pushd /root/cdpinstall/
                wget http://download.r1soft.com/d/enterprise-agent/5.0.2-linux64/R1Soft-EnterpriseAgent/ServerBackup-Enterprise-Agent-linux64-5.0.2.zip
                        if [ -f "ServerBackup-Enterprise-Agent-linux64-5.0.2.zip" ]; then
                                unzip ServerBackup-Enterprise-Agent-linux64-5.0.2.zip -d /root/cdpinstall/
                        fi
                                if [ -f /etc/debian_version ]; then
                                        pushd /root/cdpinstall/deb-linux64/
					dpkg -i *.deb
					# Uncomment this if there is an issue with the install order					
                                        #dpkg -i serverbackup-setup-amd64-5.0.2.deb
                                        #dpkg -i serverbackup-async-agent-2-6-amd64-5.0.2.deb
					#dpkg -i serverbackup-agent-amd64-5.0.2.deb
                                        #dpkg -i serverbackup-enterprise-agent-amd64-5.0.2.deb
                                        iptables -I INPUT -p tcp -m tcp --dport 1167 -j ACCEPT
					/usr/bin/serverbackup-setup --get-module && /etc/init.d/cdp-agent restart
					echo "Debian 64bit installed v5"
                                elif [ -f /etc/redhat-release ]; then
                                        pushd /root/cdpinstall/rpm-linux64/
                                        rpm -i serverbackup-setup-5.0.2.x86_64.rpm
                                        rpm -i serverbackup-async-agent-2-6-5.0.2.x86_64.rpm
                                        rpm -i serverbackup-agent-5.0.2.x86_64.rpm
                                        rpm -i serverbackup-enterprise-agent-5.0.2.x86_64.rpm
                                        iptables -I INPUT -p tcp -m tcp --dport 1167 -j ACCEPT
					/usr/bin/serverbackup-setup --get-module && /etc/init.d/cdp-agent restart
					echo "RedHat 64bit installed v5"
                                else
                                        echo "unknown distro bye"
                                        exit 1
                                fi
        elif [ $ARCH == 'i386' ]; then
                mkdir /root/cdpinstall
		pushd /root/cdpinstall/
                wget http://download.r1soft.com/d/enterprise-agent/5.0.2-linux32/R1Soft-EnterpriseAgent/ServerBackup-Enterprise-Agent-linux32-5.0.2.zip
                        if [ -f "ServerBackup-Enterprise-Agent-linux32-5.0.2.zip" ]; then
                                unzip ServerBackup-Enterprise-Agent-linux32-5.0.2.zip -d /root/cdpinstall/
                                if [ -f /etc/debian_version ]; then
                                        pushd /root/cdpinstall/deb-linux32/
					dpkg -i *.deb
					# Uncomment this if there is an issue with the install order
					# dpkg -i serverbackup-setup-i386-5.0.2.deb
                                        # dpkg -i serverbackup-async-agent-2-6-i386-5.0.2.deb
                                        # dpkg -i serverbackup-agent-i386-5.0.2.deb
                                        # dpkg -i serverbackup-enterprise-agent-i386-5.0.2.deb
                                        iptables -I INPUT -p tcp -m tcp --dport 1167 -j ACCEPT
					/usr/bin/serverbackup-setup --get-module && /etc/init.d/cdp-agent restart
					echo "Debian 32bit installed v5"
                                elif [ -f /etc/redhat-release ]; then
                                        pushd /root/cdpinstall/rpm-linux32/
                                        rpm -i serverbackup-setup-5.0.2.i386.rpm
                                        rpm -i serverbackup-async-agent-2-6-5.0.2.i386.rpm
                                        rpm -i serverbackup-agent-5.0.2.i386.rpm
                                        rpm -i serverbackup-enterprise-agent-5.0.2.i386.rpm
                                        iptables -I INPUT -p tcp -m tcp --dport 1167 -j ACCEPT
					/usr/bin/serverbackup-setup --get-module && /etc/init.d/cdp-agent restart
					echo "RedHat 32bit installed v5"
                                else
                                        echo "unknown distro bye"
                                        exit 1
                                fi
                        else
                                echo "download error"
                                exit 1
                        fi
        else
                echo "unknown architecture"
                exit 1
        fi
#fi

if [ -d /usr/sbin/r1soft/ ]; then
echo '-----BEGIN PUBLIC KEY-----
####-PUT KEY HERE-###
-----END PUBLIC KEY-----' > /usr/sbin/r1soft/conf/server.allow/SERVER-NAME

echo '**Keys installed**'
echo '( r1soft-setup --get-module && /etc/init.d/cdp-agent restart ) &' >> /etc/rc.d/rc.local
echo '**Kernel recompile added to startup**'
else echo '/usr/sbin/r1soft/ does not exist check installation'
exit 1
fi
