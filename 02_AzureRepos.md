# 🧾 Understanding **Azure Repos**

## 🔗 Overview

```
Developer Writes Code → Commit to Azure Repos (Git) → Build Pipeline (CI) → Release Pipeline (CD) → Deployment to Azure App Service
```

**Azure Repos** is a core component of **Azure DevOps Services** that provides **version control capabilities** for your codebase. It helps teams collaborate efficiently by managing source code changes over time.

---

## 📂 What is Azure Repos?

**Azure Repos** is Microsoft’s version control system integrated into Azure DevOps. It allows developers to:

- Store, manage, and track changes in source code
- Collaborate across teams
- Integrate with CI/CD pipelines
- Maintain history and rollback to any point in time

### Key Features:
- Supports both **Git** and **TFVC** (Team Foundation Version Control)
- Integrates with Azure Pipelines for **CI/CD**
- Built-in pull requests, branch policies, and code reviews
- Compatible with popular IDEs like VSCode, Visual Studio, and JetBrains tools

---

## 🔄 Git vs TFVC – A Comparison

| Feature | **Git (Distributed)** | **TFVC (Centralized)** |
|--------|------------------------|--------------------------|
| **Type** | Distributed Version Control System (DVCS) | Centralized Version Control System |
| **Local Repository** | Full copy of repository & history on local machine | Only working files are stored locally |
| **Branching Model** | Lightweight and easy branching | Heavyweight branches; more complex |
| **Offline Support** | Yes – commit, branch, merge offline | No – requires connection to server |
| **Use Case** | Modern development, open-source, microservices | Enterprise apps, legacy systems |
| **Popular Hosting Platforms** | GitHub, GitLab, Bitbucket, Azure Repos | TFS, Perforce, SVN, Azure Repos |
| **Performance** | Fast for most operations | Slower due to centralized model |

> 💡 **Recommendation**: Use **Git** unless you're working in a highly regulated or enterprise environment where TFVC is required.

---

## 🌿 Working with Branches in Git

Branching is one of the most powerful features in Git. It allows multiple versions of the code to exist simultaneously.

### Common Branching Strategies:

#### 1. **Main / Master Branch**
- The stable, production-ready version of your app
- Should always be deployable

#### 2. **Develop Branch**
- Integration branch for ongoing development
- Merges into `main` when ready for release

#### 3. **Feature Branch**
- Created off `develop` for new features
- Once complete, merged back into `develop`

#### 4. **Release Branch**
- Created from `develop` when preparing for a release
- Used for final testing and hotfixes before merging into `main`

#### 5. **Hotfix Branch**
- Created off `main` to fix urgent issues in production
- Merged back into both `main` and `develop`

### Visual Representation of Git Flow

```
main ────────────────●───────────────────●
                     ↑                    ↑
release        [Release v1.0]     [Release v2.0]
                     ↓
develop    ○───────○───────○───────○───────○
            \       \       \
feature1    ●──●    ●       ●
feature2        ●──●
hotfix          ●────────●
```

![image](Assets\REPO.png)

---

## 🛠️ Benefits of Using Version Control (Git)

| Benefit | Description |
|--------|-------------|
| **Track Changes** | See who made what change and why |
| **Collaboration** | Multiple developers can work on the same project without conflict |
| **Rollback** | Revert to a previous state if something breaks |
| **Branching & Merging** | Safely develop features without affecting main codebase |
| **Audit Trail** | View full history of every file and commit |
| **Integration** | Works seamlessly with CI/CD pipelines (Azure Pipelines, GitHub Actions, Jenkins, etc.) |

---

## 🧪 Integration with CI/CD Pipelines

Azure Repos integrates tightly with **Azure Pipelines** for continuous integration and delivery.

### Example Workflow:

1. Developer pushes code to feature branch in Azure Repos
2. Pull request created → triggers build pipeline
3. If tests pass, code is merged into `develop` or `main`
4. Build pipeline runs:
   - Installs dependencies (`npm install`, `dotnet restore`, etc.)
   - Builds application (`npm run build`, `dotnet build`)
   - Publishes artifact
5. Release pipeline picks up artifact and deploys to staging or production

### Diagram: CI/CD with Azure Repos

```
+-------------------+
| Developer Machine |
| - Write code      |
| - Git commit      |
+---------+---------+
          |
          v
+-------------------+
| Azure Repos (Git) |
| - Feature Branch  |
| - Develop Branch  |
| - Main Branch     |
+---------+---------+
          |
          v
+-------------------+
| Pull Request      |
| - Code Review     |
| - Trigger Build   |
+---------+---------+
          |
          v
+-------------------+
| Azure Build Pipeline (CI) |
| - npm install     |
| - npm run build   |
| - Publish Artifact|
+---------+---------+
          |
          v
+-------------------+
| Azure Release Pipeline (CD) |
| - Deploy to Staging |
| - Manual Approval |
| - Deploy to Prod  |
+-------------------+
```

---

## 🧰 Tools That Work with Azure Repos

| Tool | Integration |
|------|-------------|
| **VSCode** | Native Git support + Azure Repos plugin |
| **Visual Studio** | Built-in Git & TFVC support |
| **GitHub Desktop** | Can connect to Azure Repos |
| **Git Bash / CLI** | Standard Git commands |
| **IDEs like IntelliJ, PyCharm** | Plugin-based Git support |

---

## ✅ Final Notes

- **Azure Repos** supports both **Git** and **TFVC**, but **Git is recommended** for modern development.
- Use **branching strategies** like GitFlow or GitHub Flow to manage code changes safely.
- **Version control** gives you visibility, traceability, and rollback capabilities.
- **Azure Repos integrates perfectly** with Azure Pipelines for end-to-end CI/CD automation.
- Use the **Demo Generator** to onboard teams quickly with sample data and workflows.

---
