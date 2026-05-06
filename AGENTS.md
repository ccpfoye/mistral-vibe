# AGENTS.md

Conventions for AI agents and humans contributing to **Mistral Vibe** — a Python 3.12+ CLI coding assistant managed with `uv`.

## Project Overview

Mistral Vibe is a CLI coding assistant that provides a conversational interface to your codebase. It supports file manipulation, code searching, version control, command execution, and interactive user input through a rich set of tools and a Textual-based TUI.

## Project Structure

```
mistral-vibe/
├── AGENTS.md                    # Contribution rules and conventions (this file)
├── CHANGELOG.md                 # Release history
├── CONTRIBUTING.md             # Contribution guidelines
├── README.md                    # User-facing documentation
├── pyproject.toml               # Project metadata, dependencies, and tool config
├── vibe/                        # Main source code
│   ├── __init__.py
│   ├── acp/                      # Agent Client Protocol integration
│   │   ├── acp_agent_loop.py     # ACP-specific agent loop implementation
│   │   ├── acp_logger.py         # ACP logging configuration
│   │   ├── commands/             # ACP command handling
│   │   │   └── registry.py       # Command registration for ACP
│   │   ├── entrypoint.py         # ACP entry point (vibe-acp command)
│   │   ├── exceptions.py         # ACP-specific exceptions
│   │   ├── session.py            # ACP session management
│   │   ├── tools/                # ACP tool implementations
│   │   │   ├── base.py           # Base ACP tool classes
│   │   │   └── builtins/         # Built-in ACP tools (bash, grep, read_file, etc.)
│   │   └── utils.py              # ACP utilities
│   │
│   ├── cli/                      # Textual TUI client
│   │   ├── __init__.py
│   │   ├── autocompletion/       # Input autocompletion system
│   │   │   ├── base.py           # Base autocompletion classes
│   │   │   ├── path_completion.py # File path completion
│   │   │   └── slash_command.py  # Slash command completion
│   │   ├── cache.py              # Response caching
│   │   ├── cli.py                # Main CLI application
│   │   ├── clipboard.py          # Clipboard integration
│   │   ├── commands.py           # Built-in slash commands (/help, /config, etc.)
│   │   ├── entrypoint.py         # CLI entry point (vibe command)
│   │   ├── history_manager.py    # Conversation history management
│   │   ├── narrator_manager/     # Text-to-speech narration
│   │   │   ├── narrator_manager.py
│   │   │   └── telemetry.py
│   │   ├── plan_offer/            # Plan offer feature for Vibe Code
│   │   │   ├── adapters/
│   │   │   │   └── http_whoami_gateway.py
│   │   │   └── ports/
│   │   │       └── whoami_gateway.py
│   │   ├── profiler.py           # Performance profiling
│   │   ├── stderr_guard.py       # Stderr capture and display
│   │   ├── terminal_detect.py    # Terminal capability detection
│   │   ├── textual_ui/           # Textual framework UI components
│   │   │   ├── app.py            # Main Textual application
│   │   │   ├── app.tcss          # Textual CSS styles
│   │   │   ├── constants.py      # UI constants
│   │   │   ├── external_editor.py # External editor integration
│   │   │   ├── handlers/         # Event handlers
│   │   │   │   └── event_handler.py
│   │   │   ├── notifications/    # Notification system
│   │   │   │   ├── adapters/
│   │   │   │   └── ports/
│   │   │   ├── quit_manager.py   # Application quit management
│   │   │   ├── recording/        # Session recording indicators
│   │   │   │   └── recording_indicator.py
│   │   │   ├── remote/            # Remote session management
│   │   │   │   └── remote_session_manager.py
│   │   │   ├── session_exit.py   # Session exit handling
│   │   │   ├── widgets/          # UI widget components
│   │   │   │   ├── __init__.py
│   │   │   │   ├── approval_app.py # Tool approval UI
│   │   │   │   ├── banner/       # Top banner widget
│   │   │   │   ├── braille_renderer.py
│   │   │   │   ├── chat_input/    # Chat input component
│   │   │   │   ├── compact.py     # Compact mode UI
│   │   │   │   ├── config_app.py # Configuration UI
│   │   │   │   ├── connector_auth_app.py
│   │   │   │   ├── context_progress.py
│   │   │   │   ├── debug_console.py # Debug console
│   │   │   │   ├── feedback_bar.py
│   │   │   │   ├── feedback_bar_manager.py
│   │   │   │   ├── load_more.py
│   │   │   │   ├── loading.py
│   │   │   │   ├── mcp_app.py     # MCP server UI
│   │   │   │   ├── messages.py    # Chat messages display
│   │   │   │   ├── model_picker.py # Model selection UI
│   │   │   │   ├── narrator_status.py
│   │   │   │   ├── no_markup_static.py
│   │   │   │   ├── path_display.py
│   │   │   │   ├── proxy_setup_app.py
│   │   │   │   ├── question_app.py # Interactive questions UI
│   │   │   │   ├── rewind_app.py
│   │   │   │   ├── session_picker.py
│   │   │   │   ├── spinner.py
│   │   │   │   ├── status_message.py
│   │   │   │   ├── teleport_message.py
│   │   │   │   ├── thinking_picker.py
│   │   │   │   ├── tool_widgets.py
│   │   │   │   ├── tools.py
│   │   │   │   ├── voice_app.py   # Voice settings UI
│   │   │   │   └── vscode_compat.py
│   │   │   └── windowing/       # Window management
│   │   │       ├── history.py
│   │   │       ├── history_windowing.py
│   │   │       └── state.py
│   │   ├── turn_summary/         # Turn summary feature
│   │   │   ├── noop.py
│   │   │   ├── port.py
│   │   │   ├── tracker.py
│   │   │   └── utils.py
│   │   ├── update_notifier/      # Update notification system
│   │   │   ├── adapters/
│   │   │   │   ├── filesystem_update_cache_repository.py
│   │   │   │   ├── github_update_gateway.py
│   │   │   │   └── pypi_update_gateway.py
│   │   │   ├── ports/
│   │   │   │   ├── update_cache_repository.py
│   │   │   │   └── update_gateway.py
│   │   │   ├── update.py
│   │   │   └── whats_new.py
│   │   └── voice_manager/        # Voice input/output management
│   │       ├── voice_manager.py
│   │       ├── voice_manager_port.py
│   │       └── telemetry.py
│   │
│   ├── core/                     # Core engine and shared logic
│   │   ├── __init__.py
│   │   ├── agent_loop.py         # Main agent loop orchestrator
│   │   ├── agents/               # Agent management
│   │   │   ├── __init__.py
│   │   │   ├── manager.py        # Agent manager
│   │   │   └── models.py         # Agent data models
│   │   ├── audio_player/         # Audio playback abstraction
│   │   │   ├── audio_player.py
│   │   │   └── audio_player_port.py
│   │   ├── audio_recorder/       # Audio recording abstraction
│   │   │   ├── audio_recorder.py
│   │   │   └── audio_recorder_port.py
│   │   ├── auth/                 # Authentication utilities
│   │   │   ├── crypto.py         # Cryptographic utilities
│   │   │   └── github.py         # GitHub authentication
│   │   ├── autocompletion/      # Autocompletion infrastructure
│   │   │   ├── completers.py
│   │   │   ├── file_indexer/     # File indexing for completion
│   │   │   │   ├── ignore_rules.py
│   │   │   │   ├── indexer.py
│   │   │   │   ├── store.py
│   │   │   │   └── watcher.py
│   │   │   ├── fuzzy.py          # Fuzzy matching
│   │   │   ├── path_prompt.py
│   │   │   └── path_prompt_adapter.py
│   │   ├── config/               # Configuration management
│   │   │   ├── _settings.py      # Settings definitions
│   │   │   ├── harness_files/
│   │   │   │   ├── _harness_manager.py
│   │   │   │   └── _paths.py
│   │   │   ├── layer.py          # Config layer system
│   │   │   ├── patch.py          # Config patching
│   │   │   └── schema.py         # Config schema definitions
│   │   ├── data_retention.py     # Data retention policies
│   │   ├── hooks/                # Hook system
│   │   │   ├── config.py
│   │   │   ├── executor.py
│   │   │   ├── manager.py
│   │   │   └── models.py
│   │   ├── llm/                  # LLM backend integration
│   │   │   ├── backend/          # Backend implementations
│   │   │   │   ├── anthropic.py
│   │   │   │   ├── base.py
│   │   │   │   ├── factory.py
│   │   │   │   ├── generic.py
│   │   │   │   ├── mistral.py
│   │   │   │   ├── openai_responses.py
│   │   │   │   ├── reasoning_adapter.py
│   │   │   │   └── vertex.py
│   │   │   ├── exceptions.py
│   │   │   ├── format.py         # Message formatting
│   │   │   ├── message_utils.py  # Message utility functions
│   │   │   └── types.py          # LLM type definitions
│   │   ├── log_reader.py         # Log file reading utilities
│   │   ├── logger.py             # Logging configuration
│   │   ├── middleware.py         # Agent middleware
│   │   ├── nuage/                # Nuage (Mistral cloud) integration
│   │   │   ├── agent_models.py
│   │   │   ├── client.py
│   │   │   ├── events.py
│   │   │   ├── exceptions.py
│   │   │   ├── remote_events_source.py
│   │   │   ├── remote_workflow_event_models.py
│   │   │   ├── remote_workflow_event_translator.py
│   │   │   ├── streaming.py
│   │   │   └── workflow.py
│   │   ├── output_formatters.py  # Output formatting utilities
│   │   ├── paths/                # Path management
│   │   │   ├── _local_config_walk.py
│   │   │   ├── _vibe_home.py
│   │   │   └── conventions.py
│   │   ├── plan_session.py       # Plan mode session management
│   │   ├── programmatic.py       # Programmatic API entry point
│   │   ├── prompts/              # System prompts
│   │   │   ├── agents_doc.md
│   │   │   ├── cli.md
│   │   │   ├── compact.md
│   │   │   ├── dangerous_directory.md
│   │   │   ├── explore.md
│   │   │   ├── lean.md
│   │   │   ├── project_context.md
│   │   │   ├── tests.md
│   │   │   └── turn_summary.md
│   │   ├── proxy_setup.py        # Proxy configuration
│   │   ├── rewind/               # Message rewind feature
│   │   │   └── manager.py
│   │   ├── scratchpad.py         # Scratchpad file management
│   │   ├── session/              # Session management
│   │   │   ├── resume_sessions.py
│   │   │   ├── saved_sessions.py
│   │   │   ├── session_id.py
│   │   │   ├── session_loader.py
│   │   │   ├── session_logger.py
│   │   │   └── session_migration.py
│   │   ├── skills/               # Skills system
│   │   │   ├── builtins/         # Built-in skills
│   │   │   │   └── vibe.py       # Vibe CLI skill documentation
│   │   │   ├── manager.py        # Skill manager
│   │   │   ├── models.py         # Skill data models
│   │   │   └── parser.py         # Skill file parser
│   │   ├── system_prompt.py      # System prompt generation
│   │   ├── telemetry/            # Telemetry and analytics
│   │   │   ├── build_metadata.py
│   │   │   ├── send.py
│   │   │   └── types.py
│   │   ├── teleport/             # Teleport to Vibe Code
│   │   │   ├── errors.py
│   │   │   ├── git.py
│   │   │   ├── nuage.py
│   │   │   ├── teleport.py
│   │   │   └── types.py
│   │   ├── tools/                # Tool system
│   │   │   ├── arity.py          # Tool arity checking
│   │   │   ├── base.py           # Base tool classes
│   │   │   ├── builtins/         # Built-in tools
│   │   │   │   ├── ask_user_question.py
│   │   │   │   ├── bash.py
│   │   │   │   ├── exit_plan_mode.py
│   │   │   │   ├── grep.py
│   │   │   │   ├── prompts/
│   │   │   │   ├── read_file.py
│   │   │   │   ├── search_replace.py
│   │   │   │   ├── skill.py
│   │   │   │   ├── task.py
│   │   │   │   ├── todo.py
│   │   │   │   ├── webfetch.py
│   │   │   │   ├── websearch.py
│   │   │   │   └── write_file.py
│   │   │   ├── connectors/       # Tool connectors
│   │   │   │   ├── connector_registry.py
│   │   │   │   └── __init__.py
│   │   │   ├── manager.py        # Tool manager
│   │   │   ├── mcp/              # MCP tool integration
│   │   │   │   ├── registry.py
│   │   │   │   ├── tools.py
│   │   │   │   └── __init__.py
│   │   │   ├── mcp_sampling.py   # MCP sampling utilities
│   │   │   ├── mcp_settings.py   # MCP settings
│   │   │   ├── permissions.py    # Tool permissions
│   │   │   ├── ui.py             # Tool UI utilities
│   │   │   └── utils.py          # Tool utilities
│   │   ├── tracing.py            # Tracing and observability
│   │   ├── transcribe/           # Audio transcription
│   │   │   ├── factory.py
│   │   │   ├── mistral_transcribe_client.py
│   │   │   └── transcribe_client_port.py
│   │   ├── trusted_folders.py    # Trusted folder management
│   │   ├── tts/                  # Text-to-speech
│   │   │   ├── factory.py
│   │   │   ├── mistral_tts_client.py
│   │   │   └── tts_client_port.py
│   │   ├── types.py              # Core type definitions
│   │   └── utils/                # Utility functions
│   │       ├── async_subprocess.py
│   │       ├── concurrency.py
│   │       ├── display.py
│   │       ├── http.py
│   │       ├── io.py
│   │       ├── matching.py
│   │       ├── merge.py
│   │       ├── paths.py
│   │       ├── platform.py
│   │       ├── retry.py
│   │       ├── slug.py
│   │       ├── tags.py
│   │       └── time.py
│   │
│   └── setup/                    # First-run setup wizards
│       ├── auth/                 # Authentication setup
│       │   ├── browser_sign_in.py
│       │   ├── browser_sign_in_gateway.py
│       │   └── http_browser_sign_in_gateway.py
│       └── onboarding/            # Onboarding flow
│           ├── base.py
│           ├── context.py
│           ├── onboarding.tcss   # Onboarding styles
│           └── screens/
│               ├── api_key.py
│               └── welcome.py
│       └── trusted_folders/       # Trusted folder setup
│           ├── trust_folder_dialog.py
│           └── trust_folder_dialog.tcss
│
├── tests/                       # Test suite
│   ├── __init__.py
│   ├── acp/                      # ACP tests
│   ├── audio_player/             # Audio player tests
│   ├── audio_recorder/           # Audio recorder tests
│   ├── autocompletion/          # Autocompletion tests
│   ├── backend/                  # Backend tests
│   ├── banner/                   # Banner tests
│   ├── browser_sign_in/          # Browser sign-in tests
│   ├── cli/                      # CLI tests
│   ├── conftest.py               # Pytest fixtures
│   ├── stubs/                    # Test doubles (Fake* classes)
│   └── voice_manager/            # Voice manager tests
├── docs/                        # Additional documentation
│   ├── README.md
│   ├── acp-setup.md
│   └── proxy-setup.md
├── scripts/                     # Maintenance scripts
│   ├── README.md
│   ├── bump_version.py
│   ├── install.sh
│   └── prepare_release.py
└── pyproject.toml               # Project configuration
```

