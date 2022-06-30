################################################################################################
# This script can be used to check if your computer is compatible with Windows 11              #
# Editor : Christopher Mogis                                                                   #
# Date : 06/30/2022                                                                            #
# Version 1.0                                                                                  #
################################################################################################

#Variable
$Information = "https://www.microsoft.com/en-US/windows/windows-11-specifications"

#Architecture x64
$Arch = (Get-CimInstance -Class CIM_ComputerSystem).SystemType
$ArchValue = "x64-based PC"
if ($Arch -ne $ArchValue)
    #If Architecture is not OK
    {
    Write-Host "Architecture x64 : Not OK" -foregroundcolor "red"
    Write-Host "Please you can see this site for more informations : $Information"
    }

else 

    #If Architecture is OK
    {
    Write-Host "Architecture x64 : OK" -foregroundcolor "green"
    }

#Screen Resolution
$ScreenInfo = (Get-CimInstance -ClassName Win32_VideoController).CurrentVerticalResolution
$ValueMin = 720 
if ($ScreenInfo -le $ValueMin)
    #If Screen resolution is not OK
    {
    Write-Host "Screen resolution support : Not OK" -foregroundcolor "red"
    Write-Host "Please you can see this site for more informations : $Information"
    }

else 

    #If Screen resolution is OK
    {
    Write-Host "Screen resolution support : OK" -foregroundcolor "green"
    }
    
#CPU composition
$Core = (Get-CimInstance -Class CIM_Processor | Select-Object *).NumberOfCores
$CoreValue = 2
$Frequency = (Get-CimInstance -Class CIM_Processor | Select-Object *).MaxClockSpeed
$FrequencyValue = 1000
if (($Core -ge $CoreValue) -and ($Frequency -ge $FrequencyValue))
    {
    Write-Host "Processor is compatible with Windows 11" -foregroundcolor "green"
    }

else

    {
    write-host "Processor is not compatible with Windows 11" -foregroundcolor "red"
    Write-Host "Please you can see this site for more informations : $Information"
    }

#TPM
if ((Get-Tpm).ManufacturerVersionFull20) 
    {
    $TPM2 = -not (Get-Tpm).ManufacturerVersionFull20.Contains(“not supported”)
    }

if ($TPM2 -contains $False)
    #If TPM is not compatible 
    {
    write-host "TPM module is not compatible with Windows 11." -foregroundcolor "red"
    Write-Host "Please you can see this site for more informations : $Information"
    }

else 

    #If TPM is compatible
    {
    write-host "TPM module is compatible with Windows 11." -foregroundcolor "green"
    }

#Secure boot available and activated
$SecureBoot = Confirm-SecureBootUEFI
if ($SecureBoot -ne $True)
    #If Secure Boot is not OK
    {
    Write-Host "Secure boot : Not OK" -foregroundcolor "red"
    Write-Host "Please you can see this site for more informations : $Information"
    }

else 

    #If Secure Boot is OK
    {
    Write-Host "Secure boot : OK" -foregroundcolor "green"
    }

#RAM available
$Memory = (Get-CimInstance -Class CIM_ComputerSystem).TotalPhysicalMemory
$SetMinMemory = 4294967296
if ($Memory -lt $SetMinMemory)
    #If RAM is not OK
    {
    Write-Host "RAM installed : Not OK" -foregroundcolor "red"
    Write-Host "Please you can see this site for more informations : $Information"
    }

else 

    #If RAM is OK
    {
    Write-Host "RAM installed : OK" -foregroundcolor "green"
    }

#Storage available
$ListDisk = Get-CimInstance -Class Win32_LogicalDisk | where {$_.DriveType -eq "3"}
$SetMinSizeLimit = 64GB;
    #Scan Free Hard Drive Space
foreach($Disk in $ListDisk)
    {
   $DiskFreeSpace = ($Disk.freespace/1GB).ToString('F2')
    }

    #If free space is not OK
if ($disk.FreeSpace -lt $SetMinSizeLimit)
    {
    Write-Host "Available space on Hard drive : Not OK" -foregroundcolor "red"
    Write-Host "Please you can see this site for more informations : $Information"
    }

else 

    #If the free space disk is OK
    {
    Write-Host "Available space on Hard drive : OK" -foregroundcolor "green"
    }
