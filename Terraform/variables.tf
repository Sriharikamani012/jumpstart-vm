#############################################################################
# TERRAFORM BACKEND STATE VARIABLES
#############################################################################

variable "tenant_id" {
  description = "Azure tenant Id."
}
variable "subscription_id" {
  description = "Azure subscription Id."
}
variable "client_id" {
  description = "Azure service principal application Id"
}
variable "client_secret" {
  description = "Azure service principal application Secret"
}


#############################################################################
# GENERAL VARIABLES
#############################################################################

variable "resource_group_name" {
  type        = string
  description = "The Azure resource group where your resources will be created"
}

variable "location" {
  type        = string
  description = "The Azure region where your resources will be created"
}

variable "net_additional_tags" {
  type        = map(string)
  description = "A key value pair tags for your resources"
  default = {
    iac = "terraform"
  }
}
variable "additional_tags" {
  type        = map(string)
  description = "A key value pair tags for your resources"
  default = {
    iac = "terraform"
  }
}

variable "base_infra_keyvault_name" {
  type        = string
  description = "The default Keyvault that will be created as part of Base Infrastructure"
}

variable "base_infra_storage_accounts" {
  type        = any
  description = "The default storage account that will be created as part of Base Infrastructure"
}

variable "base_infra_log_analytics_name" {
  type        = string
  description = "The default storage account that will be created as part of Base Infrastructure"
}

variable "administrator_user_name" {
  default = "unset"
}
variable "administrator_login_password" {
  default = "unset"
}

#############################################################################
# VARIABLES
#############################################################################

# -
# - Network object
# -
variable "virtual_networks" {
  type = any
}

variable "subnets" {
  type = any
}

# -
# - Route Table
# -
variable "route_tables" {
  type = any
}

# -
# - Network Security Group
# -
variable "network_security_groups" {
  type = any
}

# -
# - Log Analytics Workspace
# -
variable "sku" {
  type = string
}
variable "retention_in_days" {
  type = string
}
variable "log_analytics_workspace" {
  type = string
}

###### Storage Account

# Container
variable "containers" {
  type        = any
  default     = {}
  description = "map of storage containers."
}

# Blob
variable "blobs" {
  type        = map
  default     = {}
  description = "map of storage blobs."
}

# File Share
variable "file_shares" {
  type        = any
  default     = {}
  description = "map of storage file shares."
}

# Queue
variable "queues" {
  type        = any
  default     = {}
  description = "map of storages queues."
}

# Table
variable "tables" {
  type        = any
  default     = {}
  description = "map of storage tables."
}

###### Key Vault
variable "network_acls" {
  default = null
  type    = any
}

# -
# - Private LoadBalancer
# -
variable "zones" {
  description = "SKU of the load balancer. Basic if empty"
  type        = list(string)
  default     = []
}

variable "Lbs" {
  type    = any
  default = {}
}

variable "LbRules" {
  type    = any
  default = {}
}

variable "LbNatRules" {
  type    = any
  default = {}
}

# -
# - VM
# -

variable "linux_vms" {
  type = any
}

variable "linux_image_id" {
  type        = string
  description = "The ID of an Image which each Virtual Machine should be based on."
  default     = null
}

variable "windows_vms" {
  type = any
}

# variable "vm_prefix" {
#   description = "Prefix used for the VM, Disk and Nic names."
#   default     = "vm"
# }

# -
# - DB
# -

variable "mysql_server_name" {
  type = string
}

variable "mysql_database_names" {
  type = list(string)
}

variable "enable_azuresqlfailover" {
  description = "If set to true, enable mssql failover"
  type        = bool
}
variable "failover_location" {
  type = string
}


# -
# - PRIVATE ENDPOINTS
# -
variable "private_endpoints" {
  type = any
}


# -
# - PRIVATE Link Services
# -
variable "private_link_services" {
  type = any
}


# -
# - Recovery Services Vault
# -
variable "recovery_services_vaults" {
  type = any
}

# -
# - Application Insights
# -
variable "application_insights" {
  type = any
}
