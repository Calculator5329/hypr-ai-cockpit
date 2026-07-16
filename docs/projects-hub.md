# Projects Hub: register your own work

The Projects Hub is a view over projects you own; it is not another source of
truth. Its model is deliberately simple:

```text
project manifest  ──► hub list / summaries / filters
       │
       └────────────► desktop project launcher (Super+P)
```

Keep a single project manifest and derive both the hub list and launcher
entries from it. The source cockpit uses this pattern so project cards, work
summaries, and desktop jumps do not drift apart.

## 1. Add a project to your manifest

Use a manifest under your control, such as `~/Projects/workspace.json`. Paths
can be relative to its `root`, which keeps the file portable.

```json
{
  "root": "~/Projects",
  "repos": [
    {
      "path": "tools/recipe-planner",
      "status": "active",
      "agents": "full"
    }
  ]
}
```

Use a real directory that contains a Git repository. `status` communicates
whether it is active, passive, or archived; `agents` describes whether your
automation is allowed to modify it. Do not register a project by copying
another person's directory, remote URL, task list, or credentials.

The hub should read this manifest (or a generated project index) and ignore
archived entries by default. A project can have a normal README plus a
`docs/roadmap.md`; the hub can use those documents for a friendly purpose and
open-work summary without duplicating their contents.

## 2. Optional: register a development server

If a project has a browser preview, give the hub an explicit local command
instead of making it guess. A generic server registry entry looks like this:

```json
[
  {
    "repo": "tools/recipe-planner",
    "verified": true,
    "commands": [
      {
        "name": "dev",
        "cwd": "~/Projects/tools/recipe-planner",
        "cmd": "npm run dev",
        "port": 5173,
        "healthPath": "/"
      }
    ]
  }
]
```

Choose an unused port and test the command manually before marking it
`verified`. The hub should report conflicts rather than terminate an existing
service. Keep this registry local if it contains anything that should not be
published.

## 3. Jump from the desktop

`Super+P` is the project-launcher chord. Configure your launcher with a short
key and the same project directory used in the manifest. For example, a
launcher-specific registry could contain:

```toml
[recipe-planner]
path = "~/Projects/tools/recipe-planner"
```

After registering it, press `Super+P`, search for `recipe-planner`, and open
it. A launcher may start a terminal, editor, or persistent terminal session;
choose the behavior you prefer, but keep it scoped to the registered project.

The optional `Super+H` cockpit view opens the web-based Projects Hub. From
there, select a project to read its summary, open a verified local preview,
or request a desktop lane if your hub supports it.

## Troubleshooting

- **Project missing from the hub:** validate the manifest's JSON, confirm the
  relative path resolves under `root`, and refresh the hub's project index.
- **Launcher says unknown project:** add the matching short key to the
  launcher's own registry; the manifest alone does not create a terminal
  shortcut.
- **Preview will not start:** run the registered command in its `cwd`, resolve
  its dependency error, then check that the selected port is unused.
- **Summary is empty:** add a short project purpose and keep open work in the
  project's roadmap rather than a second hand-maintained list.
