export const EnvProtection = async ({ project, client, $, directory, worktree }) => {
  return {
    "tool.execute.before": async (input, output) => {
      if (input.tool === "read" && (
	  output.args.filePath.includes(".env")               || 
	  output.args.filePath.includes("node_modules")       || 
          output.args.filePath.includes("package.json")       || 
	  output.args.filePath.includes("package-lock.json")) || 
          output.args.filePath.includes("yarn.lock")          || 
          output.args.filePath.includes(".gitignore")         || 
	  output.args.filePath.includes("gradle")             || 
	  output.args.filePath.includes("gradlew")            ||
	  output.args.filePath.includes("build") 
      ){
        throw new Error("Do not read the config files")
      }
    },
  }
}
