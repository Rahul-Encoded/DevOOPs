# 📦 Azure CI/CD with Artifacts: Shifting from Build Artifacts to Centralized Packages

## 🎯 Overview

The document explains how to evolve a CI/CD pipeline from directly attaching deployable files to build runs, to treating them as **versioned packages** published to **Azure Artifacts**.

This improves traceability, control, and deployment flexibility across environments like **Staging** and **Production**.

---

## 🧱 Traditional Method: Publishing Build Artifacts Directly

### 🔗 Flow

```
[Code Repository]
        |
        v
[CI Pipeline Run (Build ID: #XXX)]
        |
        +--- npm install
        |
        +--- npm run build
        |
        +--- Publish Build Artifact → [Build Artifacts Storage]
                                        ↓
                                [CD Pipeline]
                                        |
                                        +--- Download Artifact (from Build #XXX)
                                        |
                                        +--- Deploy to Environment
```

### ✅ What Happens?
- Code is built and deployed.
- Artifacts are stored per build ID.
- CD pipeline pulls artifacts based on a specific build number.

### ⚠️ Limitations:
- No central place to store all versions.
- Hard to track which version went where.
- Tightly couples CI and CD — no room for manual approval or environment-specific promotions.

---

## 🚀 New Method: Using Azure Artifacts for Package Management

### 🔗 Flow with Azure Artifacts

```
[Code Repository]
        |
        v
[CI Pipeline Run]
        |
        +--- npm install
        |
        +--- npm run build
        |
        +--- npm publish → [Azure Artifacts Feed (A7-Nike-Feed)]
                                ↓
                [Package Version X.Y.Z in Local View]
                                ↓ (Manual/Automated Promotion)
                  [Package Version X.Y.Z in Pre-release View]
                                ↓ (Trigger Staging CD)
                        [CD Pipeline (Staging)]
                                ↓
                          Deploy to Staging
                                ↓ (Promotion after testing)
                    [Package Version X.Y.Z in Release View]
                                ↓ (Trigger Production CD)
                      [CD Pipeline (Production)]
                                ↓
                       Deploy to Production
```

### ✅ What Happens?
- Instead of publishing raw files, you **publish a formal package** to an **Azure Artifacts feed**.
- You define **views** (`Local`, `Pre-release`, `Release`) to represent stages in your deployment lifecycle.
- CD pipelines trigger when a package is **promoted to a view**, not when a build finishes.

### 🛠️ Implementation Details:
- A feed named `A7-Nike-Feed` is created in Azure DevOps.
- CI pipeline is defined in YAML:
  - Installs dependencies
  - Builds the app
  - Publishes the package to the feed
- Permissions are set so the build service can publish to the feed.
- A **Release Pipeline** is configured:
  - Source: Azure Artifacts
  - Package type: `npm`
  - Trigger: When a new version appears in the `Pre-release` view
  - Deployment step: Azure App Service

---

## 📈 Benefits of Using Azure Artifacts

| Benefit | Description |
|--------|-------------|
| **Centralized Repository** | All deployable versions are stored in one place. Easy to discover and share. |
| **Versioning & Traceability** | Every package version links back to its source commit and build. Audit trail included. |
| **Decoupling Build and Deployment** | CI builds once; CD pipelines deploy the same package multiple times to different environments. |
| **Controlled Rollouts via Views** | Use views like `Pre-release` and `Release` to manage staged deployments. |
| **Lifecycle Management** | Set retention policies to auto-delete old versions. Helps manage storage limits. |
| **Integration with Standard Tools** | Works seamlessly with `npm`, `NuGet`, `Maven`, etc. |
| **Upstream Sources** | Proxy external registries (like npmjs.org) through your feed. Centralize dependency management. |

---

## 🔄 Comparison: Old vs New

| Feature | **Direct Build Artifacts** | **Azure Artifacts** |
|--------|-----------------------------|----------------------|
| Where Artifacts Are Stored | Per-build in Azure Pipelines | Central feed in Azure Artifacts |
| Versioning | Not enforced | Built-in semantic versioning |
| Traceability | Basic (linked to build only) | Rich metadata (commit, build, user, date) |
| Promotion Across Environments | Manual selection of build ID | Automatic via view promotion |
| Control Over Deployment | CI triggers CD directly | CD triggered by package status |
| Reusability | Limited | Same package used across envs |
| Lifecycle Management | Depends on build retention | Customizable policies per feed |
| Integration | Simple file download | Native support for npm, NuGet, etc. |

---

## 🧪 Real-World Example

Let’s say you're deploying a **Nike landing page**:

1. Developer commits code → CI pipeline runs.
2. After successful build, package `@nike/landing-page@1.0.0` is pushed to Azure Artifacts.
3. Initially lands in `Local` view.
4. Team manually promotes it to `Pre-release`.
5. This triggers the **Staging CD pipeline**.
6. After testing, promote to `Release`.
7. Triggers the **Production CD pipeline**.

✅ Result: One build, two deployments — staging and production — both using the **exact same package**.

---

## 🧩 Why This Matters

Using Azure Artifacts turns your build output into a **first-class citizen** in your pipeline:

- It becomes a **versioned package**.
- It flows through your system based on **promotion rules**, not just build completion.
- You get better **control**, **traceability**, and **flexibility**.

This approach aligns with **modern DevOps practices** such as **immutable infrastructure**, **build once, deploy many**, and **pipeline-as-code**.

---

## ✅ Final Notes

- Azure Artifacts helps you move beyond simple file storage to **real package management**.
- It integrates well with standard tools and supports **complex release workflows**.
- Use **views** and **promotion steps** to control what goes where and when.
- Always ensure proper permissions are set so pipelines can publish and consume packages.

---

Would you like me to generate a **PDF version** of this summary?  
Or would you like a **PowerPoint slide deck** summarizing this workflow for training or presentations?