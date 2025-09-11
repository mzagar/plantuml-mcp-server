# PlantUML MCP Server

A [Model Context Protocol (MCP)](https://modelcontextprotocol.io/) server that provides PlantUML diagram generation capabilities for Claude Desktop and Claude Code.

### Available Tools

1. **`generate_plantuml_diagram`** - Generate diagrams and get embeddable URLs (SVG/PNG)
2. **`encode_plantuml`** - Encode PlantUML code for URL sharing
3. **`decode_plantuml`** - Decode PlantUML from encoded strings


## Quick Setup

### For Claude Code

```bash
# Using default PlantUML server
claude mcp add plantuml --scope user --env PLANTUML_SERVER_URL=https://www.plantuml.com/plantuml -- npx plantuml-mcp-server
```

### For Claude Desktop

Add this to your Claude Desktop MCP configuration (`~/Library/Application Support/Claude/claude_desktop_config.json` on macOS):

```json
{
  "mcpServers": {
    "plantuml": {
      "command": "npx",
      "args": ["plantuml-mcp-server"],
      "env": {
        "PLANTUML_SERVER_URL": "https://www.plantuml.com/plantuml"
      }
    }
  }
}
```

To use your own PlantUML server, change the `PLANTUML_SERVER_URL` environment variable.

Then restart Claude Desktop/Code to activate the MCP server.


## What You Can Do

After setup, you can ask Claude to:
- **Generate PlantUML diagrams** and get embeddable SVG/PNG URLs
- **Create sequence diagrams, class diagrams, architecture diagrams** 
- **Use advanced PlantUML features** like `!include` directives and external libraries
- **Encode/decode PlantUML** for URL sharing

---

## Examples

### C4 diagram for plantuml-mcp-server

```
> add c4 diagram for this project in readme 'C4 diagram for plantuml-mcp-server' section
```
![C4 Container Diagram - PlantUML MCP Server](https://www.plantuml.com/plantuml/png/bLDBSzem4BxxLsnzWWpWIquvXHfAwH3AyCYLKQJ5g9MrhhGcoMJwtpiIvX7WqfD7gzNtslMZP-6uBatoHLjfQeMmPQxyGvOvyTehD6_hbzgZasGPBVSabLbbX0rlkfwLqIzPVj-TXTBgQPALmZEwBBzVvsHPQ8kkLmNyX3KRXFmUZXSmqA9meeGk7Dx3Kpw31ReTkYIPeVDaMu6-0-dAeqixa0vmXuOgT51xRGl8ZGYo1-X_CrLPJWhJTf8itZrZkVvAjLN2lRTaREj0slGF9VdOahRX8m60awwcTwtsaASt3KTGCJGesP65VXNF_J48xxLdOHcqPNGR8OEGcyYIpgL4oU4u6SEIo3HuabJmTuHDsydVQr-b3093R6ExSSApgoNN3c_OAcMrzZ7R3gGt4W-yKrBO--MpvNk52-bqnQ4wSxJJ2lrfJgePNO4MdM1D5fZ8UDXf4I4hHqoIp2VLmpTk7ROdIj4IpxI4xOhXlZ4wAqpKfMKCPuvMeRjMu8495i-ZR3OTXRdFqJGRSpN5SHYBaEpXLVCskXLSEs7025lKea1m-AT6ppvjNmCrGxj62NEJL9R2Ad-GS4d-AVjS6EDZIZ6pWE5PQSf-B7vEk_DPtj1_8lvlX0Xn_kf6yj-Nozd9T0VIqN09nnyyyxiY-q0R1AY_0T8I8pXTR1beSoOf0RYxw--4DkB5ODnY_t1tbm1q3ok2woD_CxfukqS_tiMQmijQn1_QdNPaIxHym9vD-jFbwccoNWpdpyFvUZMVnFe0Dw8s_73q75OhGQiWEBZqSHbCPFj6hXHyTB5u7a5BxM7RU-xfA7xpsZELUoFQ5cSiZsXLNPf_)


### Sequence diagram for plantuml-mcp-server

```
> add sequence diagram in readme in architecture section
```

![PlantUML MCP Server Architecture](https://www.plantuml.com/plantuml/png/XLHDZzem4BtxLups50wKGwiU8b4j0aehmIhYwuI4J3m4guwTscDMjEf_hnoJyB5BUujddcVUUpFnioDkoPUAaII5a2ckQJMRmcoOmGBj4IrqOM3pWoJCoLk4hygyCiPpCXQULWxj4t07uODLt9BCPSKrmTDGSIyGHkX-aAbgK0pTmjxfM6Ddm-nzu8VSb3MY2J3MxpTSlsj9aYlvYvCq6lfzTgRH_H8gfh08UgzwRNJYI4W3PBbsbR7KOI7RuDk226ICSkb6Tw50ZPOJRgj0mPTgAoGlB2z34dLkn2KLGW9lGZNXKRm1arWhi0tE1ih1oq0WKazXZZyzEheCvzpjNjj3MaaR23nk1KQwJUca1coqTr8Na7j7femGgOlcNWDEuTjocS5alDpeNjEYvuv5xtUiAlwmbdCxWFMauG-24s-ANiIIjngmtA4GVASGLlFfbT9WJWeZwIh5JwqJmT7ncUP37sl0rOw7qxs7TzFxbtE3gbAdIxN6fVIo19y_9PrmubM5MdpSdGXTZ9ppEqb9vv43qK9mP8Ftzmui3kQrnLXqNb7SA_oF2pNWoeKtzMjnTokRd3jj8_hMY3aUqJfi7O3AcXoTUo3CM5b8pTN3GLm9Z3J4PSxQ48ALnO70xEj70ff_VsZqNXO-_amf0-X2DXsyB5UpwNOndg_7ysrOfH0VuPvxHIaq-iAZKcU6joiFN1N6IZh4x68zwMKl4zWRMt82vwlmOZ3K0W8nnfvH2r-glm00)





### OAuth2 Authorization Code Flow Diagram

```
> show me basic oauth2 flow png, open it in browser
```

![OAuth2 Authorization Code Flow](https://www.plantuml.com/plantuml/png/RPDRJnin48NV_IkEUAYe6amJUbrrWK0fGgf41BHFI97n3ed5njwE9mJwwoll9M5JNbRMpl6PRux6nr4Cot9HAd5I4Yx7IvcFaBw1tLyZBdYSXeBmemmhfOoLmDZv5ObtO2BIGLM6nLbN6I_OEIqTUS6ugcxzxWc7LIH-MskRIb_TRtHD_DWQfq9VUaKnBDbIgxhrk-F9HUFSbPJAyotsoTn4GfwhH8gzmvOYmr3ZmZjnHWXbc3clMlAzmtgg32EDAoeSanL8WEdvnXf2-I04ThEvP3W_ky5-fw8ZfbW57sagpnNbDXJqnjOTfgx8jTPgZPI8Cnne_4mSi4m5UN6cZ2gLDaGVD4wJfHT4oqH-o-AZnZcdi2hYXOlH1RzswER-fBSIIcIzERgXCrXJbdV6FXmbJMxkx71qK6Ty4nx8u-p9pesVqIRaJOGDq6Uz4IKFt0U6fCkzZfFBwnlir_zl_Jga0TfZ9CiaWuPqUvul6cDhASR65-_0TCyKvssVUYKc5vte5THkUp9yrRMKwS-Iec3bPFuARI--32Tac1ZVJDrWMkiFrNfRUms6xpL-cz8LQUiQvvV2zMuEDIOSXAnG0UuKXH7ptvOEHnhVNQnAyungVSS6B-cnDU3XaRWr7smU2_h1qLFbc2BClH0ZXWL1t8AqGkhKJpMzXna9FArWNfXeHRv0wgdKCVbYkIZ_0G00)

---

## Development Setup

### Prerequisites
- Node.js 18+ 
- npm

### Local Installation

```bash
# Clone and setup
git clone https://github.com/mzagar/plantuml-mcp-server.git
cd plantuml-mcp-server
make setup
```

### Testing & Development

```bash
# Test the server
make test-mcp

# Development commands
make install      # Install dependencies
make build        # Build TypeScript to JavaScript  
make run          # Build and run the server
make dev          # Run in development mode (watch)
make help         # Show all available commands
```

## License

MIT License - see [LICENSE](LICENSE) file for details.