
# - General Terraform vars

location            = "eastus2"
resource_group_name = "jstartvm-rg16"

administrator_user_name      = "demo"
administrator_login_password = "Nonesense!UseKeyvault2020"

# - Virtual Network

virtual_networks = {
  virtualnetwork1 = {
    name                 = "jstart007"
    address_space        = ["10.0.138.0/24"]
    dns_servers          = null
    ddos_protection_plan = null
  }
}

# Subnets
subnets = {
  subnet1 = {
    vnet_key          = "virtualnetwork1"
    nsg_key           = "nsg1" #NSG key to associate with vnet
    rt_key            = null
    name              = "loadbalancer"
    address_prefix    = "10.0.138.0/28"
    service_endpoints = ["Microsoft.Sql", "Microsoft.AzureCosmosDB"]
    pe_enable         = false
    delegation        = []
  },
  subnet2 = {
    vnet_key          = "virtualnetwork1"
    nsg_key           = null
    rt_key            = null
    name              = "proxy"
    address_prefix    = "10.0.138.16/28"
    pe_enable         = true
    service_endpoints = null
    delegation        = []
  },
  subnet3 = {
    vnet_key          = "virtualnetwork1"
    nsg_key           = null
    rt_key            = null
    name              = "application"
    address_prefix    = "10.0.138.32/28"
    pe_enable         = true
    service_endpoints = null
    delegation        = []
  }
}

route_tables = {}

# - Base Infrastructure Network Security Groups


network_security_groups = {
  nsg1 = {
    name = "nsg1"
    security_rules = [
      {
        name                         = "sample-nsg"
        description                  = "Sample NSG"
        priority                     = 101
        direction                    = "Outbound"
        access                       = "Allow"
        protocol                     = "Tcp"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "*"
        destination_port_ranges      = null
        source_address_prefix        = "*"
        source_address_prefixes      = null
        destination_address_prefix   = "*"
        destination_address_prefixes = null
      }
    ]
  }
}

# - Base Infrastructure Log Analytics Workspace 

base_infra_log_analytics_name = "jstartvm20200516abc"
sku                           = "PerGB2018"
retention_in_days             = 30
log_analytics_workspace       = null

# - Base Infrastructure Storage Account

base_infra_storage_accounts = {
  sa1 = {
    name                       = "jstartvm20200516abc"
    sku                        = "Standard_RAGRS"
    account_kind               = null
    access_tier                = null
    assign_identity            = true
    cmk_enable                 = true
    network_rules              = null
    enable_large_file_share    = false
    sa_pe_is_manual_connection = false
    sa_pe_subnet_name          = "proxy"
    sa_pe_vnet_name            = "jstart007"
    sa_pe_enabled_services     = ["table", "queue", "blob"]
  }
}


# - Key Vault

base_infra_keyvault_name = "jstartvm20200516abc"

network_acls = {
  bypass                     = "AzureServices"
  default_action             = "Deny"
  ip_rules                   = ["0.0.0.0/0"]
  virtual_network_subnet_ids = []
}

# - Private LoadBalancer

zones = ["1"]

Lbs = {
  loadbalancer1 = {
    name = "springbootlb"
    frontend_ips = [
      {
        name        = "springbootlbfrontend"
        subnet_name = "loadbalancer" # Id of the Subnet
        static_ip   = null           # "10.0.1.4" #(Optional) Set null to get dynamic IP or delete this line
      },
      {
        name        = "springbootlbfrontend1"
        subnet_name = "loadbalancer" # Id of the Subnet
        static_ip   = null           # "10.0.1.4" #(Optional) Set null to get dynamic IP or delete this line
      }
    ]
    backend_pool_names = ["springbootlbbackend", "springbootlbbackend1"]
    add_public_ip      = false
  }
}

LbRules = {
  loadbalancerrules1 = {
    name                      = "springboot-lb-rule"
    lb_key                    = "loadbalancer1"        #Id of the Load Balancer
    frontend_ip_name          = "springbootlbfrontend" #It must equals the Lbs front end
    backend_pool_name         = "springbootlbbackend"
    lb_port                   = "22"
    probe_port                = "22"
    backend_port              = "22"
    probe_protocol            = "Tcp"
    request_path              = "/"
    probe_interval            = 15
    probe_unhealthy_threshold = 2
    load_distribution         = "SourceIPProtocol"
    idle_timeout_in_minutes   = 5
  }
}

LbNatRules = {
  loadbalancernatrules1 = {
    name                    = "springboot-nat-rule"
    lb_key                  = "loadbalancer1"        #Id of the Load Balancer
    frontend_ip_name        = "springbootlbfrontend" #It must equals the Lbs front end
    backend_pool_name       = "springbootlbbackend"
    lb_port                 = "80"
    backend_port            = "22"
    idle_timeout_in_minutes = 5
  }
}


# - Linux VMs

