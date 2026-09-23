# NoCanvasDemo — Running Athina Without Canvas LMS

This folder demonstrates how to configure Athina to work **without a Canvas LMS**,
using the database for input and GitLab Issues for output.

## Configuration

`assignment.yaml` is already set up for this mode:

1. **`input_method: db`** — load submissions from the database instead of the Canvas API
2. **`output_method: gitlab_issues`** — post grades as GitLab issues
3. **`git_url`** — the GitLab host, e.g. `gitlab.com`

Grade issues are created in the **student's own repository**, derived from their
`repository_url`, so `gitlab_project_id` is not used in this mode. Leave it at 0.

**Git credentials and the LLM API key are not stored in YAML.** When you use the
Athina web interface, they are taken from your faculty profile and written to a
`.env` file in the assignment directory. The engine reads that file directly.

A **`Dockerfile`** must sit next to `assignment.yaml`: the engine builds it
before running tests, so everything the tests need (a Python runtime here) is
installed there.

## Importing Submissions

There are two ways to get student data into the system:

### Option A: Import via CLI

Use the `--import_submissions` (`-i`) flag with a JSON file:

```bash
athina-cli -c assignment.yaml -i submissions.json -v
```

See `submissions.json` for the expected format.

### Option B: Pre-populate via Athina-Web

If you use Athina-Web, student submissions can be entered through the web interface
and stored directly in the database. Then run Athina in service mode:

```bash
athina-cli -j http://your-athina-web/assignments/api/ -s -v
```

## How It Works

| Step | With Canvas | Without Canvas (this config) |
|------|-------------|------------------------------|
| **Input** | `Canvas.get_all_submissions()` fetches from API | Submissions already in DB (imported or via web UI) |
| **Testing** | Same — clones repos, runs tests in Docker/firejail | Same |
| **Output** | `Canvas.submit_grade()` posts to Canvas LMS | `GitLabIssues.submit_grade()` creates GitLab issues |
| **Plagiarism** | CopyDetect results (runs locally) | CopyDetect results (runs locally) |

## GitLab Issue Format

Each grade is posted as a Markdown-formatted issue:

```
## Grade Report (confidential)

| Field | Value |
|-------|-------|
| **Student** | Alice Johnson |
| **User ID** | 1001 |
| **Grade** | 85 / 100 |
| **Date** | 2026-09-01 12:00 UTC |

---

### Test Output

[Test 1 with weight 0.70]
...output...
[Test 2 with weight 0.30]
...output...

Note: Maximum possible grade is 100, the rest is graded manually by the instructor.
```

## Key Config Options

| Option | Description |
|--------|-------------|
| `input_method` | `canvas` or `db` |
| `output_method` | `canvas` or `gitlab_issues` |
| `gitlab_issues_confidential` | If `true`, issues are only visible to the repo owner |
| `gitlab_issues_title_prefix` | Prefix for issue titles |
| `git_url` | GitLab host (default: `gitlab.com`) |
| `plagiarism_pattern` | File glob to compare, e.g. `"*.py"` (quote it — `*.py` unquoted is invalid YAML) |
| `copydetect_threshold` | Similarity threshold for plagiarism (0.0-1.0) |