## Layout Summary

- `vibe/core` — Engine: agent loop, tools, LLM backends, configuration management
- `vibe/cli` — Textual TUI: widgets, commands, user interface
- `vibe/acp` — Agent Client Protocol bridge for IDE integrations
- `vibe/setup` — First-run wizards and onboarding flows
- `tests/` — Test suite with autouse fixtures in `conftest.py` and test doubles in `tests/stubs/`

## Key Modules

| Module | Purpose |
|--------|---------|
| `vibe/core/agent_loop.py` | Main agent orchestration loop |
| `vibe/core/llm/` | LLM backend integrations (Anthropic, Mistral, OpenAI, Vertex) |
| `vibe/core/tools/` | Tool system with built-in tools (bash, grep, read_file, write_file, search_replace, etc.) |
| `vibe/core/config/` | Configuration schema and layer system |
| `vibe/core/session/` | Session persistence and resume functionality |
| `vibe/core/skills/` | Skills system for custom agent behaviors |
| `vibe/core/telemetry/` | Usage telemetry and analytics |
| `vibe/cli/textual_ui/app.py` | Main Textual application |
| `vibe/cli/textual_ui/widgets/` | UI components (chat, input, messages, etc.) |
| `vibe/cli/commands.py` | Slash command definitions |
| `vibe/acp/entrypoint.py` | ACP server entry point |
| `vibe/setup/onboarding/` | First-run onboarding screens |

