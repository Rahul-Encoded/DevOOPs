# 🚀 End-to-End CI/CD Pipeline using Azure DevOps

## 🔗 Pipeline Overview

```
Developer Code → Azure Repos (Git) → Build Pipeline (CI) → Publish Artifact → Release Pipeline (CD) → Deploy to Staging → Approvals → Quality Gates → Deploy to Production → Swap Slots (Blue-Green)
```

This is a modern **Continuous Integration / Continuous Delivery (CI/CD)** pipeline that uses **Azure DevOps** to automate building, testing, and deploying applications.

---

## 🧱 Azure DevOps Components Involved

| Component             | Description |
|-----------------------|-------------|
| **Azure Repos (Git)** | Source control where application code is stored |
| **Build Pipeline (CI)** | Automates building and testing code |
| **Artifacts**         | Output of the build (e.g., compiled app, Docker image, static files) |
| **Release Pipeline (CD)** | Deploys build output to various environments like Staging or Production |
| **Approvals & Checks** | Manual or automated gates before deployment |
| **Quality Gates**     | Automated checks powered by Azure Monitor and Application Insights |
| **Blue-Green Deployment** | Zero-downtime deployment strategy using two environments |

---

## 🔄 Blue-Green Deployment Strategy

### What is Blue-Green Deployment?

It's a **zero-downtime deployment strategy** where:
- One version of the app is live (**Blue**)
- A new version is deployed to an isolated environment (**Green**)
- Once validated, traffic is switched from Blue to Green

### Why Use It?
- No downtime during deployments
- Easy rollback if something goes wrong
- Safe way to test changes in production-like environment

### Visual Representation

![image](Assets\SWAP.png)

```
Version 1.0:     [Blue APP] ← Live Traffic
Version 2.0:     [Green APP] ← New Deployment

Swap Triggered:
Traffic rerouted to Green → Green becomes new Blue
Old Blue can be reused or deleted
```

### In Azure App Service

You can implement this using **Deployment Slots**:
- `Production` slot (default)
- `Staging` slot (for testing)

Once tested, you can **swap** the slots.

---

## 🛠️ Azure Release Pipeline (CD) Flow

Here’s how the release pipeline works based on your document:

```
Get Artifacts → Deploy to Staging → Run Tests → Approval Required → Quality Gate Check → Deploy to Production → Swap Slots
```

### Phases of Release Pipeline

1. **Get Artifacts**
   - Pulls the built application from the Build Pipeline
   - Usually a `.zip`, static files, or container image

2. **Deploy to Staging**
   - Deploys the artifact to a staging environment (e.g., Azure Web App Slot)

3. **Run Tests**
   - Automated smoke tests or integration tests

4. **Manual Approval**
   - Optional: Requires team member approval before proceeding

5. **Quality Gates**
   - Monitors health via Application Insights
   - Fails the deployment if unhealthy metrics are detected

6. **Deploy to Production**
   - Deploys to the production slot or swaps with staging

7. **Slot Swap**
   - Swaps staging and production slots to go live

---

## 🛡️ What Are Quality Gates in Azure Releases?

### Definition:
**Quality Gates** are automated checks that validate the health of your application before allowing a deployment to proceed.

They use data from **Azure Monitor** and **Application Insights** to check for issues such as:

- High failure rate
- Long response times
- Exceptions
- Dependency failures

### How It Works

1. You define a **baseline** (like average performance over last 5 days)
2. Before deployment, Quality Gates compare current metrics against baseline
3. If anomalies are detected, deployment fails automatically

### Benefits
- Prevent bad releases from going live
- Reduce risk of outages
- Improve reliability of deployments

### Enabling Quality Gates in Azure

To enable Quality Gates:
1. Go to **Azure Portal > Application Insights**
2. Enable **Smart Detection Rules**
3. In **Azure DevOps Release Pipeline**, add a **Pre-deployment Condition**
4. Select **Query Performance Anomalies (Preview)** under "Gates"

### Example Rule:
> “Fail deployment if request failure rate increases by more than 50%”

---

## 📊 Summary Diagram: CI/CD + Blue-Green + Quality Gates

![image](Assets\RELEASE.png)

```
+----------------------------+
| Developer Commits Code     |
+------------+---------------+
             |
             v
+----------------------------+
| Azure Repos (Git)          |
+------------+---------------+
             |
             v
+----------------------------+
| Azure Build Pipeline (CI)  |
| - npm install              |
| - npm run build            |
| - Publish Artifact         |
+------------+---------------+
             |
             v
+----------------------------+
| Azure Release Pipeline (CD)|
| - Get Artifact             |
| - Deploy to Staging        |
| - Run Tests                |
| - Manual Approval          |
| - Quality Gates Check      |
| - Deploy to Production     |
| - Swap Slots               |
+----------------------------+
```

---

## ✅ Final Notes

- **Blue-Green Deployment** ensures zero downtime and safe rollouts.
- **Quality Gates** help prevent faulty deployments using real-time telemetry.
- **Azure DevOps Pipelines** provide a complete toolset for managing CI/CD pipelines from code to cloud.

---

Would you like me to generate a **PDF version of this explanation** as well?  
Or would you like the same content in **Mermaid diagram format** for visual documentation?