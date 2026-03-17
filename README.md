# Sankofa Unified Deployment (SSR)

This repository contains the orchestration and deployment configuration for **Sankofa**, a high-performance analytics platform. It unifies the Go-based processing engine and the Next.js dashboard into a single, scalable Docker environment.

## 🚀 Overview

Sankofa uses a **Unified SSR (Server-Side Rendering)** architecture. This allows for dynamic routing, improved SEO, and a seamless user experience while keeping deployment simple with a single container for the core application services.

### Key Components:
- **Go Engine**: Orchestrates data ingestion, SQL/ClickHouse processing, and authentication.
- **Next.js Dashboard**: A premium, responsive analytics interface built with Tailwind CSS, Tremor, and Nivo charts.
- **ClickHouse**: The "muscle" of the system, handling millions of events with sub-second query performance.
- **SQLite**: The "brain" of the system, managing metadata, user profiles, and project configurations.

---

## 🛠 Prerequisites

- **Docker** & **Docker Compose**
- **Make** (optional, but recommended for the optimized workflow)
- **Node.js 20+** & **Go 1.24+** (only if running locally without Docker)

---

## 🏃 Getting Started

The easiest way to get Sankofa up and running is using the provided `Makefile` and Docker Compose setup.

### 1. Build the Unified Image
This build process is "smart"—it will detect if you have the `server/` and `dashboard/` projects locally. If they are missing, it will automatically clone the latest versions from GitHub.

```bash
make build
```

### 2. Launch the Stack
Start the engine, dashboard, and ClickHouse database.

```bash
make up
```

### 3. Access the Services
- **Dashboard**: [http://localhost:3000](http://localhost:3000)
- **API Engine**: [http://localhost:8080](http://localhost:8080)
- **ClickHouse HTTP**: [http://localhost:8123](http://localhost:8123)

---

## 📂 Repository Structure

- `Dockerfile`: Multi-stage build that compiles the Go binary and builds the Next.js standalone server.
- `docker-compose.yml`: Orchestrates the `sankofa` unified service and the `clickhouse` database.
- `start.sh`: A lightweight process manager that runs both the Go engine and Node.js server concurrently.
- `Makefile`: Convenience commands for building and managing the lifecycle of the containers.
- `.dockerignore`: Optimized to keep build context transfers fast by ignoring unnecessary local artifacts.

---

## 🔧 Configuration

All secrets and configurations are managed via environment variables. Refer to the `.env.example` file in the `server` repository for a full list of available options.

| Variable | Description | Default |
|----------|-------------|---------|
| `APP_PORT` | Port for the Go API | `8080` |
| `NEXT_PUBLIC_API_URL` | Interface for the Dashboard to talk to the API | `http://localhost:8080` |
| `CLICKHOUSE_ADDR` | Address of the ClickHouse server | `clickhouse:9000` |
| `API_SECRET` | Secret key for JWT generation | `super-secret-key` |

---

## 🛡 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
