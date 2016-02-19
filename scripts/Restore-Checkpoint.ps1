﻿param(
    [parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string] $Name
)

$ErrorActionPreference = "Stop"
$WarningPreference = "SilentlyContinue"
$VerbosePreference = "SilentlyContinue"

Import-Module Boxstarter.Azure
Import-Module $PSScriptRoot\Library\Library.psm1 -Force

$config = Read-Config

Write-Host "Getting virtual machine '$($config.azure.virtualMachine.name)'..."
$vm = Get-AzureVM -Name $config.azure.virtualMachine.name -ServiceName $config.azure.service.name

Write-Host "Restoring checkpoint '$Name'..."
Restore-AzureVMCheckpoint -VM $vm -CheckpointName $Name