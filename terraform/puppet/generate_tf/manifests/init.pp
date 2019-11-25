class generate_tf(
  Hash $default,
  Hash $bastion,
  Hash $api_nodes,
  Hash $infra_nodes,
){
  file {"/tf_mainfests/main.tf":
    content => template('generate_tf/main.tf.erb'),
  }
  file {"/tf_mainfests/vars.tf":
    content => template('generate_tf/vars.tf.erb'),
  }
  file {"/tf_mainfests/bastion.tf":
    content => template('generate_tf/bastion.tf.erb'),
  }
  $api_nodes.each |String[1] $api, Hash $node_vars | {
    file {"/tf_mainfests/${api}.tf":
      content => template('generate_tf/api.tf.erb'),
    }
  }
  $infra_nodes.each |String[1] $node, Hash $node_vars | {
    file {"/tf_mainfests/${$node}.tf":
      content => template('generate_tf/infra_nodes.tf.erb'),
    }
  }
  file {"/tf_mainfests/ansible_hosts":
    content => template('generate_tf/inventory/hosts.erb'),
  }  file {"/tf_mainfests/network.yaml":
    content => template('generate_tf/hiera/network.yaml.erb'),
  }
}
