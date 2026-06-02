import { tool } from "@opencode-ai/plugin";
import { execSync } from "child_process";

export default tool({
  name: "google:search", // Coincidimos con el nombre que alucina Gemma
  description: "Busca en internet para obtener información actualizada o documentación.",
  parameters: {
    query: {
      type: "string",
      description: "El término de búsqueda"
    }
  },
  execute: async ({ query }) => {
    // Ejecutamos el script de Python pasándole el query
    const output = execSync(`python3 ~/.config/opencode/tools/web_search.py "${query}"`);
    return output.toString();
  }
});
