# Paper reproducibility

中文逐图逐表说明：[最终稿每张图/表的代码、一致性与数据要求](FIGURE_TABLE_COVERAGE_ZH.md)（按 PDF 出现顺序，含正文、补充材料及回复信对应关系）。

These scripts are being prepared for reproducibility; they are not yet a complete, ready-to-run manuscript reproduction workflow. External dependencies and input/output paths still need to be configured.

The AnnoKn implementation is in the repository's `R/` directory. The separately installable AnnoGKR package, including `GK_anno_dss()`, is in [`software/AnnoGKR/`](../software/AnnoGKR/README.md). This analysis directory is excluded from R package builds through `.Rbuildignore` and remains available in the GitHub repository.

## Import status and remaining preparation

The three code sources are integrated: `code_xiangyu.zip` (17 original scripts), `AnnoKn_revisionv1.zip` (38 R files plus environment notes), and 29 scripts from the prior revision workspace. Identical copies share a canonical destination; The initial integration maps 85 source records to 78 distinct files. Eleven historical source dependencies have now been added, giving 96 provenance records and 89 distinct imported files. The [source manifest](source_manifest.tsv) records original and current SHA-256 hashes and every source-to-destination mapping. The empty `adakn_gam.R` supplied in the archive is retained as a placeholder, not an implementation.

HPC path literals now use named configuration entries. Prior validation scripts use configurable writable workspaces so reference inputs and derived files retain their original layout. Statistical settings and calculations have been retained; known manuscript/version conflicts are documented, not silently resolved. Full simulations and raw-data fits have not been rerun.

- All active historical `source()` dependencies are now bundled in [`helpers/legacy/`](helpers/legacy/README.md), and their path keys resolve inside the checkout by default. Package-based revision drivers load `AnnoKn` / `AnnoGKR`. R package dependencies still need to be installed; see the helper README for the tested environment.
- The archive's five comparator/transfer helpers are bundled under `helpers/revision_comparators/`, separate from the historical comparator version.
- Datasets, saved result bundles and machine-specific profiles are not included. See [DATA_REQUIREMENTS.md](DATA_REQUIREMENTS.md) for inputs, layouts and execution order.
- See [FIGURE_TABLE_COVERAGE.md](FIGURE_TABLE_COVERAGE.md) for every final figure/table, its code, agreement evidence and required data. Integration does not certify complete manuscript reproduction.

## Configure paths and launch a script

Synthetic Figure 1 simulations use bundled sources and default local output paths without a local configuration. To customize data/output locations, copy `config.example.R` to `config.local.R` in this directory and edit the latter. The local file is ignored by Git. Each root can point to a local disk, network filesystem, or mounted data directory. A relative path is resolved beside the configuration file. The runner finds the checkout from its own location, so it can be launched from another working directory.

```r
list(
  data_root = "/your/data/annokn",
  output_root = "/your/results/annokn",
  paths = list(
    gtex_expression = "/your/expression/GTEx_Gene_expression_adjust_covariates",
    ldsc_annotations = "/your/annotations/baselineLD_v2.2"
  )
)
```

The default roots are `reproducibility/data/`, `reproducibility/outputs/`, and `reproducibility/external/`. All three directories are ignored by Git. Active source dependencies use the tracked repository root, not `external/`; the external root is retained for inactive archived code. Individual `paths` overrides take precedence over root defaults. If an older local configuration overrides `annokn_source`, `annogk_source`, or `comparison_utils`, remove those entries to use the bundled files. The [path specification](config/paths.tsv) lists every key, its default subdirectory, and the expected files; the [usage index](config/path_usage.tsv) connects those keys to scripts and current repository line numbers.

| Path keys | Required contents |
| --- | --- |
| `annokn_source`, `annogk_source` | Bundled `helpers/legacy/annokn/KF_anno.R` and `helpers/legacy/annogk/{GK_anno.R,GhostKnockoff.R}` |
| `comparison_utils` | Eight bundled historical helpers in `helpers/legacy/comparison_utils/`; kept separate from the newer revision archive versions |
| `gtex_expression` | Covariate-adjusted expression, organized by PC setting, chromosome, gene, and tissue |
| `gtex_plink` | GTEx `.bed`, `.bim`, and `.fam` files, organized by ancestry and MAF filtering |
| `gtex_gene_coordinates`, `gtex_null_gene_coordinates`, `gtex_variant_coordinates` | Per-chromosome/tissue gene coordinates and hg38 SNP identifier/position mapping files |
| `ldsc_annotations` | GRCh38 `baselineLD.<chr>.annot.gz` annotation files |
| `ukbb`, `reference_plink` | UKBB genotype/region metadata and external-reference PLINK files; genome build and cohort must match the selected experiment |
| `annokn_2d_timing_results`, `true_genotype_paper_results` | Precomputed results expected by historical readers whose producing versions are still being reconciled |
| Other active result, log, and plot keys | Generated output directories; the runner creates directories as needed when an analysis is launched |

