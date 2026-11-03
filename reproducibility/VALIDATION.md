# Integration validation — 2026-11-03

Scope: code integration and path portability, not a complete rerun of the manuscript.

- All 85 source records were checked against the original ZIP members or prior workspace files using SHA-256. Exact duplicate files share a destination. The 78 unique imported files comprise 66 R files (including the archive's empty placeholder), 11 Python files and one environment-note file.
- All imported R and Python files parse, along with the runner and test infrastructure.
- For the original 17 R scripts, resolving named paths to their original locations and removing the runner guard yields identical expression trees. For the 49 newly imported R files, parsed expressions match the originals after the recorded path/workspace substitutions and runner guards. Whitespace was normalized without changing calculations.
- The R/Python runner integration tests pass for relocated checkouts, filenames/arguments containing spaces, script identity, output-subdirectory creation, dry runs, unknown path keys and missing inputs/sources. Dry runs do not create output directories. The bundled transfer helper also passes a real-driver path preflight.
- On a separate writable copy of frozen Height inputs, the imported Python Top-N script reproduced the EUR counts, region-gene pairs and method-gene tables byte-for-byte, and passed its internal checks against the saved AFR counts and region-gene memberships.
- On that copied workspace, the imported R Top-N sensitivity script reproduced all four saved AFR summary TSVs byte-for-byte. Fresh metadata differ as expected because script hashes and workspace locations changed. Original analysis data and results were not overwritten.
- The final coverage inventory contains 94 numbered figures/tables across the main manuscript, supplementary materials and response. All linked repository script paths exist. Prior agreement with manuscript numbers is labeled separately from this integration validation.

The infrastructure tests can be rerun without research data:

```bash
Rscript reproducibility/tests/test_paths.R reproducibility
```

The Height checks require the frozen inputs described in [DATA_REQUIREMENTS.md](DATA_REQUIREMENTS.md). Full simulations, genotype/GWAS fits, live API audits, dependency installation and end-to-end reproduction of all final figures were not run in this integration. Missing workflows and version conflicts remain in [FIGURE_TABLE_COVERAGE.md](FIGURE_TABLE_COVERAGE.md).