## Built-in Slash Commands

Commands defined in `vibe/cli/commands.py`:

| Command | Description |
|---------|-------------|
| `/help` | Show help message |
| `/config` | Edit configuration settings |
| `/model` | Select active model |
| `/thinking` | Select thinking level |
| `/reload` | Reload configuration, agent instructions, and skills |
| `/clear` | Clear conversation history |
| `/copy` | Copy last agent message to clipboard |
| `/log` | Show path to current interaction log file |
| `/debug` | Toggle debug console |
| `/compact` | Compact conversation history by summarizing |
| `/exit` | Exit the application |
| `/status` | Display agent statistics |
| `/teleport` | Teleport session to Vibe Code |
| `/proxy-setup` | Configure proxy and SSL certificate settings |
| `/resume` / `/continue` | Browse and resume past sessions |
| `/rename` | Rename the current session |
| `/mcp` / `/connectors` | Display available MCP servers and connectors |
| `/voice` | Configure voice settings |
| `/leanstall` | Install the Lean 4 agent |
| `/unleanstall` | Uninstall the Lean 4 agent |
| `/rewind` | Rewind to a previous message |
| `/data-retention` | Show data retention information |

## Built-in Tools

Tools defined in `vibe/core/tools/builtins/`:

| Tool | Description |
|------|-------------|
| `bash` | Execute shell commands |
| `grep` | Search files with ripgrep |
| `read_file` | Read file contents |
| `write_file` | Write to a file |
| `search_replace` | Find and replace text in files |
| `todo` | Manage a todo list |
| `task` | Delegate tasks to subagents |
| `ask_user_question` | Ask interactive questions |
| `skill` | Load and use skills |
| `web_fetch` | Fetch web content |
| `web_search` | Search the web |

