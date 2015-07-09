﻿Function Invoke-AzureCommand(
    [parameter(Mandatory=$true)]
    [ValidateNotNull()]
    [scriptblock] $command)
{
    try
    {
        return $command.Invoke()
    }
    catch
    {
        $exception = $_.Exception

        if ($exception.GetType().Name -ne "MethodInvocationException" -or -not (IsAzureCredentialsExpiredException $exception))
        {
            throw
        }

        throw "Your Azure credentials have not been set up or have expired.`n`n" `
            + "If you are working on a private machine to use Get-AzurePublishSettingsFile and Import-AzurePublishSettingsFile.`n`n" `
            + "Otherwise run Add-AzureAccount to set up your Azure credentials."        
    }
}

Function IsAzureCredentialsExpiredException(
    [parameter(Mandatory=$true)]
    [ValidateNotNull()]
    [System.Management.Automation.MethodInvocationException] $exception)
{
    return $exception.Message.Contains("Your Azure credentials have not been set up or have expired, please run Add-AzureAccount to set up your Azure credentials.")
}