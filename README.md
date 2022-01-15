# wait-for-sql

Source files for https://hub.docker.com/r/adoprog/wait-for-sql. Init container that will wait for specific database to become available.

# usage (helm/k8s):

```
    spec:
      nodeSelector:
        beta.kubernetes.io/os: windows
      initContainers:
        - name: wait-for-sql
          image: adoprog/wait-for-sql:latest-1809
          command: ["pwsh", "-Command", "Import-Module C:\\Users\\ContainerAdministrator\\Documents\\PowerShell\\Modules\\SqlServer\\; do { Start-Sleep -Seconds 3 } until ($(invoke-sqlcmd -ServerInstance $env:Database_Server -U $env:Database_Username -P $env:Database_Password -Query \"select name from sys.databases where name = 'platform_init_ready'\"));"]
          securityContext:
            windowsOptions:
                runAsUserName: "ContainerAdministrator"
          env:
            - name: Database_Server
              valueFrom:
                secretKeyRef:
                  name: sitecore-database
                  key: sitecore-databaseservername.txt
            - name: Database_Username
              valueFrom:
                secretKeyRef:
                  name: sitecore-database
                  key: sitecore-databaseusername.txt
            - name: Database_Password
              valueFrom:
                secretKeyRef:
                  name: sitecore-database
                  key: sitecore-databasepassword.txt
```
