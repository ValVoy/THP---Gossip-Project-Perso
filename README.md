# The Gossip Project (Rails Edition)

![Ruby](https://img.shields.io/badge/Ruby-3.4.2-red) ![Rails](https://img.shields.io/badge/Rails-8.1.2-red) ![Gems](https://img.shields.io/badge/Gems-Faker-blue)

Welcome to **The Gossip Project**, a database-centric project created as part of **The Hacking Project (THP)** bootcamp.
The goal of this project is to master **ActiveRecord** and complex database relationships (1-N, N-N, and polymorphic associations) by building a functional backend for a social network where users post gossips, tag them, comment (including comment-on-comment), like, and send private messages.

## Prerequisites

- **Ruby** (version 3.4.2)
- **Rails** (version 8.1.x)
- **Gems**: `faker` (for generating seed data)

## Database Architecture

![The Gossip Project](the-gossip-project.svg)

This project implements a relational schema to manage users, cities, gossips, tags, comments (with comment-on-comment), likes (on gossips or comments), and private messages.

### Entities and Attributes (ERD)

| Table                         | Attributes                                                                                         |
| ----------------------------- | -------------------------------------------------------------------------------------------------- |
| **CITY**                      | `name`, `zip_code` (string)                                                                        |
| **USER**                      | `first_name`, `last_name`, `email` (string), `description` (text), `age` (integer), `city_id` (FK) |
| **GOSSIP**                    | `title` (string), `content` (text), `user_id` (FK)                                                 |
| **TAG**                       | `title` (string)                                                                                   |
| **JOIN_TABLE_GOSSIP_TAG**     | `gossip_id`, `tag_id` (FK)                                                                         |
| **PRIVATE_MESSAGE**           | `content` (text), `sender_id` (FK → users)                                                         |
| **PRIVATE_MESSAGE_RECIPIENT** | `private_message_id`, `recipient_id` (FK → users)                                                  |
| **COMMENT**                   | `content` (text), `user_id` (FK), `commentable_type`, `commentable_id` (polymorphic)               |
| **LIKE**                      | `user_id` (FK), `likeable_type`, `likeable_id` (polymorphic)                                       |

Rails automatically adds `id` (PK) and `created_at` / `updated_at` to each table.

### Relationships (ERD)

- **CITY** → 1-N → USER
- **USER** → 1-N → GOSSIP ; **GOSSIP** → N-1 → USER
- **GOSSIP** ↔ N-N ↔ TAG via JOIN_TABLE_GOSSIP_TAG
- **PRIVATE_MESSAGE** → N-1 → USER (sender) ; **PRIVATE_MESSAGE** ↔ N-N ↔ USER (recipients) via PRIVATE_MESSAGE_RECIPIENT
- **COMMENT** → N-1 → USER ; **COMMENT** → polymorphic → GOSSIP or COMMENT (comment-on-comment)
- **LIKE** → N-1 → USER ; **LIKE** → polymorphic → GOSSIP or COMMENT

### Model Relationships (code)

- **City**: A central hub. Users belong to a City.
- **User**: Has many gossips, comments, and likes. Sends and receives private messages (sender / recipients via `class_name`).
- **Gossip**: Belongs to a user. Has many tags through `JoinTableGossipTag`. Has many comments (as `commentable`) and likes (as `likeable`).
- **Tag**: N-N with Gossip via `JoinTableGossipTag`.
- **PrivateMessage**: Belongs to sender (User). Has many recipients (User) through `PrivateMessageRecipient`.
- **Comment**: Belongs to user and to `commentable` (polymorphic: Gossip or Comment). Has many sub-comments (as `commentable`) and likes (as `likeable`).
- **Like**: Belongs to user and to `likeable` (polymorphic: Gossip or Comment).

## Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/DevRedious/gossip-project.git
   cd gossip-project
   ```

2. **Install dependencies**:

   ```bash
   bundle install
   ```

3. **Setup the database**:

   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Seed the database**:

   ```bash
   rails db:seed
   ```

   This will populate your database with 10 cities, 10 users, 20 gossips, 10 tags (each gossip has at least one tag), 15 private messages (with one or more recipients), 20 comments (including comment-on-comment), and 20 likes on gossips or comments, using the Faker gem.

## Usage & Testing

Since this is a backend-only project, all verifications are performed via the **Rails Console**.

To enter the console, run:

```bash
rails console
```

### Useful Commands to Test Associations

- Check a User's gossips and city:

  ```ruby
  User.first.gossips
  User.first.city
  ```

- Check a Gossip's tags (N-N through):

  ```ruby
  Gossip.first.tags
  ```

- Check a PrivateMessage's sender and recipients:

  ```ruby
  PrivateMessage.first.sender
  PrivateMessage.first.recipients
  ```

- Comment-on-comment (polymorphic):

  ```ruby
  Comment.where(commentable_type: "Comment").first.commentable
  Comment.first.comments
  ```

- Likes on gossips or comments (polymorphic):

  ```ruby
  Gossip.first.likes
  Comment.first.likes
  User.first.likes
  ```

## Key Concepts Learned

### 1. Advanced ActiveRecord Associations

- **has_many :through**: Used to link Gossips and Tags via `JoinTableGossipTag`, and to link PrivateMessages to multiple recipient Users via `PrivateMessageRecipient`.
- **Polymorphic associations**: Comments can belong to a Gossip or to another Comment (`commentable`). Likes can belong to a Gossip or a Comment (`likeable`). Enables comment-on-comment and like-on-gossip-or-comment without duplicate tables.
- **class_name**: Used on PrivateMessage (sender, recipients) and related User associations to distinguish multiple references to the same model.

### 2. Database Migrations

- Generating tables in dependency order (cities before users, users before gossips, etc.).
- Using `references` with `polymorphic: true` and `foreign_key: { to_table: :users }` for custom foreign keys.

### 3. Data Integrity & Seeding

- Writing a robust `seeds.rb` that respects creation order and uses Faker and `.sample` for realistic, randomized data. Destroying in reverse order to respect foreign keys.

## Related projects (THP BDD)

- [FreeDoc](https://github.com/ValVoy/THP---FreeDoc-Project) — Doctors, patients, appointments, specialties (N-N associations).
- [DogBnB](https://github.com/ff14eternitalis-debug/dogbnb) — Dog rental (relational model).

----------------------------------

## Key Concepts Learned (Updated)

### 1. Advanced ActiveRecord Associations
- **has_many :through**: Used to link Gossips and Tags via `JoinTableGossipTag`, and to link PrivateMessages to multiple recipient Users via `PrivateMessageRecipient`.
- **Polymorphic associations**: Comments can belong to a Gossip or to another Comment (`commentable`). Likes can belong to a Gossip or a Comment (`likeable`). Enables comment-on-comment and like-on-gossip-or-comment without duplicate tables.
- **class_name**: Used on PrivateMessage (sender, recipients) and related User associations to distinguish multiple references to the same model.

### 2. MVC Architecture & Routing
- **RESTful Routing**: Implementation of specific routes for `gossips` and `users` using `resources`.
- **Dynamic Routing**: Using `params` to capture data from URLs (e.g., the welcome landing page).
- **Controller Logic**: Orchestrating data flow between ActiveRecord models and ERB views, ensuring variables are correctly passed using instance variables (`@`).

### 3. Front-End Integration
- **Layouts & Partials**: Utilizing `application.html.erb` to maintain a consistent Header and Footer across all pages.
- **Helpers**: Mastering `link_to` and URL helpers (`_path`) to navigate the application without hardcoding URLs.

---

## 🌐 Front-End Features (Implemented Today)

The application has transitioned from a backend-only project to a functional web app:
* **Dynamic Welcome Page**: Personalized greeting via `/welcome/:first_name`.
* **Gossip Index**: A curated homepage listing all gossips from the database using **Bootstrap 5 Cards**.
* **Gossip Show Page**: A detailed view for each gossip, including content, date, and author info.
* **User Profile Page**: A dedicated page for each user showing their bio, age, and city.
* **Static Pages**: Functional `/team` and `/contact` pages.
* **Custom UI**: Integrated **Bootstrap 5.3** via CDN and custom CSS styling in `application.css` for a modern look.

---

## 🛠 Advanced Web Features (V2 Implementation)

The application has evolved into a fully interactive platform with complete resource management:

### 1. Full Gossip CRUD (Create, Read, Update, Delete)
- **Interactive Creation**: A new gossip form with real-time **ActiveRecord validations** and error message displays.
- **Seamless Editing**: Pre-filled forms using `patch` methods to modify titles and content.
- **Secure Deletion**: Implementation of the `destroy` action with confirmation alerts using **Turbo** (Rails 8+).

### 2. Full Comment System (Polymorphic CRUD)
- **Nested Resources**: Comments are architecturally nested within Gossips (`/gossips/:id/comments`).
- **Interactive Feed**: Users can post comments directly from the gossip view.
- **Comment Management**: Dedicated `edit` and `delete` actions for comments, allowing users to moderate their own feedback.
- **Dynamic Counters**: Live display of the number of comments on the index cards and gossip show page.

### 3. Integrated Tagging System (God Mode Bonus)
- **Categorization**: Users can select a **Tag** from a dynamic dropdown menu (`select_tag`) when creating a new gossip.
- **Join Table Persistence**: Automatic creation and update of links in the `JoinTableGossipTag` during gossip creation and editing.
- **Smart Selection**: The edit form automatically pre-selects the gossip's current tag for better UX.

### 4. Urban & User Exploration
- **City Directory**: A dedicated page for each city (`cities/show`) listing all the "gossips" posted by local residents.
- **Interconnected UI**: Deep linking between Gossips, Authors, and Cities (e.g., clicking an author's city in a gossip takes you to the city's board).

---


## 🚀 How to Run the App

1. **Launch the server**:
  ```bash
  ./bin/dev
  ```

2. **Access the interface**:
  ```
  Home: http://localhost:3000/
  Welcome: http://localhost:3000/welcome/your_name
  Team: http://localhost:3000/team
  ```

## Authors

This project is for educational use within The Hacking Project. Feel free to modify or improve it in your own fork.

Morgan, Romain & Valentin (Backend Foundations)

Valentin (Front-End & MVC implementation)

_The Hacking Project 2026_