## Agent Startup Flow

The agent starts through this sequence:

1. **CLI Entry** (`vibe/cli/entrypoint.py:main()`): Parses arguments and calls `run_cli()`
2. **CLI Initialization** (`vibe/cli/cli.py:run_cli()`): Loads config via `VibeConfig.load()`, initializes managers (tools, skills, agents), then launches the Textual UI
3. **Textual UI** (`vibe/cli/textual_ui/app.py`): Creates the `AgentLoop` with config and all managers
4. **AgentLoop Initialization** (`vibe/core/agent_loop.py:AgentLoop.__init__()`): Sets up message history, loads system prompt, initializes LLM backend, tool manager, skill manager, agent manager, middleware pipeline, hooks, telemetry, session logger, rewind manager, and scratchpad
5. **System Prompt Generation**: Calls `get_universal_system_prompt()` to compose the initial system message

## System Prompt Composition

The system prompt is assembled by `vibe/core/system_prompt.py:get_universal_system_prompt()` from these components:

- **Base prompt**: From `config.system_prompt` (default: `vibe/core/prompts/cli.md`)
- **Model info**: Active model name (if `include_model_info` enabled)
- **Commit signature**: Git commit template (if `include_commit_signature` enabled)
- **OS/Platform info**: Detected platform and default shell (if `include_prompt_detail` enabled)
- **Tool prompts**: Each tool's `get_tool_prompt()` output (bash usage tips, grep patterns, etc.)
- **Available skills**: List of discoverable skills with descriptions
- **Available subagents**: List of subagents for the `task` tool
- **Scratchpad directory**: Path to session-scoped temporary file storage
- **Project context**: Git status, recent commits, branch info (if `include_project_context` enabled)
- **AGENTS.md content**: Both user-level (`~/.vibe/AGENTS.md`) and project-level (`./AGENTS.md`) instructions
- **Headless mode**: Special instructions when running without human interaction