First check the configured input roots and directly referenced source files:

```bash
Rscript reproducibility/run.R --check simulations/annokn/1dim/1dim.R 1
Rscript reproducibility/run.R --check real_data/gtex/expanded_annotations/GTEx_functional.R 1
```

Then launch the selected analysis without `--check`:

```bash
Rscript reproducibility/run.R simulations/annokn/1dim/1dim.R 1
```

The example final argument is the replicate index for these simulations or chromosome index for these GTEx drivers; other scripts have their own argument conventions. Python validation scripts use the same runner, for example:

```bash
Rscript reproducibility/run.R --check real_data/height/validation/count_height_eur_all10_genecards_topN.py
Rscript reproducibility/run.R real_data/height/validation/count_height_eur_all10_genecards_topN.py
```

Python defaults to `python3`; set `ANNOKN_PYTHON` to choose another executable (Python 3.9+). Scripts now use this runner rather than being invoked directly. For a configuration stored elsewhere, set `ANNOKN_REPRO_CONFIG` to its filename. A local profile is machine-specific and must be checked for each module. New experiment outputs default to `outputs/`; validation scripts write derived files inside their configured writable workspace.

`--check` does not run the experiment or create output directories. It checks directory presence and directly referenced source files, not every chromosome/result file, R package installation, or agreement with the final manuscript. Dataset downloads, preprocessing, and statistical dependencies still need to be supplied. Keep the separately named legacy/final-result directories distinct until their experimental versions have been reconciled.

Infrastructure checks can be run without fitting models:

```bash
Rscript reproducibility/tests/test_paths.R reproducibility
Rscript reproducibility/tests/test_source_bundle.R reproducibility
# After installing R dependencies, also check source loading:
Rscript reproducibility/tests/test_source_bundle.R reproducibility --load
```

## Correspondence to the final manuscript

The correspondence below was checked on 2026-11-03 against `AnnoKn_manuscript.pdf` (35 pages), `Supplementary_materials_v1.pdf` (73 pages), and `Response_for_reviewer.pdf` (31 pages). Figure and table numbering in the original directory map remains valid. **A correspondence identifies relevant analysis code; it does not certify that the scripts' current defaults reproduce the final figure or table.**

The [figure/table inventory](figure_table_map.tsv) records all 94 numbered figures and tables across these three documents, their PDF pages, available repository scripts, and configuration or coverage gaps. Its `not_in_repository` entries refer to analysis drivers, not to the AnnoKn/AnnoGKR package implementations. The revision archive and prior workspace scripts are included. Missing workflows and scientific-version conflicts remain explicitly marked.

## Contents and intended order

Paths below are relative to this directory.

| Directory | Generate or fit first | Summarize or plot afterwards | Final-manuscript correspondence and qualifications |
| --- | --- | --- | --- |
| [`simulations/annokn/1dim/`](simulations/annokn/1dim/) | `1dim.R` | `1dim_result.R` | Main Figure 1; S1; S12 left panel. HMM design matches the manuscript; reader searches IDs 1..150, removes missing-file rows and summarizes only the first 100 retained runs, matching the manuscript count. Freeze the actual selected IDs. Switch annotation type and export name for S1. |
| [`simulations/annokn/2dim/`](simulations/annokn/2dim/) | `2dim.R` | `2dim_result.R` | S2–S4; S12 right panel. The spatial covariance matches supplement Section S4.2; Section S5.1 instead describes i.i.d. entries. Switch annotation type for S4. S2 plotting needs explicit initialization of `k`, `p`, and the seed. |
| [`simulations/annokn/5dim/`](simulations/annokn/5dim/) | `5dim.R` | `5dim_result.R` | S8–S11. Reader searches IDs 1..120 but slices power/FDR/lambda arrays to 100 retained runs, matching Section S5.3; select continuous/binary annotations for each pair of figures and correct the export names. |
| [`simulations/annogk/`](simulations/annogk/) | `continuous.R`, `binary.R` | `result.R` | Main Figure 2 (`p=1000`); S13–S14 (continuous, `p=300,600`); S18–S20 (binary, `p=300,600,1000`); S23 (runtime). Plotting defaults are continuous `p=600` and binary `p=300`; repeat with the other values and distinct export names. These scripts do not generate S15–S17's AdaKn comparison. |
| [`simulations/true_genotype/`](simulations/true_genotype/) | `simu_insample.R`, `simu_external.R` | `result_insample.R`, `result_external.R`, respectively | S21–S22 are intended targets, but the imported producers do not match the final experiment: region definition, causal count, heritability grid, output names, and external-LD shrinkage require reconciliation. |
| [`real_data/gtex/null_diagnostics/`](real_data/gtex/null_diagnostics/) | `GTEx_check.R` | `result.R` | S30–S31 / response Figures 13–14 use real genotypes; S32–S33 / response Figures 15–16 use simulated genotypes. Both use permuted expression and skeletal muscle. Generator currently selects adipose tissue; both scripts default to simulated genotypes. Configure tissue/mode and separate export names. |
| [`real_data/gtex/expanded_annotations/`](real_data/gtex/expanded_annotations/) | `GTEx_functional.R` | `GTEx_result.R` | Related fitting/counting code for Table S3 and S35 after selecting all annotations (`type=3`); defaults are three annotations (`type=1`). S36 requires enrichment analysis and plotting that are absent here. The three-annotation branch also provides related calculations for main Table 1 and S29, but exact input runs, both FDR thresholds, and final exports remain unverified. |

