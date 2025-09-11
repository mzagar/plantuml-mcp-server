# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Development Commands

### Building
- `npm run build` - Compile TypeScript to JavaScript in the dist/ directory
- `npm run dev` - Start TypeScript compiler in watch mode for development
- `make build` - Clean and build the project using Makefile
- `make dev` - Run TypeScript in watch mode using Makefile

### Running and Testing
- `npm start` - Run the compiled server from dist/index.js
- `make run` - Build and run the server with proper setup
- `make test` - Test server functionality with background process
- `make test-mcp` - Test using mcptools CLI with sample PlantUML diagrams

### Setup and Installation
- `make install` - Install npm dependencies with Node.js version check
- `make setup` - Full setup including install, build, and Claude Code configuration
- `make setup-claude` - Show Claude Code MCP configuration instructions

## Project Architecture

### Core Structure
This is a Model Context Protocol (MCP) server that provides PlantUML diagram generation capabilities. The project follows a single-file architecture pattern:

**Main Components:**
- `src/plantuml-mcp-server.ts` - Single main file containing the entire server implementation
- `dist/` - Compiled JavaScript output directory
- `Makefile` - Comprehensive build and development workflow management

### MCP Server Implementation
The server uses the `@modelcontextprotocol/sdk` and implements:

**Tools Provided:**
1. `generate_plantuml_diagram` - Generates diagram URLs and returns embeddable links
2. `encode_plantuml` - Encodes PlantUML code for URL usage

**Key Classes and Functions:**
- `PlantUMLMCPServer` class - Main server implementation with tool handlers
- `encodePlantUML()` - Custom PlantUML encoding implementation
- `encode64()`, `append3bytes()`, `encode6bit()` - PlantUML encoding utilities

### Environment Configuration
- `PLANTUML_SERVER_URL` - Configurable PlantUML server (defaults to https://www.plantuml.com/plantuml)
- Server runs on stdio transport for MCP communication
- Node.js 18+ required (specified in package.json engines)

### Development Workflow
The project uses TypeScript with ESNext modules and strict type checking. The Makefile provides comprehensive commands for development, testing, and deployment. For Claude Code integration, the server should be configured in ~/.claude-mcp/config.json as shown in the `make setup-claude` command output.