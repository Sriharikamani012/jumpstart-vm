locals {
  resource_ids = {
    mysql    = module.MySqlDatabase.mysql_server_id
  }
  subnet_names = [for s in module.BaseInfrastructure.map_subnets : s.id]
}