The composed prompt is wrapped in an `LLMMessage(role=Role.system, content=...)` and added as the first message in the conversation history.

## Adding a New Slash Command

To add a new slash command:

1. **Register the command** in `vibe/cli/commands.py` in the `CommandRegistry._build_commands()` method:
   ```python
   "mycommand": Command(
       aliases=frozenset(["/mycommand", "/mc"]),  # Command aliases
       description="Description of what the command does",
       handler="_my_command_handler",  # Method name in app.py
   ),
   ```

2. **Implement the handler** in `vibe/cli/textual_ui/app.py` as an async method:
   ```python
   async def _my_command_handler(self, args: str) -> None:
       # Handle the command logic here
       # args contains any text after the command, e.g., "/mycommand arg1 arg2"
   ```

3. **Add telemetry** (optional but recommended) in the handler:
   ```python
   self.agent_loop.telemetry_client.send_slash_command_used("mycommand", "builtin")
   ```

4. **Add to autocompletion** (optional) - commands are automatically added to slash command completion via `SlashCommandController` in `vibe/cli/autocompletion/slash_command.py`.

The command will be automatically available in the TUI and ACP modes. Use `CommandAvailabilityContext` to conditionally enable/disable commands based on runtime conditions.

## Commands

Always go through `uv` — never invoke bare `python` or `pip`.

