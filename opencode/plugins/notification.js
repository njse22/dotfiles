import { Plugin } from "@opencode/plugin"
import { execFile } from "node:child_process"

export default Plugin.define({
  id: "notification",
  async setup(ctx) {
    const controller = new AbortController()

    const notify = () =>
      new Promise((resolve) => {
        execFile("notify-send", ["OpenCode", "Session Complete !"], { timeout: 5000 }, () => resolve())
      })

    void (async () => {
      for await (const event of ctx.event.subscribe({ signal: controller.signal })) {
        if (event.type === "session.idle") {
          await notify()
        }
      }
    })()

    return () => controller.abort()
  },
})
