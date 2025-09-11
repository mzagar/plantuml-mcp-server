# PlantUML MCP Server Makefile

# Variables
NODE_VERSION = $(shell node --version 2>/dev/null || echo "not found")
PLANTUML_SERVER_URL ?= https://www.plantuml.com/plantuml
DIST_DIR = dist
SRC_DIR = src
MAIN_FILE = plantuml-mcp-server

# Default target
.DEFAULT_GOAL := help

# Check if Node.js is installed
check-node:
	@if [ "$(NODE_VERSION)" = "not found" ]; then \
		echo "❌ Node.js is not installed. Please install Node.js 18+ first."; \
		exit 1; \
	fi
	@echo "✅ Node.js $(NODE_VERSION) found"

# Install dependencies
install: check-node
	@echo "📦 Installing dependencies..."
	npm install

# Clean build directory
clean:
	@echo "🧹 Cleaning build directory..."
	rm -rf $(DIST_DIR)

# Build the project
build: check-node clean
	@echo "🔨 Building TypeScript project..."
	npx tsc
	@echo "✅ Build complete! Output in $(DIST_DIR)/"

# Build and make executable
build-executable: build
	@echo "🔧 Making executable..."
	chmod +x $(DIST_DIR)/$(MAIN_FILE).js

# Development build with watch mode
dev: check-node
	@echo "👀 Starting development build (watch mode)..."
	npx tsc --watch

# Run the server locally
run: build-executable
	@echo "🚀 Starting PlantUML MCP Server..."
	@echo "Server URL: $(PLANTUML_SERVER_URL)"
	@echo "Press Ctrl+C to stop"
	PLANTUML_SERVER_URL=$(PLANTUML_SERVER_URL) node $(DIST_DIR)/$(MAIN_FILE).js

# Test the server with a simple PlantUML example
test: build-executable
	@echo "🧪 Testing server with sample PlantUML..."
	@echo "Starting server in background..."
	@PLANTUML_SERVER_URL=$(PLANTUML_SERVER_URL) node $(DIST_DIR)/$(MAIN_FILE).js &
	@sleep 2
	@echo "Server should be running. Check logs above for any errors."
	@echo "Kill the background process manually if needed: pkill -f 'node $(DIST_DIR)/$(MAIN_FILE).js'"

# Test with mcptools CLI
test-mcp: build-executable
	@echo "🧪 Testing with mcptools CLI..."
	@echo "📋 Listing available tools:"
	@mcp tools node $(DIST_DIR)/$(MAIN_FILE).js
	@echo ""
	@echo "🔧 Testing encode_plantuml tool:"
	@mcp call encode_plantuml --params '{"plantuml_code":"@startuml\nAlice -> Bob: Hello\n@enduml"}' node $(DIST_DIR)/$(MAIN_FILE).js
	@echo ""
	@echo "📊 Testing generate_plantuml_diagram tool:"
	@PLANTUML_SERVER_URL=$(PLANTUML_SERVER_URL) mcp call generate_plantuml_diagram --params '{"plantuml_code":"@startuml\nAlice -> Bob: Hello\nBob --> Alice: Hi there\n@enduml","format":"svg"}' node $(DIST_DIR)/$(MAIN_FILE).js
	@echo ""
	@echo "🔗 Testing generate_plantuml_diagram with !include directive:"
	@PLANTUML_SERVER_URL=$(PLANTUML_SERVER_URL) mcp call generate_plantuml_diagram --params '{"plantuml_code":"@startuml\n!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml\n\nPerson(user, \"User\")\nContainer(web, \"Web App\", \"React\", \"User interface\")\nContainer(api, \"API\", \"Node.js\", \"Backend API\")\n\nRel(user, web, \"Uses\")\nRel(web, api, \"Calls\")\n@enduml","format":"svg"}' node $(DIST_DIR)/$(MAIN_FILE).js
	@echo ""
	@echo "🔓 Testing decode_plantuml tool:"
	@mcp call decode_plantuml --params '{"encoded_string":"LOqnQyCm48Lt_GfLKmoEjMJgbDHJ8IacO3gMitHjrCedeJkHlr-KX4AtuxlllRTdWI9rZUefa8lLexw8P7wsji1r-0fogKjbB2wH8CdWqcfp16gPBOkFOR7ZRZirD9-ETWKMB7RSVOo9109X6NBhLnCMJhHfPRqsCsCndVgJDbTSUctUST67d4slpHd1YNceEf1W-GI7_qAGGw_DONfjtbloE7npEr_0_I1vtJwTKcUCZztxoip8fhlX6xZNZ11ZmtiaNzVu2m00"}' node $(DIST_DIR)/$(MAIN_FILE).js

# Setup for Claude Code (creates config directory and shows instructions)
setup-claude:
	@echo "⚙️  Setting up for Claude Code..."
	@mkdir -p ~/.claude-mcp 2>/dev/null || true
	@echo "📝 Add this to your ~/.claude-mcp/config.json:"
	@echo ""
	@echo "{"
	@echo "  \"servers\": {"
	@echo "    \"plantuml\": {"
	@echo "      \"command\": \"node\","
	@echo "      \"args\": [\"$(PWD)/$(DIST_DIR)/$(MAIN_FILE).js\"],"
	@echo "      \"env\": {"
	@echo "        \"PLANTUML_SERVER_URL\": \"$(PLANTUML_SERVER_URL)\""
	@echo "      }"
	@echo "    }"
	@echo "  }"
	@echo "}"
	@echo ""
	@echo "🔄 Then restart Claude Code to pick up the new MCP server."

# Create source directory structure
init: check-node
	@echo "📁 Creating project structure..."
	@mkdir -p $(SRC_DIR)
	@if [ ! -f $(SRC_DIR)/$(MAIN_FILE).ts ]; then \
		echo "$(MAIN_FILE).ts already in correct location"; \
	fi

# Full setup: install, build, and show setup instructions
setup: install init build-executable setup-claude
	@echo "🎉 Setup complete!"
	@echo ""
	@echo "Quick commands:"
	@echo "  make run          - Run the server locally"
	@echo "  make dev          - Run in development mode (watch)"
	@echo "  make test         - Test the server"
	@echo "  make test-mcp     - Test with mcptools CLI"
	@echo "  make clean build  - Clean rebuild"

# Show help
help:
	@echo "PlantUML MCP Server - Available Commands:"
	@echo ""
	@echo "  make install        - Install npm dependencies"
	@echo "  make build          - Build TypeScript to JavaScript"
	@echo "  make run            - Build and run the server"
	@echo "  make dev            - Run in development mode (watch)"
	@echo "  make test           - Test the server"
	@echo "  make test-mcp       - Test with mcptools CLI"
	@echo "  make clean          - Clean build directory"
	@echo "  make setup          - Full setup (install + build + instructions)"
	@echo "  make setup-claude   - Show Claude Code setup instructions"
	@echo "  make help           - Show this help"
	@echo ""
	@echo "Environment variables:"
	@echo "  PLANTUML_SERVER_URL - PlantUML server URL (default: $(PLANTUML_SERVER_URL))"
	@echo ""
	@echo "Examples:"
	@echo "  make run"
	@echo "  make test-mcp"
	@echo "  PLANTUML_SERVER_URL=https://your-server.com make test-mcp"

.PHONY: help install clean build build-executable dev run test test-mcp setup-claude init setup check-node