- `uv run vibe` / `uv run vibe-acp` — the two entry points.
- `uv run pytest` — full suite (parallel via `pytest-xdist`).
- `uv run pyright` — strict type check.
- `uv run ruff check --fix .` and `uv run ruff format .` — run both after every code change and report the files modified.
- `uv run pre-commit run --all-files` — full lint pass. Install once with `uv tool install pre-commit && uv run pre-commit install`.
- Useful uv basics: `uv sync --all-extras`, `uv add <pkg>`, `uv remove <pkg>`.

## Project layout & module conventions

- `__init__.py` exposes the public API via an explicit `__all__`.
- Private modules are prefixed with `_` (e.g. `_settings.py`, `_config.py`).
- Pydantic models live in `models.py`; configuration in `_settings.py` / `_config.py`.
- Abstract interfaces use the `_port.py` suffix (hexagonal-style ports).
- Tests mirror the source layout; test doubles in `tests/stubs/` are named `Fake*`.

## Python style

- Prefer `match` / `case` over long `if` / `elif` chains.
- Use the walrus operator `:=` only when it shortens code and improves clarity.
- Be a never-nester: early returns and guard clauses over nested blocks.
- Modern type hints only: built-in generics (`list`, `dict`) and `|` unions. Never import `Optional`, `Union`, `Dict`, `List` from `typing`.
- Use `pathlib.Path` (and `anyio.Path` in async paths) instead of `os.path`.
- Use f-strings, comprehensions, and context managers; follow PEP 8.
- Enums: `StrEnum` / `IntEnum` with `auto()` and UPPERCASE members. For type-mixing, the mix-in type comes before `Enum` in the bases. Add methods or `@property` rather than parallel lookup tables.
- Write declarative, minimalist code: express intent, drop boilerplate.
- Never call a private method from outside of it's class
- Avoid comments and docstrings, except for when there's a hard to spot corner case

## Typing & imports

- Pyright is strict and gates CI; fix types at the source.
- No relative imports — `ban-relative-imports = "all"`. Always `from vibe.core.x import …`.
- No inline `# type: ignore` or `# noqa`. Fix with refined signatures (TypeVar, Protocol), `isinstance` guards, `typing.cast` when control flow guarantees the type, or a small typed wrapper at the boundary.

## Pydantic

