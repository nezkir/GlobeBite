-- Database Member
-- Responsible for: Designing and maintaining the MySQL database
-- This includes: all tables, relationships, data types, and sample data

CREATE DATABASE IF NOT EXISTS globebite
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE globebite;

CREATE TABLE IF NOT EXISTS countries (
    id        INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name      VARCHAR(100) NOT NULL,
    iso_code  CHAR(3)      NOT NULL UNIQUE,
    flag      VARCHAR(10),
    capital   VARCHAR(100),
    region    VARCHAR(100),
    latitude  DOUBLE,
    longitude DOUBLE
);

CREATE TABLE IF NOT EXISTS dishes (
    id         INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    country_id INT          NOT NULL,
    name       VARCHAR(150) NOT NULL,
    cuisine    VARCHAR(100),
    fun_fact   TEXT,
    FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ingredients (
    id          INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dish_id     INT          NOT NULL,
    description VARCHAR(255) NOT NULL,
    sort_order  INT          DEFAULT 0,
    FOREIGN KEY (dish_id) REFERENCES dishes(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS recipe_steps (
    id            INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dish_id       INT  NOT NULL,
    step_number   INT  NOT NULL,
    title         VARCHAR(150),
    description   TEXT,
    timer_seconds INT  DEFAULT 0,
    FOREIGN KEY (dish_id) REFERENCES dishes(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS nutrition (
    id      INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dish_id INT         NOT NULL,
    label   VARCHAR(50) NOT NULL,
    value   VARCHAR(50),
    FOREIGN KEY (dish_id) REFERENCES dishes(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS favourites (
    id         INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    country_id INT NOT NULL,
    saved_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
);
