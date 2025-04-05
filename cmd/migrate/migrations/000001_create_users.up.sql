create extension if not exists "citext";

CREATE TABLE IF NOT EXISTS users (
    id bigserial PRIMARY KEY,
    email citext UNIQUE NOT NULL,
    username VARCHAR(255) UNIQUE NOT NULL,
    paasword bytea NOT NULL,
    created_at timestamp(0) with time zone not null DEFAULT now()
);