- Parse external data via `model_validate`, `field_validator`, or `model_validator(mode="before")` — never ad-hoc `getattr` / `hasattr` walks or custom `from_sdk` constructors.
- Set `ConfigDict(extra=…)` explicitly. Use `validation_alias` (or field aliases) for kebab-case TOML keys.
- Discriminated unions (e.g. MCP `transport`): use sibling final classes plus a shared base/mixin, and compose with `Annotated[Union[...], Field(discriminator=...)]`. Never narrow the discriminator field in a subclass — it violates LSP and pyright will reject it.
- Document `Raises:` only for exceptions the function actually raises (or that propagate from public API calls). Don't list speculative built-ins.

## Async

- `asyncio` is the orchestration runtime in the agent loop and tool execution. Use `asyncio.create_task` + queues for concurrent work, not blanket `gather`.
- Use `anyio.Path` for file I/O on async paths.
- Streaming surfaces return `AsyncGenerator[Event, None]`, not coroutines.
- HTTP via `httpx.AsyncClient`; mock with `respx` in tests.

## Tools

- Subclass `BaseTool` from `vibe/core/tools/base.py` with a Pydantic args model and a `BaseToolConfig` generic parameter.
- Implement `async def run(args, ctx: InvokeContext)` and yield events progressively.
- Raise `ToolError` for user-facing failures; raise `ToolPermissionError` for authorization failures.
- Declare permission with `ToolPermission` (`ALWAYS` / `ASK` / `NEVER`); honor it consistently.

## Logging & errors

- Use `from vibe.core.logger import logger` — stdlib `logging` with `StructuredLogFormatter`, not `structlog`.
- Configure via env: `LOG_LEVEL` (default `WARNING`), `DEBUG_MODE`, `LOG_MAX_BYTES`. Logs land in `~/.vibe/logs/vibe.log`.
- Pass variables as keyword args, not interpolated into the message: prefer `logger.error("Failed to fetch", url=url)` over `logger.error(f"Failed to fetch {url}")`.
- Define module-local exception hierarchies. Always chain with `raise NewError(...) from e`. Rich exceptions expose a `_fmt()` helper for human-readable output.

## File I/O

- Prefer `vibe.core.utils.io.read_safe` / `read_safe_async` / `decode_safe` over raw `Path.read_text()`, `Path.read_bytes().decode()`, or `open()`.
- They return `ReadSafeResult(text, encoding)` and try UTF-8, then BOM detection, then locale, then `charset_normalizer` lazily.
- Pass `raise_on_error=True` only when callers must distinguish corrupt files from valid ones; the default replaces undecodable bytes with U+FFFD.

## Tests

- Stack: `pytest` + `pytest-asyncio` + `pytest-textual-snapshot` + `respx`.
- Mark async tests with `@pytest.mark.asyncio`. Mock outbound HTTP with `respx`.
- Rely on the autouse fixtures in `tests/conftest.py` (`config_dir`, `tmp_working_directory`) for filesystem and home-dir isolation.
- No docstrings on test functions, methods, or classes — descriptive names like `test_create_user_returns_403_when_unauthorized` carry the intent. Pytest displays docstrings instead of node IDs when present, which hurts.
- Tests are exempt from the `ANN` and `PLR` ruff rules (see `per-file-ignores`).

## Git

- Never use `git commit --amend`, `git push --force`, or `git push --force-with-lease`.
- Always create new commits and push with a plain `git push`.
- If a push is rejected due to upstream changes, rebase onto the updated remote branch — never merge and never force-push.

## Editor tip

In Cursor / Pyright, the "Add import" quick fix is missing — use the workspace snippets `acpschema`, `acphelpers`, `vibetypes`, `vibeconfig` to insert the import line, then rename the symbol.


## Autoimprovement

- Suggest to add new rules to AGENTS.md based on user input or PR comments, when a change request could be generalized as a rule.
- Suggest updates to the README.md file according to feature changes or additions
- Keep the builtin Vibe Skill (`vibe/core/skills/builtins/vibe.py`) up-to-date. It documents the CLI's features, such as args, flags, config options and persistence, commands, built-in agents, file discovery logic.
