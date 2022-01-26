# hhdb
HH db generation

![PostgreSQL - hh@localhost](https://user-images.githubusercontent.com/23243577/151225063-bfda5f7f-6d78-4bfb-8b1f-364bcb8b66b0.png)

**Features:**
- [x] Liquibase
- [x] Indexes
- [x] User generation

**Steps:**

1. **DB creating.** By default, PostgreSQL is configured, but driver can be changed. Example for creating PostgreSQL DB from psql:
```
postgres=# create database hh;
postgres=# create user statuser with encrypted password '12345';
postgres=# grant all privileges on database hh to statuser;
```
2. **Update db scema and data**
liquibase update

3. **Delete db scema and data**
liquibase rollbackCount 2