### Specific issues to resolve before reproduction

- **Runtime S12:** the 1D reader truncates its timing vectors to 100 entries, consistently with `each=100`. Searching result IDs up to 150 does not imply aggregating 150 runs. Freeze the selected file list and verify the 2D historical timing inputs and runtime environment.
- **True-genotype S21–S22:** Section S5.5 specifies 2 Mb windows, 30 causal representatives from the first 100, and `h2={0.02,0.05,0.1}`. Imported generators use LD-block coordinates, `alphae*p` causal representatives, and `h2={0.05,0.1,0.2}`. Readers expect `2MB` result filenames that those producers do not write. The external producer uses `0.1*I + 0.9*LD`, whereas the manuscript and reader specify shrinkage 0.2.
- **GTEx all-annotation results:** select `type=3` in both fitting and summary scripts, verify the resulting annotation columns, run all ten tissues and both FDR thresholds, and supply the missing gain plot (S35) and enrichment analysis/plot (S36). The directory name does not determine the active annotation setting.
- **Simulation aggregation:** missing-file handling must be checked per reader. The 1D and 5D readers remove missing-file rows before taking their first 100 retained results; they do not average those missing rows as zeros. Freeze selected IDs and ensure enough readable results before summarizing.

### Newly integrated revision modules

| Directory | Contents | Main targets |
| --- | --- | --- |
| `simulations/transfer_learning/` | Homogeneous/heterogeneous transfer simulations and plots | S5–S7 |
| `simulations/summary_adakn/` | Summary-statistic AdaKn comparisons | S15–S17 |
| `simulations/annotation_dependence/` | Dependent/independent annotation simulations | S24–S25 |
| `simulations/hybrid/` | AnnoKn statistic with AdaKn EM filtering | S27 |
| `helpers/revision_comparators/` | Five helper implementations and one empty archive placeholder | Revision simulations and SCZ AdaKn |
| `real_data/height/revision/` | Single/additional-seed fits and summaries; distinct summary variants retained in `variants/` | Main Figure 4, Table 2; S38–S41; Tables S6–S7 |
| `real_data/height/validation/` | Ten-seed region extraction, gene mapping, GeneCards/Wood-panel comparisons and ancillary evidence checks | Tables S11–S12 and supporting regional checks |
| `real_data/scz/revision/` | Baseline subset and four-method 100-run fits/summaries | Main Table 3; regional stability and frequency analyses |
| `real_data/scz/validation/` | 100-/10-seed region summaries and ancillary gene-panel checks | Tables S8–S10; ten-run version conflict remains |
| `real_data/gtex/revision/` | Archive annotation fits/counts, Pancreas diagnostic and gene export | GTEx count/sensitivity supporting analyses |
| `real_data/gtex/validation/` | Prior seed-1234/promoter drivers, eGene extraction and independent-support checks | Table S2/S4 supporting analyses and biological interpretation |
| `environment/transfer_commands.txt` | Original transfer-environment installation notes | Historical reference, not a complete lockfile |

The MLR/AnnoMLR driver (S26) is still not located. GTEx enrichment (main Figure 3/S36), Popcorn Table S5 and several descriptive plotting workflows remain incomplete. True-genotype settings, SCZ ten-run seeds and the Height lambda plot's repetition count still require reconciliation. Details are itemized in the coverage document.

In `simulations/annogk/`, `continuous` and `binary` describe the **annotation type**, not the outcome type.

The simulation generators read a replicate index as their first command-line argument. The two GTEx generators read a chromosome index. A full run also requires the relevant parameter combinations, tissues, seeds, and input/output locations.
