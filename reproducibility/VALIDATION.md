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

## Historical source bundle — 2026-11-03

Eleven historical source files were added under `helpers/legacy/`: one AnnoKn source, two AnnoGK/GhostKnockoff sources and eight comparison utilities. The manifest now contains 96 source records mapping to 89 distinct imported files. No analysis-driver settings or calculations were changed by this addition.

- All eleven files have identical parsed R expression trees to their original HPC copies. Only indentation, trailing whitespace and EOF whitespace were normalized. All 96 current manifest hashes match the repository files.
- All 83 R files in the reproducibility directory parse, including configuration and test infrastructure.
- The active source-path audit resolves 16 distinct files inside the checkout: the eleven additions and five previously bundled revision helpers. No nested `source()`/`sys.source()` calls were found in those files.
- Source loading passed in the existing R 4.3.3 environment: Figure 1's eight utilities and AnnoKn functions, historical AnnoGK/GhostKnockoff functions, and the separate revision helpers. The observed package versions are recorded in `environment/legacy_package_versions.tsv`.
- A copy in a different path containing spaces, without `config.local.R`, `data/`, `outputs/` or `external/`, passed the same source-loading checks and the real Figure 1 driver's `--check` preflight from another working directory. Source resolution therefore does not require the original HPC source directories.
- Existing R/Python runner tests passed after the default source-path changes.

To rerun the new checks:

```bash
Rscript reproducibility/tests/test_source_bundle.R reproducibility
# Requires the R dependencies described in helpers/legacy/README.md:
Rscript reproducibility/tests/test_source_bundle.R reproducibility --load
```

Fresh dependency installation, full simulation fits and final figure values were not tested by these source-loading checks. Optional historical branches were preserved but not executed. The previously documented data and scientific-version gaps still apply.

## Standalone main Figure 2 reader — 2026-11-03

`simulations/annogk/figure2_result.R` derives the continuous plotting block from the historical `result.R`, selecting p=1000 and keeping its arithmetic means and four plotted method slots (1/3/4/6). The generator and historical multi-figure reader remain unchanged. The new entry point checks all 300 inputs before averaging, rejects invalid metric vectors, omits exploratory plotting, and saves directly using a generic font and a supported PDF device. It also exports plotted values and input checksums.

- A run using the existing 300 historical result files succeeded. All 168 exported values and labels exactly matched the previously audited original continuous block configured for p=1000 (maximum numerical difference zero).
- That original-block plot was compared with the final manuscript Figure 2: 24 colored curve paths / 168 vertices aligned within 0.0037 PDF points after per-panel coordinate scaling and translation. This verifies curve geometry at rendering precision, not byte-identical documents or a fresh simulation run.
- A relocated fixture with known means passed through the real runner. All 168 expected means matched within 1e-12, the PDF and 300-file checksum manifest were produced, and no default `Rplots.pdf` was created. Missing inputs and invalid metric vectors both stopped the reader before replacing an existing plot.
- Both the Cairo output and an explicitly selected standard PDF fallback were exercised in the current environment.

Run the fixture check with `Rscript reproducibility/tests/test_figure2.R reproducibility` (requires ggplot2 and dplyr). The manifest now has 97 provenance records and 90 distinct imported/derived source files. Fresh dependency installation and the full generation of new Figure 2 simulation results remain untested.
