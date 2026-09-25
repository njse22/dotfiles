import { Plugin } from "@opencode/plugin"

export default Plugin.define({
  id: "custom-tools",
  async setup(ctx) {
    await ctx.tool.transform((editor) => {
      editor.add({
        name: "mytool",
        description: "This is a custom tool",
        input: {
          type: "object",
          properties: { foo: { type: "string" } },
          required: ["foo"],
          additionalProperties: false,
        },
        async execute(input) {
          return {
            content: `Hello ${(input as { foo: string }).foo} from ${ctx.location.directory}`,
          }
        },
      })
    })
  },
})
