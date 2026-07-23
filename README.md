# Enterprise Master Data Management (MDM) Platform on Snowflake

> A metadata-driven, Snowflake-native Master Data Management (MDM) platform built using Snowflake, Snowpark Python, Streams, Tasks, and Streamlit.

---

## 📌 Overview

Organizations often store customer information across multiple systems such as CRM, ERP, E-Commerce, Loyalty, and Customer Support applications. These systems frequently contain duplicate, inconsistent, or incomplete customer records, making it difficult to establish a trusted, enterprise-wide view of the customer.

This project implements a modern, metadata-driven Master Data Management (MDM) platform that consolidates customer data from multiple source systems into a single authoritative **Golden Customer** record.

The platform is designed using Snowflake-native capabilities and follows enterprise software engineering principles such as modular architecture, metadata-driven processing, incremental data pipelines, explainable matching, and operational observability.

---

## 🎯 Objectives

- Build a Snowflake-native MDM platform
- Create a metadata-driven processing framework
- Standardize and validate customer data
- Resolve duplicate customer identities
- Generate Golden Customer records
- Provide complete lineage and auditability
- Support enterprise data stewardship

---

## 🏗 Architecture

> *(Insert Diagram 1 here)*

![Architecture](docs/images/architecture.png)

For detailed architecture, see:

- [Architecture Guide](docs/ARCHITECTURE.md)
- [Technical Design](docs/DESIGN.md)

---

## ✨ Key Features

### Metadata-Driven Processing

- Configuration-driven pipelines
- No source-specific code
- Dynamic onboarding of new source systems

### Snowflake Native

- Internal & External Stages
- Snowpipe
- Streams
- Tasks
- Snowpark Python
- Stored Procedures

### Enterprise MDM

- Standardization
- Data Quality Validation
- Identity Resolution
- Survivorship Rules
- Golden Record Creation
- Cross Reference (XREF)
- Historical Versioning

### Governance

- Pipeline Metadata
- Audit Logs
- Lineage
- Reconciliation
- Manual Review Queue

### Stewardship

- Streamlit Portal
- Golden Record Search
- Data Quality Dashboard
- Pipeline Monitoring

---

## 📂 Project Structure

```text
mdm-platform/

docs/
sql/
snowpark/
streamlit/
tests/
sample_data/
```

---

## 🧱 Technology Stack

| Component | Technology |
|-----------|------------|
| Cloud Data Platform | Snowflake |
| Language | Python |
| Framework | Snowpark |
| UI | Streamlit |
| Orchestration | Snowflake Tasks |
| Incremental Processing | Snowflake Streams |
| Data Loading | Snowpipe / COPY INTO |
| Version Control | GitHub |

---

## 🔄 End-to-End Processing Flow

```text
Enterprise Sources
        │
        ▼
Stages
        │
        ▼
RAW Layer
        │
        ▼
Standardization
        │
        ▼
Data Quality
        │
        ▼
Identity Resolution
        │
        ▼
Survivorship
        │
        ▼
Golden Customer
        │
        ▼
Serving Layer
```

---

## 📚 Documentation

| Document | Description |
|----------|-------------|
| ARCHITECTURE.md | High-level solution architecture |
| DESIGN.md | Detailed technical design |
| DATA_MODEL.md | Database schemas and tables |
| RUNBOOK.md | Deployment and operations guide |

---

## 🚀 Getting Started

### Prerequisites

- Snowflake Account
- Python 3.11+
- Snowpark for Python
- Streamlit

### Deployment

1. Create Snowflake warehouse and database.
2. Execute SQL scripts in sequence.
3. Deploy Snowpark procedures.
4. Upload sample source files.
5. Resume Snowflake Tasks.
6. Launch the Streamlit application.

Detailed instructions are available in **RUNBOOK.md**.

---

## 🛣 Future Enhancements

- Machine Learning–based entity resolution
- Real-time Snowpipe Streaming
- REST APIs for Golden Records
- Integration with external address validation services
- Data Catalog integration
- Event-driven notifications

---

## 👨‍💻 Author

**Dinesh Ahire**

Senior Data Engineer

---

## 📄 License

This project is intended for demonstration and educational purposes.
