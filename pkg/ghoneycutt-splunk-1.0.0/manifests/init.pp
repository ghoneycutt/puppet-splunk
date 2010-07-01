# Class: splunk
#
# This module manages Splunk! - a data analysis tool
#
# Requires:
#   class puppet
#
class splunk {

    include puppet

    # currently installed by hand until our yum repo is working
    package { "splunk": }

    # this will install /etc/init.d/splunk and enables it with chkconfig
    exec { "/opt/splunk/bin/splunk enable boot-start":
        command     => "/opt/splunk/bin/splunk enable boot-start",
        creates     => "${puppet::semaphores}/$name",
        refreshonly => true,
        require     => Package["splunk"],
    } #exec

    service { "splunk":
        ensure  => running,
        enable  => true,
        require => [ Exec["/opt/splunk/bin/splunk enable boot-start"], Package["splunk"] ],
    } #service
} # class splunk
