CONFORMED_CUSTOMER_STREAM

↓

Load Active Rules

↓

Rule Executor

↓

Evaluate Record

↓

Pass / Reject

↓

Score Calculation

↓

Persist Results

| Category     | Example                       |
| ------------ | ----------------------------- |
| Completeness | Email cannot be NULL          |
| Validity     | Email format                  |
| Consistency  | State belongs to Country      |
| Reference    | Country exists in REF_COUNTRY |
| Uniqueness   | Duplicate Customer ID         |
| Business     | Age >= 18                     |
| Cross-field  | Start Date < End Date         |
