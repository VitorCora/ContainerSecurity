# ContainerSecurity

# TMAS Vulnerability Scanning

## Scan all the images on a $DIRECTORY (path/folder)

This scenario is focused in covering on demand vulnerability scan for all the most common software images hosted on a path.

You will have the capability to scan files using a simple CLI invocation.

This method does not require further access to the Vision One 

- How to create the Vision One API that will be used on the
  - Log into Vision One.
  - On the Vision One Console go to the **Administration** Page and select the **User Roles** Service:
    - Click on **+Add Role**
    - ![image](https://github.com/VitorCora/FileStorageScanning/assets/59590152/507febba-7b19-4d7c-b45f-4cdc1daf6556)
    - On the **Create Custom Role** Page
    - Under General Information:
      - Choose a **Role Name**: eg. v1-tmas-role.
      - Add a **Role Description**: eg. Role to enable SaaS malware scan to be performed
      - ![image](https://github.com/VitorCora/FileStorageScanning/assets/59590152/5ee998c8-744a-4eea-ad4d-b284d6064cfb)
    - Under Permission, select only
      -   Under **Security Functions**
        - Expand **Cloud Security**
          - Expand **Container Security**
            - Tick Run artifact scan
            - ![Screenshot 2024-12-05 at 4 16 05 PM](https://github.com/user-attachments/assets/0e00f267-64c4-4b00-a914-e610a1927f9e)
    - Click **Save**
  - On the Vision One Console go to the **Administration** Page and select the **API Keys** Service:
    - Click on **Add API Key**
    - Choose a **Name**: eg. v1-tmas-api.
    - Choose the recently created role: eg. v1-tmas-api.
    - Set an **Expiration time**
    - Choose a **Description** (Optional): eg. API Key to enable vulnerability scan to be performed 
      - Add a **Role Description**: eg. API Key to enable vulnerability scan to be performed
      - ![image](https://github.com/VitorCora/FileStorageScanning/assets/59590152/888e4704-b4f9-4a21-8d9f-5bfe6bf1ed22)
      - Click **Add**
  - Copy the given API and store it properly 

- How access the TMAS Documentation and guides:
  - Log into Vision One.
  - On the Vision One Console expand the **Cloud Security** Service and then expand the **Cloud Security** Service and select **Container Protection**:
  - Click on the Tab **Container Image Scanning**
  - ![Screenshot 2024-12-05 at 4 51 09 PM](https://github.com/user-attachments/assets/945fa9e9-50b7-4d5e-8738-15e268972511)
  - https://portal.xdr.trendmicro.com/index.html#/app/file-security
  - For the results go to the **Scan Activity** Tab
  - ![image](https://github.com/VitorCora/FileStorageScanning/assets/59590152/56f4c454-0974-416f-8e1a-4c12c5eeaf68)

# Installing the TMAS CLI tool

Follow the following link to get the most up-to date version
  - https://docs.trendmicro.com/en-us/documentation/article/trend-vision-one-install-artifact-scanner#GUID-09957805-70E7-401F-A691-F587FCE2CB8B-ioqa7o

Create the tmas fodler
```
mkdir tmas
```
Download the right package in the instance/microservice that will run the vulnerability analysis and save it to the tmas folder
  eg. for linux
```
wget -0 tmas/trendmicro_tmas_cli.tar.gz   https://cli.artifactscan.cloudone.trendmicro.com/tmas-cli/latest/tmas-cli_Linux_x86_64.tar.gz tmas
```
Extract and install the tmas package
```
tar -xvzf trendmicro_tmas_cli.tar.gz
```

Input the API Key acquired previusly

```
export API_KEY_TMAS={Api_Key_Value}
```

Add the tmas to the $PATH
  - export PATH="/path/to/tmas/binary/directory:$PATH"
eg. Using the tmas folder created previously on the home directory

```
export PATH="/tmas:$PATH"
```


# Running the TMAS CLI tool 

To run the TMAS CLI tool you will need to invoke it using the following command:

On the same folder as it was extracted:
```
./tmas {Command} {Flags}
```

Everywhere else, after adding it to the Path

```
tmas {Command} {Flag}
```

## Commands

The following commands are available:

| Command  | Description |
| ------------- | ------------- |
| scan  | Scan an artifact with any combination of **{artifact}** and **{scanners}** |
| version | Get current CLI version (long). |
| help    | Display help information |

The Scan command requires that an **artifact** and a **scanner** or **scanner Flag** be provided

The **scanner Flag** entry could be:

| scanner  | Description |
| ------------- | ------------- |
| -V  | Scan an artifact for vulnerabilities |
| -M | Scan an artifact for malwares |
| -S    | Scan an artifact for Secrets|
| -VM  | Scan an artifact for vulnerabilities and malwares |
| -VMS | Scan an artifact for vulnerabilities, malwares and secrets |
| -VS    | Scan an artifact for vulnerabilities and Secrets|
| -MS    | Scan an artifact for Malwares and Secrets|
  
  eg. To scan a Docker image for vulnerabilities, malwares and secrets

```
tmas scan docker:vulnerables/web-dvwa -VMS
```

Alternatively the CLI tool can also be invoked with a explicit scanner

```
tmas scan {scanner} {artifact} {Flags}
```
The **scanner** entry could be:

| scanner  | Description |
| ------------- | ------------- |
| vulnerabilities  | Scan an artifact for vulnerabilities |
| malware | Scan an artifact for malwares |
| secrets    | Scan an artifact for Secrets|

  eg. To scan a Docker image for vulnerabilities

```
tmas scan vulnerabilities docker:vulnerables/web-dvwa
```

## Flags



You can alternatively also invoke the CLI tool as follows:

```
tmas scan {scanner} {artifact} {Flags}
```

The **scanner** entry could be 


By default, the 


# Using a CLI code to find all the images and 

Under construction

## Installing the SDK
  
Under construction

## References

TMAS main documentation page:
  - https://docs.trendmicro.com/en-us/documentation/article/trend-vision-one-artifact-scanner-tmas

TMAS how to use:
  - https://docs.trendmicro.com/en-us/documentation/article/trend-vision-one-artifact-scanner-cli#GUID-09957805-70E7-401F-A691-F587FCE2CB8B-galxw

TMAS Download page:
  - https://docs.trendmicro.com/en-us/documentation/article/trend-vision-one-install-artifact-scanner#GUID-09957805-70E7-401F-A691-F587FCE2CB8B-ioqa7o

TMAS overrides for vulnerabilities and secret findings:
  - https://docs.trendmicro.com/en-us/documentation/article/trend-vision-one-override-vulnerability-findings#GUID-09957805-70E7-401F-A691-F587FCE2CB8B-lvqfnb

TMAS examples:
  - https://docs.trendmicro.com/en-us/documentation/article/trend-vision-one-tmas-examples#GUID-F8FAF1DF-7A1E-4C0A-ADA3-6F6FC6CAD49D-diki85



