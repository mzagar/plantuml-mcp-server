#!/usr/bin/env node

import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from '@modelcontextprotocol/sdk/types.js';
import plantumlEncoder from 'plantuml-encoder';

function encodePlantUML(plantuml: string): string {
  return plantumlEncoder.encode(plantuml);
}

function decodePlantUML(encoded: string): string {
  return plantumlEncoder.decode(encoded);
}

// Configuration
const PLANTUML_SERVER_URL = process.env.PLANTUML_SERVER_URL || 'https://www.plantuml.com/plantuml';

class PlantUMLMCPServer {
  private server: Server;

  constructor() {
    this.server = new Server({
      name: 'plantuml-server',
      version: '0.1.0',
      capabilities: {
        tools: {},
      },
    });

    this.setupToolHandlers();
  }

  private setupToolHandlers() {
    this.server.setRequestHandler(ListToolsRequestSchema, async () => ({
      tools: [
        {
          name: 'generate_plantuml_diagram',
          description: 'Generate a PlantUML diagram and return embeddable image URL',
          inputSchema: {
            type: 'object',
            properties: {
              plantuml_code: {
                type: 'string',
                description: 'PlantUML diagram code',
              },
              format: {
                type: 'string',
                enum: ['svg', 'png'],
                default: 'svg',
                description: 'Output image format',
              },
            },
            required: ['plantuml_code'],
          },
        },
        {
          name: 'encode_plantuml',
          description: 'Encode PlantUML code for URL usage',
          inputSchema: {
            type: 'object',
            properties: {
              plantuml_code: {
                type: 'string',
                description: 'PlantUML diagram code to encode',
              },
            },
            required: ['plantuml_code'],
          },
        },
        {
          name: 'decode_plantuml',
          description: 'Decode encoded PlantUML string back to PlantUML code',
          inputSchema: {
            type: 'object',
            properties: {
              encoded_string: {
                type: 'string',
                description: 'Encoded PlantUML string to decode',
              },
            },
            required: ['encoded_string'],
          },
        },
      ],
    }));

    this.server.setRequestHandler(CallToolRequestSchema, async (request) => {
      switch (request.params.name) {
        case 'generate_plantuml_diagram':
          return this.generateDiagram(request.params.arguments);
        case 'encode_plantuml':
          return this.encodePlantuml(request.params.arguments);
        case 'decode_plantuml':
          return this.decodePlantuml(request.params.arguments);
        default:
          throw new Error(`Unknown tool: ${request.params.name}`);
      }
    });
  }

  private async generateDiagram(args: any) {
    const { plantuml_code, format = 'svg' } = args;

    if (!plantuml_code) {
      throw new Error('plantuml_code is required');
    }

    try {
      // Encode the PlantUML code
      const encoded = encodePlantUML(plantuml_code);

      // Generate the diagram URL
      const diagramUrl = `${PLANTUML_SERVER_URL}/${format}/${encoded}`;

      // Test if the URL is accessible
      const response = await fetch(diagramUrl);
      if (!response.ok) {
        throw new Error(`PlantUML server returned ${response.status}: ${response.statusText}`);
      }

      return {
        content: [
          {
            type: 'text',
            text: `Successfully generated PlantUML diagram!\n\n**Embeddable ${format.toUpperCase()} URL:**\n\`\`\`\n${diagramUrl}\n\`\`\`\n\n**Markdown embed:**\n\`\`\`markdown\n![PlantUML Diagram](${diagramUrl})\n\`\`\``,
          },
        ],
      };
    } catch (error) {
      return {
        content: [
          {
            type: 'text',
            text: `Error generating PlantUML diagram: ${error instanceof Error ? error.message : String(error)}`,
          },
        ],
        isError: true,
      };
    }
  }

  private async encodePlantuml(args: any) {
    const { plantuml_code } = args;

    if (!plantuml_code) {
      throw new Error('plantuml_code is required');
    }

    try {
      const encoded = encodePlantUML(plantuml_code);

      return {
        content: [
          {
            type: 'text',
            text: `**Encoded PlantUML:**\n\`\`\`\n${encoded}\n\`\`\`\n\n**Full SVG URL:**\n\`\`\`\n${PLANTUML_SERVER_URL}/svg/${encoded}\n\`\`\`\n\n**Full PNG URL:**\n\`\`\`\n${PLANTUML_SERVER_URL}/png/${encoded}\n\`\`\``,
          },
        ],
      };
    } catch (error) {
      return {
        content: [
          {
            type: 'text',
            text: `Error encoding PlantUML: ${error instanceof Error ? error.message : String(error)}`,
          },
        ],
        isError: true,
      };
    }
  }

  private async decodePlantuml(args: any) {
    const { encoded_string } = args;

    if (!encoded_string) {
      throw new Error('encoded_string is required');
    }

    try {
      const decoded = decodePlantUML(encoded_string);

      return {
        content: [
          {
            type: 'text',
            text: `**Decoded PlantUML:**\n\`\`\`plantuml\n${decoded}\n\`\`\``,
          },
        ],
      };
    } catch (error) {
      return {
        content: [
          {
            type: 'text',
            text: `Error decoding PlantUML: ${error instanceof Error ? error.message : String(error)}`,
          },
        ],
        isError: true,
      };
    }
  }

  async run() {
    const transport = new StdioServerTransport();
    await this.server.connect(transport);
    console.error('PlantUML MCP server running on stdio');
  }
}

const server = new PlantUMLMCPServer();
server.run().catch(console.error);