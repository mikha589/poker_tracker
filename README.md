# Poker Tracker 🃏🚀

A professional web application for tracking and analyzing poker sessions. It helps players record their results, analyze win rates, monitor bankroll performance, and make data-driven decisions.

[![CI Pipeline](https://github.com/mikha589/poker_tracker/actions/workflows/ci.yml/badge.svg)](https://github.com/mikha589/poker_tracker/actions)

## 🛠 Tech Stack

* **Backend:** Ruby 3.4+ / Rails 8
* **Database:** PostgreSQL (Primary), Redis (ActionCable / ActiveJob caching)
* **Frontend:** Tailwind CSS / Importmaps
* **Background Processing:** Sidekiq / ActiveJob (asynchronous data export)
* **QA & Security:** StandardRB (Linter), Brakeman (Static Security Analysis), Bundler-Audit

## 🚀 Architecture Highlights (Middle-Level)

* **Query Objects:** Complex aggregations and analytical SQL queries are isolated into dedicated classes (e.g., `PokerStatsQuery`) to maintain thin models and eliminate N+1 query issues.
* **Service Objects:** Core business logic, such as report building and CSV generation, is decoupled from controllers into single-responsibility service classes.
* **Asynchronous Exports:** Heavy tasks like poker history generation run smoothly in background workers, ensuring zero impact on user experience.
* **CI/CD Pipeline:** Fully automated via GitHub Actions. Every push or pull request triggers real-time security scans, code style checks, and test suite execution.

## 🏁 Getting Started

### Prerequisites
Make sure you have the following installed:
* Ruby 3.4.x
* PostgreSQL
* Redis

### Installation

git clone https://github.com/mikha589/poker_tracker.git
cd poker_tracker
