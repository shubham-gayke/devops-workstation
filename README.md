<div align="center">

# 🛠️ DevOps Workstation

### A modular, framework-driven Bash automation system for bootstrapping a complete DevOps engineering environment

**56 directories · 104 files · 100% Shell · 16 tool domains, one framework**

[Overview](#-overview) • [Architecture](#-architecture) • [Features](#-whats-inside) • [Getting Started](#-getting-started) • [Usage](#-usage) • [Roadmap](#-roadmap)

</div>

---

## 📖 Overview

**DevOps Workstation** is not a pile of install scripts — it's a **modular bootstrap framework** for standing up a fully-equipped DevOps engineering machine (built and tested on Ubuntu / WSL) in a repeatable, predictable way.

Instead of one giant script that installs everything and breaks the moment one tool fails, this project is architected around a **shared core engine** that every domain module (Docker, Kubernetes, Cloud CLIs, IaC, Databases, Monitoring, Security, Languages, and more) plugs into. Each module is independently runnable, independently testable, and independently maintainable — while sharing the same logging, package management, and validation logic underneath.

**Why it exists:** setting up a new dev machine (or a new team member's machine, or a throwaway cloud VM) usually means an afternoon lost to `apt install`, broken PPAs, and forgotten config tweaks. This project turns that afternoon into a single command.

---

## 🏗️ Architecture

The framework follows a **layered, plugin-style architecture**: a thin orchestration layer at the top, a shared core engine in the middle, and independent domain modules at the bottom — all of them consuming the same logging, validation, and package-handling primitives instead of reimplementing them.

```mermaidflowchart TD
    Start(["👤 User runs<br/>install.sh"]):::entry
    Start --> Bootstrap

    subgraph BOOT["🚀 BOOTSTRAP PHASE"]
        direction LR
        Bootstrap["bootstrap.sh<br/>prepares environment"]:::bootstrap
        Loader["loader.sh<br/>discovers modules"]:::bootstrap
        Engine["engine.sh<br/>execution engine"]:::bootstrap
        Bootstrap --> Loader --> Engine
    end

    BOOT --> CORE

    subgraph CORE["🎨 CORE LAYER"]
        direction LR
        Banner["banner.sh"]:::core
        Colors["colors.sh"]:::core
        Logging["logging.sh"]:::core
    end

    CORE --> SYS

    subgraph SYS["🧩 SYSTEM LAYER"]
        direction LR
        Package["package.sh"]:::sys
        System["system.sh"]:::sys
        Validator["validator.sh"]:::sys
    end

    SYS --> Utils["🛠️ utils.sh<br/>shared helper functions"]:::utils
    Utils --> DOMAIN

    subgraph DOMAIN["📦 DOMAIN MODULES · parallel execution"]
        direction LR
        Linux["🐧 linux"]:::domain
        Containers["🐳 docker · ☸️ kubernetes"]:::domain
        CloudIac["☁️ cloud · 🏗️ iac"]:::domain
        Data["🗄️ databases · 📊 monitoring · 🔒 security"]:::domain
        Lang["💻 languages · 🌐 webserver · 📨 message-queue"]:::domain
        Tools["🔧 git · 🔁 ci-cd · 📋 ansible · 🖥️ virtualization · 🧰 utilities"]:::domain
    end

    DOMAIN --> Verify["✅ verify/<br/>post-install validation"]:::verify
    Verify --> Done(["🎉 Fully configured<br/>DevOps workstation"]):::done

    classDef entry fill:#22c55e,stroke:#15803d,stroke-width:2px,color:#ffffff,font-weight:bold
    classDef bootstrap fill:#3b82f6,stroke:#1d4ed8,stroke-width:2px,color:#ffffff
    classDef core fill:#a855f7,stroke:#7e22ce,stroke-width:2px,color:#ffffff
    classDef sys fill:#8b5cf6,stroke:#6d28d9,stroke-width:2px,color:#ffffff
    classDef utils fill:#ec4899,stroke:#be185d,stroke-width:2px,color:#ffffff
    classDef domain fill:#f97316,stroke:#c2410c,stroke-width:2px,color:#ffffff
    classDef verify fill:#14b8a6,stroke:#0f766e,stroke-width:2px,color:#ffffff
    classDef done fill:#22c55e,stroke:#15803d,stroke-width:3px,color:#ffffff,font-weight:bold

    style BOOT fill:#0f172a,stroke:#3b82f6,stroke-width:2px,color:#ffffff
    style CORE fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#ffffff
    style SYS fill:#0f172a,stroke:#8b5cf6,stroke-width:2px,color:#ffffff
    style DOMAIN fill:#0f172a,stroke:#f97316,stroke-width:2px,color:#ffffff
```

**How it flows, step by step:**
1. **Entry point** — the user runs `install.sh`, the single command that kicks off everything.
2. **Bootstrap** — `bootstrap.sh` prepares the environment (checks OS, sets up prerequisites).
3. **Discovery** — `loader.sh` scans and loads whichever domain modules are available/selected.
4. **Execution engine** — `engine.sh` takes over and drives the rest of the run.
5. **Core Layer** — banners, colored output, and structured logging come online first, so every step from here on is consistently logged.
6. **System Layer** — package management, OS detection, and pre-flight validation are initialized so each module can safely check before it installs.
7. **Shared utils** — common helper functions used across all modules are loaded.
8. **Domain execution loop** — the engine walks through each domain in sequence (Linux → Docker/Kubernetes → Cloud/IaC → Databases/Monitoring/Security → Languages/Web/MQ → Git/CI-CD/Ansible/Virtualization/Utilities), each one reusing the same Core + System primitives instead of reimplementing them.
9. **Verification** — the dedicated `verify/` layer checks that what was installed actually works, independent of the install logic itself.
10. **Result** — a fully configured, repeatable DevOps workstation.

---

## 📦 What's Inside

| Domain | Location | Tooling Covered |
|---|---|---|
| 🐧 **Linux Base** | `scripts/linux/` | Core packages, security hardening, monitoring agents, system updates, utilities |
| 🐳 **Docker** | `scripts/docker/` | Docker Engine, Buildx, Compose, install/remove/verify lifecycle |
| ☸️ **Kubernetes** | `scripts/kubernetes/` | kubectl, Helm, Kind, Minikube, full install/remove/verify lifecycle |
| ☁️ **Cloud CLIs** | `scripts/cloud/` | AWS CLI, Azure CLI, GCP CLI, DigitalOcean CLI |
| 🏗️ **Infrastructure as Code** | `scripts/iac/` | Terraform, OpenTofu, Packer |
| 🗄️ **Databases** | `scripts/databases/` | PostgreSQL, MySQL, MariaDB, MongoDB, Redis, Elasticsearch, SQLite |
| 📊 **Monitoring** | `scripts/monitoring/` | Prometheus, Grafana, Loki, Promtail, Node Exporter |
| 🔒 **Security** | `scripts/security/` | Trivy, Gitleaks, Lynis, tfsec, Checkov |
| 💻 **Languages & Runtimes** | `scripts/languages/` | Python, Go, Rust, Java, Node.js, C, C++, .NET |
| 🌐 **Web Servers** | `scripts/webserver/` | Nginx, Apache, Caddy, Tomcat, httpd |
| 📨 **Message Queues** | `scripts/message-queue/` | Kafka, RabbitMQ, NATS |
| 🔧 **Git & VCS** | `scripts/git/` | Git, GitHub CLI, GitLab CLI |
| 🔁 **CI/CD** | `scripts/ci-cd/` | Jenkins, GitHub Actions runner, GitLab Runner |
| 📋 **Configuration Mgmt** | `scripts/ansible/` | Ansible |
| 🖥️ **Virtualization** | `scripts/virtualization/` | Vagrant, VirtualBox |
| 🧰 **CLI Utilities** | `scripts/utilities/` | fzf, ripgrep, bat, eza, jq, yq, k9s, kubectx, lazydocker, tmux, zoxide |

Beyond installers, the repo ships:
- **`configs/`** — curated dotfiles/configs for Bash, Docker, Git, Kubernetes, tmux, and Vim
- **`docs/`** — reference documentation per domain (AWS, Docker, Kubernetes, Linux, Networking, Security, Terraform, Ansible, Git)
- **`backups/`** — backup handling for Bash, Docker, and Git configuration
- **`verify/`** — independent post-install verification scripts, decoupled from install logic
- **`templates/`** — reusable scaffolding for new modules/scripts

---

## 📂 Project Structure

```
devops-workstation/
├── LICENSE
├── README.md
├── assets
├── backups
│   ├── bash
│   ├── docker
│   └── git
├── bin
├── config
│   └── default.conf
├── configs
│   ├── bash
│   ├── docker
│   ├── git
│   ├── kubernetes
│   ├── tmux
│   └── vim
├── docs
│   ├── ansible
│   ├── aws
│   ├── docker
│   ├── git
│   ├── kubernetes
│   ├── linux
│   ├── networking
│   ├── security
│   └── terraform
├── install.sh
├── logs
├── notes
├── projects
├── scripts
│   ├── ansible
│   │   └── install.sh
│   ├── ci-cd
│   │   ├── github-actions.sh
│   │   ├── gitlab-runner.sh
│   │   └── jenkins.sh
│   ├── cicd
│   │   └── jenkins.sh
│   ├── cloud
│   │   ├── aws.sh
│   │   ├── azure.sh
│   │   ├── digitalocean.sh
│   │   └── gcp.sh
│   ├── common
│   │   ├── bootstrap.sh
│   │   ├── core
│   │   │   ├── banner.sh
│   │   │   ├── colors.sh
│   │   │   └── logging.sh
│   │   ├── engine.sh
│   │   ├── loader.sh
│   │   ├── system
│   │   │   ├── package.sh
│   │   │   ├── system.sh
│   │   │   └── validator.sh
│   │   └── utils
│   │       └── utils.sh
│   ├── databases
│   │   ├── elasticsearch.sh
│   │   ├── mariadb.sh
│   │   ├── mongodb.sh
│   │   ├── mysql.sh
│   │   ├── postgresql.sh
│   │   ├── redis.sh
│   │   └── sqlite.sh
│   ├── docker
│   │   ├── buildx.sh
│   │   ├── docker-compose.sh
│   │   ├── docker.sh
│   │   ├── install.sh
│   │   ├── remove.sh
│   │   └── verify.sh
│   ├── git
│   │   ├── git.sh
│   │   ├── github-cli.sh
│   │   └── gitlab-cli.sh
│   ├── iac
│   │   ├── opentofu.sh
│   │   ├── packer.sh
│   │   └── terraform.sh
│   ├── kubernetes
│   │   ├── helm.sh
│   │   ├── install.sh
│   │   ├── kind.sh
│   │   ├── kubectl.sh
│   │   ├── minikube.sh
│   │   ├── remove.sh
│   │   └── verify.sh
│   ├── languages
│   │   ├── c.sh
│   │   ├── cpp.sh
│   │   ├── dotnet.sh
│   │   ├── go.sh
│   │   ├── java.sh
│   │   ├── node.sh
│   │   ├── python.sh
│   │   └── rust.sh
│   ├── linux
│   │   ├── cloud.sh
│   │   ├── databases.sh
│   │   ├── finalize.sh
│   │   ├── install.sh
│   │   ├── languages.sh
│   │   ├── main.sh
│   │   ├── monitoring.sh
│   │   ├── packages.sh
│   │   ├── security.sh
│   │   ├── update.sh
│   │   ├── utilities.sh
│   │   ├── verify.sh
│   │   └── webserver.sh
│   ├── message-queue
│   │   ├── kafka.sh
│   │   ├── nats.sh
│   │   └── rabbitmq.sh
│   ├── monitoring
│   │   ├── grafana.sh
│   │   ├── loki.sh
│   │   ├── node-exporter.sh
│   │   ├── prometheus.sh
│   │   └── promtail.sh
│   ├── security
│   │   ├── checkov.sh
│   │   ├── gitleaks.sh
│   │   ├── install.sh
│   │   ├── lynis.sh
│   │   ├── tfsec.sh
│   │   └── trivy.sh
│   ├── utilities
│   │   ├── bat.sh
│   │   ├── eza.sh
│   │   ├── fzf.sh
│   │   ├── helm.sh
│   │   ├── install.sh
│   │   ├── jq.sh
│   │   ├── k9s.sh
│   │   ├── kubectx.sh
│   │   ├── lazydocker.sh
│   │   ├── ripgrep.sh
│   │   ├── tmux.sh
│   │   ├── yq.sh
│   │   └── zoxide.sh
│   ├── virtualization
│   │   ├── vagrant.sh
│   │   └── virtualbox.sh
│   └── webserver
│       ├── apache.sh
│       ├── caddy.sh
│       ├── httpd.sh
│       ├── nginx.sh
│       └── tomcat.sh
├── templates
└── verify
    ├── cloud
    ├── docker
    ├── kubernetes
    └── linux

56 directories, 104 files
```

---

## 🚀 Getting Started

### Prerequisites
- Ubuntu (native or via **WSL2** on Windows)
- `bash`, `curl`/`wget`, and `sudo` privileges

### Full Bootstrap
```bash
git clone https://github.com/shubham-gayke/devops-workstation.git
cd devops-workstation
chmod +x install.sh
./install.sh
```
This runs the full framework: bootstrap → module discovery → domain installs → verification.

### Selective / Modular Install
Because every domain is self-contained, you can install exactly what you need without running the full bootstrap:

```bash
# Just Docker
./scripts/docker/install.sh

# Just Kubernetes tooling
./scripts/kubernetes/install.sh

# Just security scanners
./scripts/security/install.sh

# Just CLI utilities (fzf, ripgrep, bat, jq, k9s...)
./scripts/utilities/install.sh
```

### Verify an Install
```bash
./verify/docker    # sanity-check the Docker install
./verify/kubernetes
./verify/cloud
./verify/linux
```

---

## 🧭 Usage Philosophy

| Principle | How it shows up in the repo |
|---|---|
| **Modularity** | Every domain (`docker/`, `kubernetes/`, `databases/`...) is a self-contained folder with its own install logic |
| **Reusability** | All modules share one core framework (`common/core`, `common/system`, `common/utils`) instead of duplicating logging/validation code |
| **Separation of Concerns** | Install logic, verification logic, configuration, and documentation each live in their own top-level directory |
| **Idempotent by Design** | `install.sh` / `remove.sh` / `verify.sh` triads exist per domain (see Docker, Kubernetes, Security, Utilities) |
| **Config-Driven** | `config/default.conf` centralizes defaults instead of hardcoding values across scripts |
| **Extensibility** | Adding a new tool means dropping a new script into the right domain folder — the loader/engine picks it up |

---

## 🗺️ Roadmap

The core module set is largely complete. Active/planned work is focused on the layers that turn this from "a great set of scripts" into "a production-grade framework":

- [ ] **Unified orchestration CLI** — a single command with flags (e.g. `--only=docker,k8s`) instead of running scripts individually
- [ ] **Deeper `verify/` coverage** — expand automated post-install checks across every domain
- [ ] **Idempotency & uninstall pass** — ensure every `install.sh` has a matching, tested `remove.sh`
- [ ] **Documentation pass** — flesh out `docs/` per domain with usage guides and troubleshooting
- [ ] **CI validation** — lint/shellcheck and smoke-test scripts on push (GitHub Actions)
- [ ] **Dry-run / logging polish** — structured logs to `logs/` with a `--dry-run` mode

---

## 🤝 Contributing

Contributions are welcome — especially new domain modules, additional verification coverage, or documentation improvements.

1. Fork the repo
2. Create a feature branch (`git checkout -b feature/add-vault-support`)
3. Follow the existing pattern for a domain module (`install.sh` / `remove.sh` / `verify.sh`, using `scripts/common/` for logging & validation)
4. Open a pull request

---

## 📄 License

See the [LICENSE](./LICENSE) file for details.

---

## 👤 Author

**Shubham Gayke**
[GitHub](https://github.com/shubham-gayke)

<div align="center">

If this project is useful to you, consider giving it a ⭐

</div>
