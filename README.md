# ContainerSecurity

# TMAS Vulnerability Scanning

Trend Micro Artifact Scanner (TMAS) performs pre-runtime image, vulnerability, malware, and secret scans on artifacts, enabling you to identify and fix issues before they reach a production environment, like Kubernetes for container images.

Supported Artifacts

| Supported operating systems  | 
| ------------- | 
| Alpine | 
| Amazon Linux |
| BusyBox |
| CentOS |
| Debian |
| Distroless |
| Oracle Linux |
| Red Hat (RHEL) |
| Ubuntu |

| Supported programming languages |
| ------------- |
| Java (JAR, WAR, EAR, JPI, HPI) |
| JavaScript (NPM, Yarn) |
| Python (Egg, Wheel, Poetry, requirements.txt/setup.py files) |
| Dotnet (deps.json) |
| Golang (go.mod) |
| PHP (Composer) |
| Rust (Cargo) |

## Scaning images with TMAS

This scenario is focused in covering on demand vulnerability scan for all the most common software images hosted on a path.

You will have the capability to scan files using a simple CLI invocation.

This method does not require further access to the Vision One 

- How to create the Vision One API that will be used on the
  - Log into Vision One.
  - On the Vision One Console go to the **Administration** Page and select the **User Roles** Service:
    - ![Screenshot 2024-12-06 at 1 44 01 PM](https://github.com/user-attachments/assets/f533842b-6c3e-4443-850b-908af35bb5c6)
    - Click on **+Add Role**
    - ![Screenshot 2024-12-06 at 1 43 40 PM](https://github.com/user-attachments/assets/408ca305-8e7c-4d0b-833c-6d42c1c9a79f)

    - On the **Create Custom Role** Page
    - Under General Information:
      - Choose a **Role Name**: eg. v1-tmas-role.
      - Add a **Role Description**: eg. Role to enable SaaS malware scan to be performed
      - ![Screenshot 2024-12-05 at 4 36 38 PM](https://github.com/user-attachments/assets/606d4975-f5c3-4547-85a6-5f9992391bbb)
    - Under Permission, select only
      -   Under **Security Functions**
        - Expand **Cloud Security**
          - Expand **Container Security**
            - Tick Run artifact scan
            - ![Screenshot 2024-12-05 at 4 16 05 PM](https://github.com/user-attachments/assets/0e00f267-64c4-4b00-a914-e610a1927f9e)
    - Click **Save**
  - On the Vision One Console go to the **Administration** Page and select the **API Keys** Service:
    - Click on **Add API Key**
    - ![Screenshot 2024-12-06 at 1 39 25 PM](https://github.com/user-attachments/assets/77e07e95-aa8f-4253-b301-c872289b67f2)
    - Choose a **Name**: eg. v1-tmas-api.
    - Choose the recently created role: eg. v1-tmas-api.
    - Set an **Expiration time**
    - Choose a **Description** (Optional): eg. API Key to enable vulnerability scan to be performed 
      - Add a **Role Description**: eg. API Key to enable vulnerability scan to be performed
      - ![Screenshot 2024-12-06 at 1 42 11 PM](https://github.com/user-attachments/assets/6179f577-a644-4a36-baf8-f77322a54f62)
      - Click **Add**
  - Copy the given API and store it properly 

- How access the TMAS Documentation and guides:
  - Log into Vision One.
  - On the Vision One Console expand the **Cloud Security** Service and then expand the **Cloud Security** Service and select **Container Protection**:
  - Click on the Tab **Container Image Scanning**
  - ![Screenshot 2024-12-05 at 4 51 09 PM](https://github.com/user-attachments/assets/945fa9e9-50b7-4d5e-8738-15e268972511)

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

The **artifact** entry could be:

| Command  | Description |
| ------------- | ------------- |
| docker:yourrepo/yourimage:tag | Use images from the Docker daemon. |
| podman:yourrepo/yourimage:tag | Use images from the Podman daemon. |
| docker-archive:path/to/yourimage.tar | Use a tarball from disk for archives created from docker save. |
| oci-archive:path/to/yourimage.tar | Use a tarball from disk for OCI archives (from Skopeo or otherwise). |
| oci-dir:path/to/yourimage | Read directly from a path on disk for OCI layout directories (from Skopeo or otherwise). |
| singularity:path/to/yourimage.sif | Read directly from a Singularity Image Format (SIF) container on disk. |
| registry:yourrepo/yourimage:tag | Pull image directly from a registry (no container runtime required). |
| dir:path/to/yourproject | Read directly from a path on disk (any directory). |
| file:path/to/yourproject/file | Read directly from a path on disk (any single file). |

Using the dir artifact, the TMAS scanner will look for a manifest on the target folder, it will not scanner multiple images present in the that target directory, it will be taken care later by an example program later on this repo.

This program can be found on the following path as well:
  - https://github.com/VitorCora/ContainerSecurity/tmasdirscanner.sh

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

The following Flags are available to be used with the CLI tool

| Flag  | Description |
| ------------- | ------------- |
| -p, --platform | Specify platform for multi-platform container image sources. For example: linux/arm64,  linux/arm64/v8, arm64, linux.
Default is linux/amd64. |
| -r, --region | Trend Vision One service regions: ap-southeast-2, eu-central-1, ap-south-1, ap-northeast-1, ap-southeast-1, us-east-1.
Default is us-east-1. |
| -V, --vulnerabilities | Enable scanning for vulnerabilities (optional). |
| -M, --malware | Enable scanning for malware (optional). Supports docker, docker-archive, oci-archive, oci-dir and registry artifact types. |
| -S, --secrets | Enable scanning for secrets (optional). |
| -o, --override | Specify the file path to the file containing the vulnerability and secret override rules (optional). For example: /path/to/tmas_overrides.yml. |
| --saveSBOM | Save SBOM in the local directory (optional). |
| -v, --verbose | Increase verbosity (-v = info, -vv = debug). |
| -h, --help | Display help information. |

## Saving results to a file

By default, the TMAS CLI tool will not save the scan results to a file, only presenting them in the CLI and sharing the content with the linked Vision One account, so the following is recommended when running it, if a json file is needed:
  eg. Scanning for **vulnerabilities and secrets** on an image and saving the results as a file named **scan_results_${imagename}.json**

```
tmas scan file:/${imagefolder}/${imagename} -VS > "scan_results_${imagename}.json
```

## Using a CLI code to find all the images on a folder and scan all of them

To scan multiple files in the same folder, we have build a script 


```
#!/bin/bash

# Input the path variable
folder={/path/to/images_to_scan}

cd ~
cd $folder

# Find all software image files recursively and store them in an array
files=($(find . -type f \( -iname "*.iso" -o -iname "*.tar" -o -iname "*.tar.gz" -o -iname "*.tgz" -o -iname "*.tar.bz2" -o -iname "*.tar.xz" -o -iname "*.zip" -o -iname "*.rar" -o -iname "*.7z" -o -iname "*.img" -o -iname "*.vmdk" -o -iname "*.vhd" -o -iname "*.qcow2" -o -iname "*.nrg" -o -iname "*.mds" -o -iname "*.mdf" -o -iname "*.cue" -o -iname "*.bin" -o -iname "*.dmg" -o -iname "*.udf" \)))

# Print the number of files found
echo "Found ${#files[@]} files"

# Loop through each file and run the tmas command
for file in "${files[@]}"; do
    echo "Processing $file"
    # Replace slashes with underscores for the output file name
    output_file=$(echo "$file" | tr '/' '_')
    tmas scan file:"$file" -V -vv > "scan_result_${output_file}.json"
done
```

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

Integrating TMAS results with a CICD pipeline:
  - https://docs.trendmicro.com/en-us/documentation/article/trend-vision-one-artifact-scanner-results-policies


