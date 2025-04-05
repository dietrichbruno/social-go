include .envrc
MIGRATIONS_PATH= ./cmd/migrate/migrations

.PHONY: migrate-create
migrate-create:
	@echo "Creating migration file..."
	@read -p "Enter migration name: " name; \
	if [ -z "$$name" ]; then \
		echo "Migration name cannot be empty"; \
		exit 1; \
	fi; \
	migrate create -ext sql -dir $(MIGRATIONS_PATH) -seq "$$name"

.PHONY: migrate-up
migrate-up:
	@echo "Applying migrations..."
	@read -p "Enter migration version (or 'latest' for latest): " version; \
	if [ "$$version" = "latest" ]; then \
		migrate -path $(MIGRATIONS_PATH) -database "$(DB_URL)" up; \
	else \
		migrate -path $(MIGRATIONS_PATH) -database "$(DB_URL)" up "$$version"; \
	fi
	@echo "Migrations applied successfully."

.PHONY: migrate-down
migrate-down:
	@echo "Rolling back migrations..."
	@read -p "Enter migration version (or 'latest' for latest): " version; \
	if [ "$$version" = "latest" ]; then \
		migrate -path $(MIGRATIONS_PATH) -database "$(DB_URL)" down; \
	else \
		migrate -path $(MIGRATIONS_PATH) -database "$(DB_URL)" down "$$version"; \
	fi
	@echo "Migrations rolled back successfully."
	
.PHONY: migrate-status
migrate-status:
	@echo "Checking migration status..."
	migrate -path $(MIGRATIONS_PATH) -database "$(DB_URL)" version
	@echo "Migration status checked successfully."