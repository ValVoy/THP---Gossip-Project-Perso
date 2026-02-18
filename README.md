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

## 📊 Database Architecture

The project uses a complex relational schema to handle social interactions efficiently.



<details>
<summary><b>📐 View Entity-Relationship Details</b></summary>

| Table | Role |
| :--- | :--- |
| **USER** | Secure credentials and profile metadata. |
| **GOSSIP** | Core content entity, belongs to a User. |
| **CITY** | Geographic hub linking multiple users. |
| **COMMENT** | Polymorphic (belongs to a Gossip or another Comment). |
| **LIKE** | Polymorphic (belongs to a Gossip or a Comment). |
| **TAG** | N-N association with Gossips. |

</details>

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
*The seed generates 10 users with a default password: password123.*
4. **Launch the server**:
  ```bash
  rails server
  ```

<br>

## 🔍 Key Concepts Learned

### 1. Advanced ActiveRecord
Mastery of has_many :through, Polymorphic associations, and dependent: :destroy to maintain data integrity.

### 2. Custom Security Flow
Implementation of a manual SessionsController to manage the authentication lifecycle (Login -> Session Cookie -> Logout).

### 3. Front-End UX
Using Rails Helpers (link_to, button_to with Turbo) and Flash messages to provide a seamless user experience.

<br>

## 👥 Authors

This project is for educational use within The Hacking Project. Feel free to modify or improve it in your own fork.

Morgan, Romain & Valentin - Backend Foundations.

Valentin - Full-Stack implementation, Security & UI/UX.

_The Hacking Project 2026_
