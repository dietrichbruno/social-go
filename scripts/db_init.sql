SELECT 'CREATE DATABASE social'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'social')\gexec