.PHONY: build up down clean

# The root of the project
ROOT_DIR := ..

build:
	@echo "🚀 Preparing build context..."
	@cp .dockerignore $(ROOT_DIR)/.dockerignore
	@echo "📦 Building unified image..."
	docker-compose build
	@echo "🧹 Cleaning up root folder..."
	@rm $(ROOT_DIR)/.dockerignore
	@echo "✅ Build complete!"

up:
	docker-compose up

down:
	docker-compose down

clean:
	docker-compose down -v
	@rm $(ROOT_DIR)/.dockerignore 2>/dev/null || true
