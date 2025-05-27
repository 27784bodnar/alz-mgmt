module "avd_core_rule_collection_group" {
  #source = "../../modules/rule_collection_groups"
  source = "Azure/avm-res-network-firewallpolicy/azurerm//modules/rule_collection_groups"
  #firewall_policy_rule_collection_group_firewall_policy_id = "/subscriptions/981a6926-cb67-4ff6-95bc-c68e7768d03c/resourceGroups/rg-hub-westeurope/providers/Microsoft.Network/firewallPolicies/fwp-hub-westeurope"
  firewall_policy_rule_collection_group_firewall_policy_id = "module.hub_and_spoke_vnet[0].module.hub_and_spoke_vnet.module.fw_policies.azurerm_firewall_policy.fwp-hub-westeurope"
  firewall_policy_rule_collection_group_name               = "NetworkRuleCollectionGroup"
  firewall_policy_rule_collection_group_priority           = 1000
  firewall_policy_rule_collection_group_network_rule_collection = [{
    action   = "Allow"
    name     = "AVDCoreNetworkRules"
    priority = 500
    rule = [
      {
        name              = "Login to Microsoft"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["login.microsoftonline.com"]
        protocols         = ["TCP"]
        destination_ports = ["443"]
      },
      {
        name                  = "AVD"
        source_addresses      = ["10.100.0.0/24"]
        destination_addresses = ["WindowsVirtualDesktop", "AzureFrontDoor.Frontend", "AzureMonitor"]
        protocols             = ["TCP"]
        destination_ports     = ["443"]
      },
      {
        name              = "GCS"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["gcs.prod.monitoring.core.windows.net"]
        protocols         = ["TCP"]
        destination_ports = ["443"]
      },
      {
        name                  = "DNS"
        source_addresses      = ["10.100.0.0/24"]
        destination_addresses = ["AzureDNS"]
        protocols             = ["TCP", "UDP"]
        destination_ports     = ["53"]
      },
      {
        name              = "azkms"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["azkms.core.windows.net"]
        protocols         = ["TCP"]
        destination_ports = ["1688"]
      },
      {
        name              = "KMS"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["kms.core.windows.net"]
        protocols         = ["TCP"]
        destination_ports = ["1688"]
      },
      {
        name              = "mrglobalblob"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["mrsglobalsteus2prod.blob.core.windows.net"]
        protocols         = ["TCP"]
        destination_ports = ["443"]
      },
      {
        name              = "wvdportalstorageblob"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["wvdportalstorageblob.blob.core.windows.net"]
        protocols         = ["TCP"]
        destination_ports = ["443"]
      },
      {
        name              = "oneocsp"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["oneocsp.microsoft.com"]
        protocols         = ["TCP"]
        destination_ports = ["443"]
      },
      {
        name              = "microsoft.com"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["www.microsoft.com"]
        protocols         = ["TCP"]
        destination_ports = ["443"]
      },
    ]
    }
  ]
}
