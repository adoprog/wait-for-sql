FROM mcr.microsoft.com/powershell:lts-nanoserver-1809

SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; $verbosePreference='Continue';"]

USER ContainerAdministrator

RUN "Install-Module SQLServer -Scope AllUsers -Force -Confirm:$False -SkipPublisherCheck"