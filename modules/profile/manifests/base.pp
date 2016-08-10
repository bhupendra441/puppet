#- file:  modules/profile/manifests/base.pp
#- Class: profile::base
#
# Class to install the base requirements for any host
#
class profile::base {

    package { "ntp":
        ensure => installed
    }

    service { "ntp":
        ensure  => running,
        require => Package['ntp']
    }


    class { 'sensu':
     rabbitmq_password  => 'secret',
     rabbitmq_host      => '10.162.52.161',
     subscriptions      => 'all',
     safe_mode          => true,
     plugins            => ['file:///etc/puppet/modules/sensu_community_plugins/plugins/system/vmstat-metrics.rb','file:///etc/puppet/modules/sensu_community_plugins/plugins/system/disk-metrics.rb','file:///etc/puppet/modules/sensu_community_plugins/plugins/system/disk-usage-metrics.rb','file:///etc/puppet/modules/sensu_community_plugins/plugins/system/check-cpu.rb','file:///etc/puppet/modules/sensu_community_plugins/plugins/system/check-mem.rb','file:///etc/puppet/modules/sensu_community_plugins/plugins/system/check-disk.rb']
   }



  sensu::check { "disk_metrics":
    command => '/etc/sensu/plugins/disk-metrics.rb  --scheme stats.sprint3.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }
  
  sensu::check { "mem_metrics":
    command => '/etc/sensu/plugins/memory-metrics.rb  --scheme stats.sprint3.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }
  
  sensu::check { "disk_usage_metrics":
    command => '/etc/sensu/plugins/disk-usage-metrics.rb  --scheme stats.sprint3.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }
  
  sensu::check { "vmstat_metrics":
    command => '/etc/sensu/plugins/vmstat-metrics.rb  --scheme stats.sprint3.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }
  
  sensu::check { "check_cpu":
    command => '/etc/sensu/plugins/check-cpu.rb  --scheme stats.sprint3.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }
  
  sensu::check { "check_mem":
    command => '/etc/sensu/plugins/check-mem.rb  --scheme stats.sprint3.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }
  
  sensu::check { "check_disk":
    command => '/etc/sensu/plugins/check-disk.rb  --scheme stats.sprint3.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }

}