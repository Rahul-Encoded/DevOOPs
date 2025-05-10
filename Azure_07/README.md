# Infrastructure as Code with Terraform & Azure DevOps

## 🔗 End-to-End Overview

```
Developer Commits Terraform Code → Azure Repos (Git) → Build Pipeline (CI) → Plan & Validate Infrastructure → Publish Artifact → Release Pipeline (CD) → Deploy or Destroy Infrastructure in Azure
```

---

### 🔐 Azure CLI Login with Device Code

```bash
az login --use-device-code --allow-no-subscriptions
```

This command initiates device code authentication for logging into Azure, allowing you to authenticate even if no subscriptions are available.

---

### 🤝 Create Service Principal with Contributor Role

```bash
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/00000000-00000-00000-00000-0000000000000"
```

This creates a new **Azure Active Directory service principal** and assigns it the **Contributor role** on the specified subscription.

---

### 🔁 Login Using Service Principal (Non-Interactive)

```bash
az login --service-principal -u <appId> -p <password> --tenant <tenant>
```

Replace `<appId>`, `<password>`, and `<tenant>` with the values from the previous step

This logs in using the service principal credentials for non-interactive automation scenarios.

---

### 🌍 Export Environment Variables for Terraform

```bash
export client_id="00000000-00000-00000-00000-0000000000000"
export client_secret="0000000000000000000000000000000000000000"
export tenant_id="00000000-00000-00000-00000-0000000000000"
export subscription_id="00000000-00000-00000-00000-0000000000000"
```

These environment variables allow Terraform to authenticate with Azure without hardcoding credentials in config files.

---

## 🧱 What is Terraform?

**Terraform** is an open-source tool by HashiCorp that allows you to define and provision infrastructure using declarative configuration files (`.tf`).

### Key Features:
- **Declarative syntax** – Define what you want, not how to do it
- **Provider-based** – Supports AWS, Azure, GCP, Kubernetes, etc.
- **State management** – Tracks real-world infrastructure state
- **Idempotent** – Re-running plans won’t break existing resources

---

## 📦 How Terraform Works (In Short)

![image](Assets\working.png)
![image](Assets\init.png)
![image](Assets\plan.png)
![image](Assets\run.png)

1. **Initialize (`terraform init`)**  
   Downloads provider plugins and sets up backend state storage.

2. **Plan (`terraform plan`)**  
   Shows what will change without making any actual changes.

3. **Apply (`terraform apply`)**  
   Applies changes to match the desired state defined in `.tf` files.

4. **Destroy (`terraform destroy`)**  
   Removes all resources created by Terraform.

---

## 🛠️ Setting Up Azure Backend for Terraform State

![image](Assets\azureplan.png)


To manage infrastructure across teams and pipelines, you need a **remote backend** to store your Terraform state.

### Steps to Set Up Azure Storage Account for Terraform State

Can also be done via the portal
```bash
#!/bin/bash

RESOURCE_GROUP_NAME=demo-resources
STORAGE_ACCOUNT_NAME=techtutorialswithpiyush
CONTAINER_NAME=prod-tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location canadacentral

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME \
--name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME \
--account-name $STORAGE_ACCOUNT_NAME
```

### Configure `backend.tf` in Your Terraform Project

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "demo-resources"
    storage_account_name = "techtutorialswithpiyush"
    container_name       = "prod-tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
```

This stores the **Terraform state file** remotely, ensuring consistency across runs and team members.

---

## 🚀 Azure DevOps CI/CD Pipeline Setup

![image](Assets\IAASCICD.png)

You’ll use a **YAML-based Build Pipeline** and a **Release Pipeline** to automate Terraform workflows.

---

### 🧪 1. Build Pipeline (CI)

#### Purpose:
- Pull code from Azure Repos
- Initialize Terraform
- Validate config
- Format code
- Generate execution plan
- Archive and publish artifact

#### YAML Pipeline Code

```yaml
trigger: 
- main

