# Paper reproducibility

These scripts are being prepared for reproducibility; they are not yet a complete, ready-to-run manuscript reproduction workflow. External dependencies and input/output paths still need to be configured.

The AnnoKn implementation is in the repository's `R/` directory. The separately installable AnnoGKR package, including `GK_anno_dss()`, is in [`software/AnnoGKR/`](../software/AnnoGKR/README.md). This analysis directory is excluded from R package builds through `.Rbuildignore` and remains available in the GitHub repository.

## Import status and remaining preparation

The 17 R scripts were imported unchanged from `code_xiangyu.zip`. The [source manifest](source_manifest.tsv) records each original archive path, its repository location, and its SHA-256 checksum. Their R syntax has been checked; the full analyses have not been rerun as a portable workflow.

- Historical `source()` calls and absolute input/output paths remain in the scripts. Installing the two packages alone does not yet make these drivers runnable; package calls, legacy function names, and external comparison-method helpers still need to be reconciled.
- Input datasets and analysis outputs are not included in this initial code import. Data-access instructions, preprocessing requirements, and the full execution configuration still need to be documented.
- The true-genotype producer/reader versions and missing GTEx plotting/enrichment code require reconciliation, as noted below. Height and SCZ analysis scripts have not yet been added to this directory.

## Contents and intended order

Paths below are relative to this directory.

| Directory | Generate or fit first | Summarize or plot afterwards | Intended manuscript results |
| --- | --- | --- | --- |
| [`simulations/annokn/1dim/`](simulations/annokn/1dim/) | `1dim.R` | `1dim_result.R` | Main Figure 1; supplementary Figure S1 and part of S12 |
| [`simulations/annokn/2dim/`](simulations/annokn/2dim/) | `2dim.R` | `2dim_result.R` | Supplementary Figures S2–S4 and part of S12 |
| [`simulations/annokn/5dim/`](simulations/annokn/5dim/) | `5dim.R` | `5dim_result.R` | Supplementary Figures S8–S11 |
| [`simulations/annogk/`](simulations/annogk/) | `continuous.R`, `binary.R` | `result.R` | Main Figure 2; supplementary Figures S13–S14, S18–S20, S23 |
| [`simulations/true_genotype/`](simulations/true_genotype/) | `simu_insample.R`, `simu_external.R` | `result_insample.R`, `result_external.R`, respectively | Supplementary Figures S21–S22; producer/reader versions need reconciliation |
| [`real_data/gtex/null_diagnostics/`](real_data/gtex/null_diagnostics/) | `GTEx_check.R` | `result.R` | Supplementary Figures S30–S33; response Figures 13–16; originally `4.1GTEx` |
| [`real_data/gtex/expanded_annotations/`](real_data/gtex/expanded_annotations/) | `GTEx_functional.R` | `GTEx_result.R` | Expanded-annotation discovery analysis associated with supplementary Table S3 and Figures S35–S36; additional plotting/enrichment code is still needed; originally `4.5GTEx` |

In `simulations/annogk/`, `continuous` and `binary` describe the **annotation type**, not the outcome type.

The simulation generators read a replicate index as their first command-line argument. The two GTEx generators read a chromosome index. A full run also requires the relevant parameter combinations, tissues, seeds, and input/output locations.
