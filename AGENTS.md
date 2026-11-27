This is a Docker Sandbox environment for the project in `project/`. For project-specific instructions, see `project/AGENTS.md`.

When the AI harness is running inside the sandbox (you can check for existance of env var `SANDBOX_ID` at the start of the session):

- The Docker Sandbox environment directory is mounted read-only (but not `project/`, which is mounted read-write). So instead of modifying files directly, merely suggest changes to be made, or write `project/` for the user to inspect.
- Network access is restricted to a host allowlist. Ask the user if you need access. Ask for the minimum necessary scope (HTTP method and path pattern).
- You have passwordless sudo access.