stages:
- stage: Build
  jobs:
  - job: Build
    pool:
      vmImage: 'ubuntu-latest'
    steps:
    
    # Step 1: Terraform Init
    - task: TerraformTaskV4@4
      displayName: Tf init
      inputs:
        provider: 'azurerm'
        command: 'init'
        backendServiceArm: '${SERVICECONNECTION}'
        backendAzureRmResourceGroupName: 'demo-resources'
        backendAzureRmStorageAccountName: 'DevOops'
        backendAzureRmContainerName: 'prod-tfstate'
        backendAzureRmKey: 'prod.terraform.tfstate'

    # Step 2: Terraform Validate
    - task: TerraformTaskV4@4
      displayName: Tf validate
      inputs:
        provider: 'azurerm'
        command: 'validate'

    # Step 3: Terraform Format
    - task: TerraformTaskV4@4
      displayName: Tf fmt
      inputs:
        provider: 'azurerm'
        command: 'custom'
        customCommand: 'fmt'
        outputTo: 'console'
        environmentServiceNameAzureRM: '${SERVICECONNECTION}'

    # Step 4: Terraform Plan
    - task: TerraformTaskV4@4
      displayName: Tf plan
      inputs:
        provider: 'azurerm'
        command: 'plan'
        commandOptions: '-out $(Build.SourcesDirectory)/tfplanfile'
        environmentServiceNameAzureRM: '${SERVICECONNECTION}'

    # Step 5: Archive Files
    - task: ArchiveFiles@2
      displayName: Archive files
      inputs:
        rootFolderOrFile: '$(Build.SourcesDirectory)/'
        includeRootFolder: false
        archiveType: 'zip'
        archiveFile: '$(Build.ArtifactStagingDirectory)/$(Build.BuildId).zip'
        replaceExistingArchive: true

    # Step 6: Publish Artifact
    - task: PublishBuildArtifacts@1
      inputs:
        PathtoPublish: '$(Build.ArtifactStagingDirectory)'
        ArtifactName: '$(Build.BuildId)-build'
        publishLocation: 'Container'
```

#### Important pipeline Variables
- System.DefaultWorkingDirectory = Where an agent executes a task by default
- BuildDefinition name = The alias to build the artifact
- Build.SourcesDirectory = Where agent checkout ht esource code
- Build.ArtifactStagingDirectory = Where artifacts are archived by default
- Build.BuildId = ID of the build

---

### 🚀 2. Release Pipeline (CD)

#### Two Stages:
1. **Deployment Stage**
2. **Destroy Stage**

These stages allow you to either deploy infrastructure or clean it up after testing.

#### Deployment Stage:
- Download the build artifact
- Run `terraform apply` using the previously generated plan

#### Destroy Stage:
- Run `terraform destroy` to tear down infrastructure

---

## ⚠️ Common Issues & Solutions

### Issue 1: Terraform Can't Find Configuration Files

**Error Message:**
> The directory contains no Terraform configuration files.

**Cause:**
Mismatch between where Terraform commands are executed and where artifacts are published.

**Solution:**
Ensure all Terraform commands run in the same directory where artifacts were extracted.

```bash
Working Directory: $(System.DefaultWorkingDirectory)
Extracted Path: $(System.DefaultWorkingDirectory)/<BuildID>-build/<BuildID>
```

Use consistent paths throughout the pipeline.

---

### Issue 2: Terraform State Locking Conflicts

**Error Message:**
> Lock file already exists

**Cause:**
Multiple pipelines or users trying to modify the same state simultaneously.

**Solution:**
Use remote backend (as configured above) and ensure only one pipeline modifies infrastructure at a time.

---

## 📁 Folder Structure Best Practices

```
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── backend.tf
└── modules/
```

Ensure this structure is preserved in your Git repo and correctly referenced in the pipeline.

---

## 📊 Summary Diagram: Terraform CI/CD Flow

```
+------------------------+
| Developer Commits Code |
+-----------+------------+
            |
            v
+------------------------+
| Azure Repos (Git)      |
+-----------+------------+
            |
            v
+------------------------+
| Azure Build Pipeline   |
| - terraform init       |
| - terraform validate   |
| - terraform plan       |
| - Archive & Publish    |
+-----------+------------+
            |
            v
+------------------------+
| Azure Release Pipeline |
| - terraform apply      |
| - terraform destroy    |
+------------------------+
```

---

## ✅ Final Notes

- **Terraform + Azure DevOps** enables automated, auditable, and scalable infrastructure management.
- Use **remote backend** to store state securely.
- Always validate and plan before applying infrastructure changes.
- Separate **deployment** and **destruction** stages for better control.
- Follow best practices for folder structure, path handling, and error resolution.

---

Would you like me to generate a **PDF version** of this explanation?  
Or would you like a **PowerPoint slide deck** summarizing this for training or presentations?