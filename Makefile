include .envrc
MIGRATIONS_PATH= ./cmd/migrate/migrations

.PHONY: migrate-create
migration:
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
		migrate -path $(MIGRATIONS_PATH) -database "$(DB_URL)" up;
	@echo "Migrations applied successfully."

.PHONY: migrate-down
migrate-down:
	@echo "Rolling back migrations..."
		migrate -path $(MIGRATIONS_PATH) -database "$(DB_URL)" down;
	@echo "Migrations rolled back successfully."