linux_vms = {
  vm1 = {
    name                             = "springboot1"     #(Mandatory) name of the vm
    source_image_reference_offer     = "UbuntuServer"    #(Mandatory) 
    source_image_reference_publisher = "Canonical"       #(Mandatory) 
    source_image_reference_sku       = "18.04-LTS"       #(Mandatory) 
    source_image_reference_version   = "Latest"          #(Mandatory)   
    subnet_name                      = "loadbalancer"    #(Mandatory) Id of the Subnet   
    vm_size                          = "Standard_DS1_v2" #(Mandatory) 
    managed_disk_type                = "Premium_LRS"     #(Mandatory) 
    storage_os_disk_caching          = "ReadWrite"
    zone                             = "1"
    lb_backend_pool_names            = ["springbootlbbackend"]
    assign_identity                  = true
    disable_password_authentication  = true
    disk_size_gb                     = null
    write_accelerator_enabled        = null
    disk_encryption_set_id           = null
    internal_dns_name_label          = null
    enable_ip_forwarding             = null
    enable_accelerated_networking    = null
    dns_servers                      = null
    static_ip                        = null
    enable_cmk_disk_encryption       = true
    recovery_services_vault_key      = "rsv1"
    custom_data_path                 = "//Terraform//Scripts//CustomData.tpl" #Optional
    custom_data_args                 = {name = "VMandVMSS", destination = "EASTUS2", version = "1.0"}
    diagnostics_storage_config_path  = null
  },
  vm2 = {
    name                             = "springboot2"     #(Mandatory) name of the vm
    source_image_reference_offer     = "UbuntuServer"    #(Mandatory) 
    source_image_reference_publisher = "Canonical"       #(Mandatory) 
    source_image_reference_sku       = "18.04-LTS"       #(Mandatory) 
    source_image_reference_version   = "Latest"          #(Mandatory)   
    subnet_name                      = "loadbalancer"    #(Mandatory) Id of the Subnet   
    vm_size                          = "Standard_DS1_v2" #(Mandatory) 
    managed_disk_type                = "Premium_LRS"     #(Mandatory) 
    storage_os_disk_caching          = "ReadWrite"
    zone                             = "1"
    lb_backend_pool_names            = ["springbootlbbackend"]
    assign_identity                  = true
    disable_password_authentication  = true
    disk_size_gb                     = null
    write_accelerator_enabled        = null
    disk_encryption_set_id           = null
    internal_dns_name_label          = null
    enable_ip_forwarding             = null
    enable_accelerated_networking    = null
    dns_servers                      = null
    static_ip                        = null
    enable_cmk_disk_encryption       = true
    recovery_services_vault_key      = "rsv1"
    custom_data_path                 = null #Optional
    custom_data_args                 = null #Optional
    diagnostics_storage_config_path  = null
  }
}


windows_vms = {}

# - Database (MSSQL/MYSQL/Cosmos)
mysql_server_name       = "vmmysql20200516abc"
mysql_database_names    = ["vmmysql20200528abcdb"]
failover_location       = "eastus"
enable_azuresqlfailover = false

#- Private Link Services
private_link_services = {
  pls1 = {
    name                           = "pls007"
    frontend_ip_config_name        = "springbootlbfrontend"
    subnet_name                    = "proxy"
    private_ip_address             = null
    private_ip_address_version     = null
    visibility_subscription_ids    = null
    auto_approval_subscription_ids = null
  }
}


# - Private Endpoint
private_endpoints = {
  pe1 = {
    resource_name            = "mysql"
    name                     = "privateendpointazuresql"
    subnet_name              = "proxy"
    vnet_name                = "jstart007"
    approval_required        = false
    approval_message         = null
    group_ids                = ["mysqlServer"]
    dns_zone_name            = "privatelink.mysql.database.azure.com"
    zone_exists              = false
    zone_to_vnet_link_exists = false
    dns_a_records            = null
  }
}

#- Recovery Services Vaults
recovery_services_vaults = {
  rsv1 = {
    name                = "tfex-recovery-vault"
    policy_name         = "tfex-recovery-vault-policy"
    sku                 = "Standard"
    soft_delete_enabled = false
    backup_settings = {
      frequency = "Daily"
      time      = "23:00"
      weekdays  = null
    }
    retention_settings = {
      daily   = 10
      weekly  = null #"42:Sunday,Wednesday"
      monthly = null #"7:Sunday,Wednesday:First,Last"
      yearly  = null #"77:Sunday:Last:January"
    }
  }
}

# - Application Insights
application_insights = {
  appinsight1 = {
    name                                  = "jstartvm05192016abc"
    application_type                      = "web"
    retention_in_days                     = 60
    daily_data_cap_in_gb                  = null
    daily_data_cap_notifications_disabled = null
    sampling_percentage                   = null
    disable_ip_masking                    = null
  }
}

