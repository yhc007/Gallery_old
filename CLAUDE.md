# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

`gallery-glasses` (갤러리 안경) is a Korean eyewear retail platform built as a Gradle
multi-module project. Each module is an **independent Spring Boot 2.6.3 application**
(Java 11) that shares one library module, `gallery-core`. The modules do not call each
other at runtime — they are separate deployables that talk to the same MySQL database.

| Module | Role | Packaging | Notable traits |
|--------|------|-----------|----------------|
| `gallery-core` | Shared library (common VOs, AWS S3 config, utils) | plain `jar` (no bootJar) | depended on by every other module |
| `gallery-board` | Customer-facing storefront / admin web | executable `bootJar`, `com.gallery.Application` | legacy MyBatis pattern |
| `gallery-manager` | Back-office manager console | `war` → `ROOT.war`, context-path `/Manager` | **modernized** pattern; deployed to external Tomcat |
| `gallery-staff` | In-store staff app (uses GCM push) | `bootJar`, `com.gallery.Application` | legacy MyBatis pattern |
| `gallery-talk` | Mobile/partner app (uses GCM push) | `bootJar`, `com.gallerytalk.Application` | base package is `com.gallerytalk`, not `com.gallery` |

## Build & Run

Uses the Gradle wrapper (Gradle 7.3.3). Always target a specific module — there is no
aggregate run task.

```bash
./gradlew build                         # build everything
./gradlew :gallery-board:build          # build one module
./gradlew :gallery-board:bootRun        # run a bootJar module locally
./gradlew :gallery-manager:bootWar      # produce ROOT.war for Tomcat deploy
./gradlew :gallery-board:test           # run a module's tests (JUnit 5 / useJUnitPlatform)
./gradlew :gallery-board:test --tests 'com.gallery.SomeTest.someMethod'   # single test
```

Docker (board only): `gallery-board/Dockerfile` runs `build/libs/*.jar` on
`openjdk:11-jdk-alpine`. Build the jar first, then `docker build gallery-board`.

## Configuration & secrets

- DB credentials and other secrets come from a `.env` file loaded via
  `me.paulschwarz:spring-dotenv` — referenced in `application.yml` as `${env.DB_URL}`,
  `${env.DB_USERNAME}`, `${env.DB_PASSWORD}`, and (core) `${env.AWS_ACCESS_KEY}` /
  `${env.AWS_SECRET_KEY}`. Copy `.env.example` to `.env` to set up locally. `.env` is gitignored.
- All modules default to MySQL via HikariCP and `profiles.active: development`.
- AWS S3 region is hardcoded to `AP_NORTHEAST_2` in `gallery-core/.../AwsS3Config.java`.

## Architecture: MVC + MyBatis + JSP/Tiles

Every web module follows a per-feature vertical slice:
`controller/` → `service/` (interface + `*Impl`) → `domain/` (VOs) and SQL mappers.

**View layer (all modules):** Spring MVC resolves JSP views from
`/WEB-INF/views/**` (`prefix`/`suffix` set in `application.yml`). Layout is **Apache
Tiles 3** — `WebConfig` registers a `TilesConfigurer` pointing at
`/WEB-INF/views/layout/layouts.xml`. Many endpoints bypass views entirely and write
JSON/text directly to `HttpServletResponse` (see below).

**There are two distinct persistence patterns — match the one already used in the module you edit:**

1. **Legacy pattern** (`gallery-board`, `gallery-staff`, `gallery-talk`): Service impls
   extend `org.mybatis.spring.support.SqlSessionDaoSupport` and call
   `getSqlSession().selectOne(namespace + "statementId", vo)` where `namespace` is a
   hardcoded string constant (e.g. `"com.gallery.cstmr."`) matching the
   `<mapper namespace="com.gallery.cstmr">` in `src/main/resources/sql/*-sql.xml`.
   Statements are referenced by string, not by a typed interface. Controllers frequently
   serialize results with a `new ObjectMapper()` and write directly to the response
   `PrintWriter` (note the manual `text/html;charset=utf-8` to avoid Korean mojibake).

2. **Modern pattern** (`gallery-manager`): typed `@Mapper` interfaces (e.g. `SecuMapper`)
   injected into services via Lombok `@RequiredArgsConstructor` constructor injection,
   with `@Transactional` on service methods. Requires `mybatis.mapper-locations:
   classpath:sql/*.xml` and `map-underscore-to-camel-case: true`, which are set **only**
   in `gallery-manager/application.yml`. URLs use a `.do` suffix
   (`@RequestMapping("login.do")`); it is packaged as a WAR via
   `SpringBootServletInitializer` and served under context-path `/Manager`.

`gallery-manager` is the in-progress modernization target; prefer its pattern for new
manager code, but stay consistent with the surrounding file elsewhere.

## Conventions

- **VO suffix:** domain objects are named `*Vo` (e.g. `CstmrVo`, `SaleVo`) and used as
  both request-binding command objects and MyBatis params/results.
- **Korean comments and string literals** are normal throughout the codebase.
- Indentation: 4 spaces for `*.java`, 2 spaces elsewhere (`.editorconfig`).
- `gallery-core` must stay a plain library: it sets `bootJar { enabled = false }` /
  `jar { enabled = true }`. Don't add an `Application` class or web entrypoint to it.
- Shared constants exist in **two** places with the same names — `gallery-core`'s
  `com.gallery.common.{CommonCode,CommonURI,...}` and per-module copies under
  `com.gallery.web.common.domain`. Check which one a file imports before editing.
