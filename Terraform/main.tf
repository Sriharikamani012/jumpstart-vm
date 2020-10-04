# --------------------------------------------------------
# Resources                                              
# --------------------------------------------------------

module "BaseInfrastructure" {
  source                           = "../../common-library/TerraformModules/BaseInfrastructure"
  resource_group_name              = var.resource_group_name
  location                         = var.location
  virtual_networks                 = var.virtual_networks
  subnets                          = var.subnets
  route_tables                     = var.route_tables
  network_security_groups          = var.network_security_groups
  net_additional_tags              = var.net_additional_tags
  sku                              = var.sku               # law sku
  retention_in_days                = var.retention_in_days # law retention_in_days
  base_infra_keyvault_name         = var.base_infra_keyvault_name
  enabled_for_disk_encryption      = true
  network_acls                     = var.network_acls
  base_infra_log_analytics_name    = var.base_infra_log_analytics_name
  base_infra_storage_accounts      = var.base_infra_storage_accounts
  vnet_peering                     = {}
  diagnostics_storage_account_name = var.base_infra_storage_accounts.sa1.name
}

# Private Link Services
module "PrivateLinkServices" {
  source                         = "../../common-library/TerraformModules/PrivateLinkService"
  private_link_services          = var.private_link_services
  resource_group_name            = module.BaseInfrastructure.resource_group_name
  subnet_ids                     = module.BaseInfrastructure.map_subnet_ids
  frontend_ip_configurations_map = module.LoadBalancer.frontend_ip_configurations_map
  pls_additional_tags            = var.additional_tags
}


# Private Endpoints
module "PrivateEndpoint" {
  source              = "../../common-library/TerraformModules/PrivateEndpoint"
  private_endpoints   = var.private_endpoints
  resource_group_name = module.BaseInfrastructure.resource_group_name
  subnet_ids          = module.BaseInfrastructure.map_subnet_ids
  vnet_ids            = module.BaseInfrastructure.map_vnet_ids
  resource_ids        = local.resource_ids
  additional_tags     = var.additional_tags
}

module "LoadBalancer" {
  source                  = "../../common-library/TerraformModules/LoadBalancer"
  load_balancers          = var.Lbs
  resource_group_name     = module.BaseInfrastructure.resource_group_name
  zones                   = var.zones #based on zones will change the LB sku
  subnet_ids              = module.BaseInfrastructure.map_subnet_ids
  lb_additional_tags      = var.additional_tags
  load_balancer_rules     = var.LbRules
  load_balancer_nat_rules = var.LbNatRules
}


module "Virtualmachine" {
  source                       = "../../common-library/TerraformModules/VirtualMachine"
  resource_group_name          = module.BaseInfrastructure.resource_group_name
  key_vault_id                 = module.BaseInfrastructure.key_vault_id
  linux_vms                    = var.linux_vms
  linux_image_id               = var.linux_image_id
  administrator_user_name      = var.administrator_user_name
  administrator_login_password = var.administrator_login_password
  subnet_ids                   = module.BaseInfrastructure.map_subnet_ids
  lb_backend_address_pool_map  = module.LoadBalancer.pri_lb_backend_map_ids         #(Optional set it to null)
  sa_bootdiag_storage_uri      = module.BaseInfrastructure.primary_blob_endpoint[0] #(Mandatory)
  diagnostics_sa_name          = module.BaseInfrastructure.sa_name[0]
  law_workspace_id             = module.BaseInfrastructure.law_workspace_id
  law_workspace_key            = module.BaseInfrastructure.law_key
  vm_additional_tags           = var.additional_tags
}

module "MySqlDatabase" {
  source                              = "../../common-library/TerraformModules/MySqlDatabase"
  resource_group_name                 = module.BaseInfrastructure.resource_group_name
  subnet_ids                          = module.BaseInfrastructure.map_subnet_ids
  allowed_subnet_names                = local.subnet_names
  server_name                         = var.mysql_server_name
  database_names                      = var.mysql_database_names
  administrator_login_password        = var.administrator_login_password
  administrator_login_name            = var.administrator_user_name
  key_vault_id                        = module.BaseInfrastructure.key_vault_id
  mysql_additional_tags               = var.additional_tags
  private_endpoint_connection_enabled = true
}

module "ApplicationInsights" {
  source                       = "../../common-library/TerraformModules/ApplicationInsights"
  resource_group_name          = module.BaseInfrastructure.resource_group_name
  application_insights         = var.application_insights
  app_insights_additional_tags = var.additional_tags
}