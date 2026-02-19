# 🗣️ The Gossip Project (Full-Stack Edition)

[![Ruby](https://img.shields.io/badge/Ruby-3.4.2-red?style=for-the-badge&logo=ruby)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-8.1.2-CC0000?style=for-the-badge&logo=rubyonrails)](https://rubyonrails.org/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-563D7C?style=for-the-badge&logo=bootstrap)](https://getbootstrap.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

Welcome to the **Gossip Project**, a fully functional social platform built during **The Hacking Project (THP)** bootcamp. This application features a secure authentication system, polymorphic likes, and a modern Dark Mode interface.



<br>

## 🚀 Key Features

### 🔐 Security & Authentication
- **Custom Auth**: Built from scratch using `BCrypt` (no Devise).
- **Remember Me**: Persistent login system using signed cookies and secure tokens.
- **Permissions**: Ownership checks ensure only authors can edit/delete their content.
- **Validations**: Robust ActiveRecord validations with dynamic error messages.

### 💬 Social Interactions
- **Polymorphic Likes**: Like/Unlike system for both gossips and comments.
- **Nested Comments**: Interactive comment threads within each gossip.
- **Urban Hubs**: Explore gossips filtered by city.

### 🎨 Modern UI
- **Dark Mode**: Sleek interface built with Bootstrap 5.3.
- **Responsive**: Fully optimized for mobile and desktop.

<br>

## 🛠️ Installation & Setup

1. **Clone the repository**:
    ```bash
    git clone [https://github.com/DevRedious/gossip-project.git](https://github.com/DevRedious/gossip-project.git)
    cd gossip-project
    ```
    
2. **Install dependencies**:
    ```bash
    bundle install
    ```
3. **Database setup & Seed**:
    ```bash
    rails db:create
    rails db:migrate
    rails db:seed
    ```
*The seed generates users with a default password: password.*
4. **Launch the server**
    ```bash
    ./bin/dev
    ```

<br>

## 🏭 Running in Production Mode (Locally)

If you want to test the application in a real-world environment without deploying to Heroku, follow these steps.

[!IMPORTANT]

Make sure to close your development server (./bin/dev) before starting the production server to avoid port conflicts.

1. **Precompile Assets**
Since the code is "frozen" in production, you must precompile CSS and JS:
    ```bash
    SECRET_KEY_BASE=$(rails secret) RAILS_ENV=production rails assets:precompile SKIP_CSS_BUILD=true
    ```
2. **Prepare Database**
Rails 8 requires specific databases for primary data, cache, and queues:
    ```bash
    SECRET_KEY_BASE=$(rails secret) RAILS_ENV=production rails db:prepare
    ```
3. **Launch Production Server**
    ```bash
    SECRET_KEY_BASE=$(rails secret) RAILS_ENV=production bin/rails server
    ```

### 🧹 Back to Development
Once finished, you must clean the precompiled assets to see your code changes again in development mode:

    ```bash
    rails assets:clobber
    ```

you can find more information here -> https://guides.rubyonrails.org/asset_pipeline.html

<br>

## 🔍 Key Concepts Learned

### 1. Cookie-Based Persistence
Implementation of a "Remember Me" feature using cookies.permanent.signed and a remember_digest in the database to securely store user sessions.

### 2. Advanced ActiveRecord
Mastery of has_many :through, Polymorphic associations (for comments and likes), and dependent: :destroy to maintain data integrity.

### 3. Production Hardening
Understanding the differences between environments: asset pipeline minification, security headers, and encrypted credentials.

<br>

## 👥 Authors

This project is for educational use within The Hacking Project. Feel free to modify or improve it in your own fork.

Morgan, Romain & Valentin - Backend Foundations.

Valentin - Full-Stack implementation, Security, Persistence & UI/UX.

_The Hacking Project 2026_
