[[_TOC_]]
# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

### Changed

## [0.4.1] - 2020-06-02
### Added
- Compatible with Common Library v0.4.1 @ https://dev.azure.com/ATTDevOps/ATT%20Cloud/_git/common-library?version=GTv0.4.1
- Custom arguments to cloud-init script on VM [#89040](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/89040)
- Added optional flag to create multiple DNS A records per Private Endpoint [#81673](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/81673)

## [0.4.0] - 2020-05-19
### Added
- Compatible with Common Library v0.4.0 @ https://dev.azure.com/ATTDevOps/ATT Cloud/_git/common-library?version=GTv0.4.0
- Added Public IP flag (default false) to Load Balancer module [#87243](https://dev.azure.com/ATTDevOps/06a79111-55ca-40be-b4ff-0982bd47e87c/_workitems/edit/87243)
- Added Azure Monitor Module [#87266](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/87266)
- Ability to pass a custom data script to the VM [#75585](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/75585)


## [0.3.0] - 2020-05-08
### Added
- Compatible with Common Library v0.3.0 @ https://dev.azure.com/ATTDevOps/ATT Cloud/_git/common-library?version=GTv0.3.0
- Create Recovery Vault module [#76284](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/76284)
- Added Disk Encryption set for VMSS[#59512](https://dev.azure.com/ATTDevOps/06a79111-55ca-40be-b4ff-0982bd47e87c/_workitems/edit/59512)

### Changed
- Load Balancer Module to support multiple Frontend IP's [#76289](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/76289)
- Removed references to VP Tower [#82735](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/82735)
- Removed $repoPath in favour of $Build.Repository.Name [#82276](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/82276)
- Moved SPN to new MSFT subscription, updated Variables.yaml to reference new subscription resources and updated agent pool [71773](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/71773)

## [0.2.0] - 2020-04-23
### Added
- Compatible with Common Library v0.2.0 @ https://dev.azure.com/ATTDevOps/ATT Cloud/_git/common-library?version=GTv0.2.0
- Private endpoint to diagnostics storage account [#51056](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/51056)
- Load balancer using common-library modules [#51054](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/51054)
- NSG rule to Allow traffic to Azure Monitor Service Endpoint [#9761](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/9761)
- Initial Terraform code, including base infrastrucure module, VM module, and initial PaaS database from common library modules [#13661](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/13661)
- This CHANGELOG [#51067](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/51067)

### Changed

- User must provide unique Log Analytics and Storage Account name for base infrastructure  [#59207](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/59207)
- User must provide unique Keyvault name instead of TF adjusting name to ensure unique  [#57893](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/57893)
- Stage.yaml in kits runs as an one job, which means Terraform.yaml is only tasks [#43423](https://dev.azure.com/ATTDevOps/ATT%20Cloud/)
- Folder structure and names to conform to DevOps Patterns team naming conventions
- Using ImageBuilder v0.2.0 from task [#56822](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/56822)
- Pushed TodoApp Artifact in repo for reference. The /TodoApp folder should be zipped, pushed to Azure Blob storage in VP Shared Services, and retrieved through this pipeline.
- Using VP Shared Services Shared Image Gallery [#23900](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/23900)

## [0.1.0] - 2020-03-23
### Added
- Initial release

[Unreleased]: https://dev.azure.com/ATTDevOps/ATT%20Cloud/_git/jumpstart-vm
[0.1.0]: https://dev.azure.com/ATTDevOps/ATT%20Cloud/_git/jumpstart-vm?version=GTv0.1
[0.2.0]: https://dev.azure.com/ATTDevOps/ATT%20Cloud/_git/jumpstart-vm?version=GTv0.2.0
[0.3.0]: https://dev.azure.com/ATTDevOps/ATT%20Cloud/_git/jumpstart-vm?version=GTv0.3.0
[0.4.0]: https://dev.azure.com/ATTDevOps/ATT%20Cloud/_git/jumpstart-vm?version=GTv0.3.0