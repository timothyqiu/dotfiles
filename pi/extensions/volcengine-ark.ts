/**
 * Custom Provider: Volcano Engine Ark (火山引擎方舟)
 *
 * Registers two OpenAI-compatible coding models on the ark coding endpoint:
 *   - ark-code-latest      (intelligent routing, text + image)
 *   - deepseek-v4-flash    (DeepSeek V3.x with default-on thinking)
 *
 * Authentication follows the same flow as built-in providers:
 *   - /login volcengine   (persists to ~/.pi/agent/auth.json)
 *   - VOLCENGINE_API_KEY env var
 *   - --api-key CLI flag
 *
 * Usage:
 *   pi -e ~/.pi/agent/extensions/volcengine-ark.ts
 *   /login volcengine
 *   /model  -> select volcengine / ark-code-latest or deepseek-v4-flash
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	pi.registerProvider("volcengine", {
		name: "Volcano Engine (Ark)",
		baseUrl: "https://ark.cn-beijing.volces.com/api/coding/v3",
		// pi requires a non-empty apiKey to register models. The literal "placeholder"
		// below is overridden at request time by the real key from /login (auth.json),
		// the VOLCENGINE_API_KEY env var, or --api-key, matching built-in providers.
		apiKey: "placeholder",
		api: "openai-completions",
		authHeader: true, // adds Authorization: Bearer <key>
		models: [
			{
				id: "ark-code-latest",
				name: "ark-code-latest",
				reasoning: false,
				input: ["text", "image"],
				cost: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0 },
				contextWindow: 256000,
				maxTokens: 4096,
				// Ark gateway rejects the OpenAI "developer" role; route it through "system".
				// compat must live on the model — pi's openai-completions stream only reads model.compat.
				compat: {
					supportsDeveloperRole: false,
				},
			},
			{
				id: "deepseek-v4-flash",
				name: "deepseek-v4-flash",
				reasoning: true, // defaults to deep thinking per docs; user can toggle off
				input: ["text"],
				cost: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0 },
				contextWindow: 1024000,
				maxTokens: 4096,
				// DeepSeek-style reasoning controls: thinking.type toggle + reasoning_effort.
				// compat must live on the model — pi's openai-completions stream only reads model.compat.
				compat: {
					supportsDeveloperRole: false,
					supportsReasoningEffort: true,
					thinkingFormat: "deepseek",
				},
			},
		],
	});
}