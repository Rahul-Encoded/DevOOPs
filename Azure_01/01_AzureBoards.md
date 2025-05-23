# 📅 **Azure Boards and Agile Project Management**

This module focuses on how to manage software development projects using **Azure Boards**, part of **Azure DevOps**, and aligning with **Agile and Scrum methodologies**.

---

## 🔗 End-to-End Overview

```
Developer Commits Code → Push to Azure Repos (Git) → Build Pipeline (CI) → Release Pipeline (CD) → Azure Boards (Project Management)
```

---

## 🧩 What is Azure Boards?

**Azure Boards** is a powerful work tracking system in Azure DevOps that helps teams plan, track, and discuss work across their software development lifecycle.

### Key Features:
- Kanban boards
- Sprints (Iterations)
- Work items (Epics, User Stories, Tasks, Bugs, etc.)
- Dashboards & Reports
- Integration with Git repos and CI/CD pipelines

---

## 📌 Core Concepts in Azure Boards

### 1. **Work Items**
A work item is a unit of work that can be tracked and assigned.

| Type        | Description |
|-------------|-------------|
| **Epic**    | Large body of work, often spanning multiple sprints or releases |
| **User Story / Issue** | A small piece of functionality from the user’s perspective |
| **Task**    | A breakdown of a user story into actionable steps |
| **Bug**     | An issue found during testing or production |
| **Feature** | A group of related user stories or a larger functional requirement |

#### Example:
```
Epic: Website Updates
 └── User Story: Homepage Redesign
      ├── Task: Design homepage header
      ├── Task: Standardize fonts
      └── Task: Fix CSS for mobile responsiveness
```

---

### **2. Key Artifacts in Scrum**
These are the primary documents and lists used to manage the project.

| **Artifact**         | **Description**                                                                 |
|----------------------|---------------------------------------------------------------------------------|
| **Product Backlog**   | A prioritized list of all work items (user stories, bugs, etc.) that must be addressed in the project. Managed by the Product Owner. |
| **Sprint Backlog**    | A subset of the product backlog that the Development Team commits to completing during a specific sprint. Owned by the Development Team. |
| **Increment**         | The sum of all completed work from the current sprint plus all previous sprints. Represents the potentially shippable product at the end of each sprint. |

---

### 3. **Kanban Board**
Visualizes workflow stages like **To Do**, **In Progress**, and **Done**.

#### Benefits:
- Visual task management
- Helps identify bottlenecks
- Enables flow-based work prioritization

#### Example View:
```
| To Do              | In Progress          | Done                 |
|--------------------|----------------------|----------------------|
| Homepage Header    | Font Standardization | Mobile CSS Fix       |
```

---

### **4. Ceremonies in Scrum**
These are regular meetings that help keep the team aligned and focused.

| **Ceremony**          | **Frequency** | **Purpose**                                                                 |
|-----------------------|---------------|-----------------------------------------------------------------------------|
| **Sprint Planning**   | Start of Sprint | The team selects work from the product backlog to include in the sprint backlog. |
| **Daily Standup**     | Daily          | Brief meeting where team members share progress, blockers, and plans for the day. |
| **Sprint Review**     | End of Sprint   | Demonstrate completed work to stakeholders and gather feedback. |
| **Sprint Retrospective** | End of Sprint | Reflect on what went well, what could be improved, and plan adjustments for the next sprint. |

---

### 5. **Stakeholders in Agile/Scrum Projects** 

| Stakeholder            | Role |
|------------------------|------|
| **Product Owner**      | Defines and prioritizes the product backlog |
| **Scrum Master**       | Ensures Scrum practices are followed |
| **Development Team**   | Builds and tests the product increment |
| **Stakeholders**       | Provide feedback and validate deliverables |
| **Customers/Users**    | Define needs and use the final product |
| **Management**         | Support the team and remove organizational barriers |
| **External Vendors**   | Provide tools, services, or components |

---

### **6. Additional Elements**
These support the Scrum process and ensure quality and efficiency.

| **Element**           | **Description**                                                                 |
|-----------------------|---------------------------------------------------------------------------------|
| **Impediments**       | Obstacles or issues that hinder the progress of the team. Identified and resolved during daily standups or retrospectives. |
| **Test Cases**        | Specifies conditions to validate that a particular aspect of the system works correctly. Used for testing and ensuring quality. |
| **Acceptance Criteria** | Clear conditions that define when a work item is considered "done." Helps ensure alignment between the team and stakeholders. |

---

## 🧭 Agile vs Scrum vs CMMI vs Basic

| Process Type | Best For | Key Elements |
|--------------|----------|--------------|
| **Basic**    | Simple tracking | Issues, Tasks, Epics |
| **Agile**    | Iterative delivery | User Stories, Tasks, Bugs |
| **Scrum**    | Teams using Scrum framework | Product Backlog, Sprints, Retrospectives |
| **CMMI**     | Regulated environments | Formal processes, traceability, compliance |

---

## 🛠️ Demo Setup Using Azure DevOps Demo Generator

You used the [Azure DevOps Demo Generator](https://azuredevopsdemogenerator.azurewebsites.net) to automatically create a project with dummy data.

### Steps Followed:
1. Navigate to the site
2. Sign in with your Microsoft account
3. Accept permissions
4. Choose **PartsUnlimited** template
5. Create project

This creates:
- Predefined **work items**
- Sample **repositories**
- **Build and release pipelines**
- **Dashboards and reports**

---

### **Visual Representation of Scrum Workflow**

![image](Assets\SCRUM.png)

Here’s a simplified diagram illustrating the flow of work in Scrum:

```
+-------------------+
| Product Backlog   |
| - Epics           |
| 	- Features      |
| 		- User Stories|
| 			- Bugs  |
+-------------------+
          ↓
+-------------------+
| Sprint Planning   |
| - Select work     |
| - Define sprint   |
|   goals           |
+-------------------+
          ↓
+-------------------+
| Sprint Backlog    |
| - Tasks           |
| - Prioritized     |
+-------------------+
          ↓
+-------------------+
| Sprint Execution  |
| - Daily Standups  |
| - Work completion |
+-------------------+
          ↓
+-------------------+
| Sprint Review     |
| - Demo completed  |
|   work            |
| - Gather feedback |
+-------------------+
          ↓
+-------------------+
| Sprint Retrospective |
| - Reflect on       |
|   successes/failures|
| - Plan improvements|
+-------------------+
```

---

### **Key Takeaways**
- **Scrum** is an iterative and incremental framework.
- It uses **work items** like user stories, tasks, and bugs to break down work.
- The **product backlog** and **sprint backlog** help prioritize and track work.
- Regular **ceremonies** (planning, standups, reviews, retrospectives) ensure alignment and continuous improvement.
- **Roles** (Product Owner, Scrum Master, Development Team) have distinct responsibilities to drive success.

---


## ✅ Final Notes

- **Azure Boards** integrates seamlessly with other Azure DevOps services.
- It supports both **Agile** and **Scrum** frameworks.
- You can visualize work with **Kanban boards** and organize it into **sprints**.
- **Acceptance criteria** ensure clarity on what "done" means.
- The **Demo Generator** is a great tool to quickly onboard new teams or learn Azure Boards.

---
