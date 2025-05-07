## 🧠 **Overview of the YAML Pipeline**

The pipeline is divided into two main stages:

1. **Build Stage**
2. **Deploy Stage**

Each stage has one or more **jobs**, which run on an agent (e.g., Ubuntu). Each job consists of multiple **steps**, such as installing dependencies, building the app, publishing artifacts, downloading them, and deploying.

---

# 🔁 **Pipeline Trigger**

```yaml
trigger:
- main
```

This means whenever there’s a push to the `main` branch, the pipeline will trigger automatically (**CI - Continuous Integration**).

---

## 🏗️ **Stage 1: Build**

### Job: `Build`
- Runs on: `ubuntu-latest`
- Steps:
  1. Install npm packages using `npm install`
  2. Run custom command: `npm run build` (builds the React app)
  3. Publish the build output (`build/`) as an artifact called `drop`

### Visual Flow

```
[Start Pipeline] → [Trigger on 'main' branch]
                    ↓
              [Stage: Build]
                    ↓
              [Job: Build]
                    ↓
        [Step 1: NPM Install]
                    ↓
      [Step 2: NPM Run Build]
                    ↓
   [Step 3: Publish Artifact 'drop']
```

---

## 🚀 **Stage 2: Deploy**

### Job: `Deploy`
- Runs on: `ubuntu-latest`
- Steps:
  1. Download previously published artifact `drop`
  2. Deploy the artifact to Azure Web App using the **Azure App Service Deployment Task**

### Visual Flow

```
              [Stage: Deploy]
                    ↓
              [Job: Deploy]
                    ↓
     [Step 1: Download Artifact 'drop']
                    ↓
   [Step 2: Azure WebApp Deployment]
```

---

# 📈 YAML vs Classic Editor Analogy

| **Concept**           | **Classic Editor**                             | **YAML**                                 |
|-----------------------|------------------------------------------------|------------------------------------------|
| Pipeline Trigger      | Set via UI (Triggers tab)                      | Defined under `trigger:` section         |
| Stages                | Not natively supported before multi-stage    | Explicitly defined with `stages:`        |
| Jobs                  | Defined per Agent Pool                         | Defined under each `stage`               |
| Steps                 | Drag-and-drop tasks                            | Written as `steps:` under each job       |
| Artifacts             | Use "Publish Artifact" and "Download Artifact" | Same tasks but defined in YAML syntax    |
| Deployment            | Use built-in task like "Azure App Service Deploy" | Same task used inside `AzureRmWebAppDeployment` |

---

# 📦 What Are Artifacts?

In DevOps pipelines, **artifacts** are files that result from your build process. These can include compiled binaries, configuration files, build outputs, or any other file you want to preserve or use in later stages.

### In This Pipeline:
- After running `npm run build`, the React app outputs static files in the `build/` directory.
- That directory is published as an artifact named `drop`.
- The deployment stage downloads this artifact and deploys it to Azure App Service.

### Why Use Artifacts?
- To pass build output from one stage to another.
- For auditing, debugging, or re-deploying builds.
- They provide traceability between builds and deployments.

---

# 🧩 Full YAML Breakdown

```yaml
trigger: 
- main
```

> Triggers the pipeline when changes are pushed to the `main` branch.

```yaml
stages:
- stage: Build
  jobs:
  - job: Build
    pool:
      vmImage: 'ubuntu-latest'
    steps:
    - task: Npm@1
      inputs:
        command: 'install'
```

> Installs all dependencies using `npm install`.

```yaml
    - task: Npm@1
      inputs:
        command: 'custom'
        customCommand: 'run build'
```

> Runs `npm run build` — typically creates a production-ready version of the React app in `/build`.

```yaml
    - task: PublishBuildArtifacts@1
      inputs:
        PathtoPublish: 'build'
        ArtifactName: 'drop'
        publishLocation: 'Container'
```

> Publishes the contents of the `build/` folder as an artifact named `drop` to Azure Pipelines storage.

---

```yaml
- stage: Deploy 
  jobs:
  - job: Deploy
    pool:
      vmImage: 'ubuntu-latest'
    steps:
    - task: DownloadBuildArtifacts@1
      inputs:
        buildType: 'current'
        downloadType: 'single'
        artifactName: 'drop'
        downloadPath: '$(System.ArtifactsDirectory)'
```

> Downloads the previously published artifact `drop` into the system artifacts directory for deployment.

```yaml
    - task: AzureRmWebAppDeployment@4
      inputs:
        ConnectionType: 'AzureRM'
        azureSubscription: 'Tech Tutorials With Piyush (9e9c27ce-e0c8-4171-a368-ad16977ec849)'
        appType: 'webAppLinux'
        WebAppName: 'TechTutorialsWithPiyush'
        packageForLinux: '$(System.ArtifactsDirectory)/drop'
        RuntimeStack: 'STATICSITE|1.0'
```

> Deploys the downloaded artifact to an Azure Linux Web App.

---

# 📊 Summary Diagram: YAML Pipeline Execution Flow

```
+-----------------------------+
|        Git Push to 'main'   |
+------------+----------------+
             |
             v
+----------------------------+
|         Pipeline Triggered |
+------------+-----------------+
             |
             v
+----------------------------+
|         Stage: Build       |
|   +----------------------+ |
|   | Job: Build           | |
|   | Agent: ubuntu-latest | |
|   | Steps:               | |
|   | 1. npm install       | |
|   | 2. npm run build     | |
|   | 3. Publish Artifact  | |
|   +----------------------+ |
+------------+--------------+
             |
             v
+----------------------------+
|         Stage: Deploy      |
|   +----------------------+ |
|   | Job: Deploy          | |
|   | Agent: ubuntu-latest | |
|   | Steps:               | |
|   | 1. Download Artifact | |
|   | 2. Deploy to Azure   | |
|   +----------------------+ |
+----------------------------+
```

---

# ✅ Final Notes

- **Service Connection**: The `azureSubscription` field uses a service connection created in Azure DevOps, which securely connects to your Azure subscription using a **Service Principal**.
- **Caching Settings**: As mentioned in the note, disable caching in Azure App Service:
  ```bash
  WEBSITE_DYNAMIC_CACHE=0
  WEBSITE_LOCAL_CACHE_OPTION=Never
  ```
  This ensures no outdated content is served during deployments.

---

# ✅ Final Flow 
![image](Assets\SERVICE.png)
![image](Assets\FLOW.png)

- A trigger tells a Pipeline to run. It could be CI or Scheduled, manual(if not specified), or after another build finishes.
- A pipeline is made up of one or more stages. A pipeline can deploy to one or more environments.
- A stage organizes jobs in a pipeline, and each stage can have one or more jobs.
- Each job runs on one agent, such as Ubuntu, Windows, macOS, etc. A job can also be agentless.
- Each agent runs a job that contains one or more steps.
- A step can be a task or script and is the smallest building block of a pipeline.
- A task is a pre-packaged script that performs an action, such as invoking a REST API or publishing a build artifact.
- An artifact is a collection of files or packages published by a run.
