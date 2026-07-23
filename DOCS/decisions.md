# Architecture Decision Records (ADR)

> Version: 1.0  
> Author: Dinesh Ahire  
> Platform: Snowflake Native

---

# Purpose

This document captures the key architectural decisions made during the design of the Enterprise Master Data Management (MDM) Platform.

Each decision records:

- Context
- Decision
- Rationale
- Alternatives Considered
- Trade-offs

---

# ADR-001 — Snowflake Native Architecture

## Decision

Build the platform using Snowflake-native capabilities.

## Rationale

- Reduced operational complexity
- Unified platform
- Elastic compute
- Native governance
- Simplified deployment

## Alternatives

- Databricks
- Spark
- Informatica
- Talend

---

# ADR-002 — Metadata-Driven Processing

## Decision

Store business rules in configuration tables.

## Rationale

Business rules change more frequently than application code.

Benefits include:

- Faster onboarding
- Lower maintenance
- Business flexibility

---

# ADR-003 — Incremental Processing Using Streams

## Decision

Use Snowflake Streams rather than full table refreshes.

## Benefits

- Lower compute cost
- Faster execution
- Reduced data movement

---

# ADR-004 — Snowpark Python

## Decision

Implement business logic using Snowpark Python.

## Why

- Native Snowflake execution
- Reusable code
- Strong Python ecosystem
- Easier testing

Alternatives

- Snowflake Scripting
- External Spark Jobs

---

# ADR-005 — Modular Processing Engines

## Decision

Separate ingestion, DQ, matching, and survivorship into independent engines.

## Benefits

- Easier testing
- Better maintainability
- Independent evolution
- Cleaner architecture

---

# ADR-006 — Medallion Architecture

## Decision

Separate processing into:

- RAW
- CONFORMED
- GOLDEN

## Benefits

- Clear ownership
- Traceability
- Simplified debugging

---

# ADR-007 — Explainable Matching

## Decision

Store attribute-level match scores and survivorship decisions.

## Why

Master Data Management requires transparency.

Every Golden Record should be explainable.

---

# ADR-008 — Streamlit Steward Portal

## Decision

Implement the stewardship UI using Streamlit.

## Benefits

- Native Snowflake integration
- Rapid development
- Python ecosystem
- Low operational overhead

Alternatives

- React
- Angular
- Power Apps

---

# ADR-009 — Metadata & Audit Separation

## Decision

Store metadata separately from business data.

## Benefits

- Cleaner schemas
- Easier monitoring
- Better governance
- Simpler operational support

---

# ADR-010 — Human-in-the-Loop Review

## Decision

Introduce a manual review queue for uncertain matches.

## Why

Automated matching should not merge records with low confidence.

Manual review improves trust and data quality.

---

# ADR-011 — Configuration over Code

## Decision

Prefer configuration changes over application changes whenever possible.

## Examples

- Match thresholds
- Source priorities
- Survivorship rules
- DQ rules

This minimizes deployments and enables faster business adaptation.

---

# ADR-012 — Snowflake Tasks for Orchestration

## Decision

Use Snowflake Tasks to orchestrate processing pipelines.

## Benefits

- Native scheduling
- Dependency management
- Operational simplicity

Alternative

- Apache Airflow

Chosen because this project prioritizes a fully Snowflake-native architecture.

---

# Summary

The Enterprise MDM Platform emphasizes:

- Snowflake-native services
- Metadata-driven processing
- Modular architecture
- Incremental execution
- Explainable business logic
- Enterprise governance
- Operational simplicity

These decisions prioritize maintainability, scalability, transparency, and long-term operational efficiency over short-term implementation speed.