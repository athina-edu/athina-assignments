This repository contains assignment specs along with tests and configuration for those assignments to be implemented with Athina. It is meant to be a repository for instructors that are willing to share their assignments and tests. 

If you are an instructor that has developed tests for Athina, you are encouraged to share them here (Pull Requests are more than welcome).

If you are an instructor and want the solutions for an assignment, feel free to email the instructor that developed the assignment.

## Assignment layout

Each assignment needs its configuration and tests together in one directory, because
the grading engine clones this directory and runs the tests from within it:

```
AssignmentN/
├── athina-config/
│   ├── athina.yaml      # assignment configuration (YAML — read by the engine)
│   ├── Dockerfile       # test sandbox; built before any test runs
│   └── tests/
│       ├── test-*.R|sh  # one script per rubric section
│       └── <data files> # anything the tests read, including the instructor
│                        # reference implementation and any datasets
└── assignment-specs/    # student-facing starting point (not used at grade time)
```

Key points:

- **`athina.yaml` is YAML.** The older INI-style `.cfg` files are not read by the
  engine and fail to parse (the `[main]` header is invalid YAML).
- **Everything the tests read must be inside `tests/`.** The engine copies only
  `tests/` into the sandbox; it is the tests directory the scripts are given as
  an argument. If your tests `source()` an instructor reference file or read a
  dataset, those files belong in `tests/`.
- **A `Dockerfile` is required.** The engine builds it, then runs each test inside
  the container, so whatever runtime and libraries the tests need (R, Python,
  system packages) must be installed there.
- **Quote glob patterns.** `plagiarism_pattern: "*.R"` — an unquoted `*.R` is a
  YAML alias and the file will not parse.

## Configuration

See `NoCanvasDemo/assignment.yaml` for a fully commented example of running
without Canvas LMS (database input, GitLab issue output).

The main mode switches are:

| Setting | Values | Meaning |
|---------|--------|---------|
| `input_method` | `canvas`, `db` | Where submissions come from |
| `output_method` | `canvas`, `gitlab_issues` | Where grades and feedback go |

A `db`-input course has no Canvas connection, so `output_method` defaults to
`gitlab_issues` there.

Git credentials and the LLM API key are **not** stored in YAML. When Athina Web is
used they are taken from the faculty profile and written to a `.env` alongside the
configuration.

