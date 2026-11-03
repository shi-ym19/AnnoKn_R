# Inputs and execution order

The repository contains code, configuration and provenance. It does not yet contain the frozen input/result bundles needed to reproduce every final figure. The [94-item coverage inventory](FIGURE_TABLE_COVERAGE.md) distinguishes available analysis code, agreement of previously saved summaries, configuration differences and missing workflows.

All script paths below are relative to `reproducibility/` and are launched with `Rscript reproducibility/run.R <script> [arguments]`. Use `--check` before the script path to inspect configured roots and directly referenced source files. This check does not validate all data files or statistical package dependencies. Most simulations require a replicate index; GWAS/GTEx fits usually require a chromosome index. Inspect each driver's leading arguments and parameter settings before submitting jobs.

## Packages and source versions

- Install the root `AnnoKn` package and nested `software/AnnoGKR` package for package-based revision drivers. The latter includes `GK_anno_dss()` and its related helpers.
- Older scripts imported from `code_xiangyu.zip`, and some revision comparisons, still source historical files through `annokn_source`, `annogk_source`, and `comparison_utils`. Supply those exact versions; do not replace them with similarly named functions without checking numerical equivalence.
- `revision_helpers` resolves automatically to the bundled `helpers/revision_comparators/` directory. These helpers differ from the older comparator sources. The empty `adakn_gam.R` is not used as an implementation.
- Drivers additionally use packages including knockoff, snpknock, adaptiveKnockoff, ghostbasil, glmnet, gam, susieR, genio, bigstatsr, data.table and plotting/tidyverse packages. See each driver's `library`/`require` calls. `environment/transfer_commands.txt` preserves historical installation notes, not a complete tested environment lockfile.
- Python validation scripts use the standard library and Python 3.9+. GTEx API audits contact external services and require network access; live responses may differ from the historical responses. Freeze response/cache versions before claiming exact reproduction.

## Simulation inputs and outputs

Synthetic simulation drivers generate their own genotype/annotation/outcome data. Their readers require the full set of saved replicate files for each parameter combination. Missing-file handling differs by reader. The 1D and 5D readers remove missing-file rows and use the first 100 retained results; their search limits (150/120) are not the aggregation count. Validate the selected file IDs and ensure enough readable results.

| Module | Run first | Run afterwards | Required inputs / configuration |
| --- | --- | --- | --- |
| Original AnnoKn/AnnoGK | Generators under `simulations/annokn/` and `simulations/annogk/` | Corresponding result scripts | Historical sources/comparators; annotation mode, parameter grids, replicate sets; 1D/5D first-100-retained file lists must be frozen |
| Annotation dependence | `annotation_dependence/1dim.R`, `1dim_indep.R` | Corresponding `_result.R` | AnnoKn and comparison dependencies; separate dependent/independent files |
| Transfer | `transfer_learning/numerical_experiments_synthetic_data.R`, `numerical_experiments_new_example.R` | `plot_results.R`, `plot_results_new_example.R` | Bundled transfer helper; homogeneous filename suffix conflict (`error=""` vs `"corrected"`); heterogeneous single/all annotation settings |
| Summary AdaKn | `summary_adakn/continuous.R`, `binary.R` | `result.R` | p=300/600/1000; annotation modes. Its result slots differ from the older DSS comparison: do not mix files |
| Hybrid | `hybrid/1dim.R` | `1dim_result.R` | AnnoKn/AdaKn dependencies and complete replicate set |
| True genotype | `true_genotype/simu_insample.R`, `simu_external.R` | Corresponding result readers | UKBB PLINK and LD/region files; external 1000G PLINK for external-LD analysis. Supplied generators do not yet match the final 2Mb reader settings; see coverage inventory |

The full path-key/file-layout specification is [config/paths.tsv](config/paths.tsv). New simulation result roots are separate from old results, so incompatible method slots or filenames cannot be confused merely by sharing a directory.

## Height and SCZ fits

Height requires the ancestry-specific GIANT/Yengo summary-statistic files named in the drivers, matching ancestry-specific 1000G PLINK files (`bychr_<ancestry>/1KG_chr<chr>.bed/.bim/.fam`) and candidate-region definitions. Keep genome builds and SNP identifiers consistent. SCZ requires its ancestry-specific GWAS summary statistics, the matching PLINK reference and risk-region text files.

For Height, `real_data/height/revision/fit_single.R` writes seed 1000, while `fit_additional_seeds.R` writes seeds 100..900 under another configured output root. After verifying their input/version consistency, assemble all ten seeds under `height_ten_results` for `summarize_ten_runs.R`. Preserve the separate provenance of the single-run and ten-run inputs. Distinct historical summaries are retained in `variants/`; they are not additional independent experiments.

For SCZ, `fit_four_methods.R` and `summarize_four_methods.R` cover the four-method 100-run analysis (seeds 100..10000). `fit_baseline_subset.R` is a separate two-method script whose loop covers only repetitions 51..100; it is not a complete replacement. The manuscript's ten-run SCZ subset is not yet identified: `summarize_scz_first10_regions.R` deliberately uses seeds 100..1000, whose saved counts differ from the final ten-run table/figures.

## Writable validation workspaces

Prior revision utilities read references and write derived files in a shared analysis layout. Their configurable workspace keys are classified as input roots because they must already contain the expected inputs, but they must also be writable. Use a working copy of frozen inputs. Defaults are `data/workspaces/{height,scz,gtex}`; override each key in `config.local.R`. They are outside the tracked code directories.

### `height_validation_workspace`

```text
reference/
  genecards_height_top500.csv
  genecards_height_top1000.csv
  gencode.v19.annotation.gtf.gz
  hgnc_complete_set_2026-08-30.tsv
  hgnc_complete_set_2026-08-30.source.txt
  genecards_height_top1000_hg19_gene_positions.csv    # derived by mapping scripts
  GENECARDS_HEIGHT_TOP1000_HG19_MAPPING_COMPLETE.txt
  supplementary13.xlsx, supplementary16.xlsx
  ng3097_official_supplementary13.xlsx, ng3097_official_supplementary16.xlsx
  ng_height_gene_evidence_audit_2026-09-07/           # frozen Wood-panel audit
annot_pvalus/result/                               # all ten seeds, both ancestries
annot_pvalus/risk_region/                          # EUR/AFR_chr_<chr>.txt
height_ten_seed_region_stability_q0p1/              # generated region/overlap TSVs
```

1. Run `extract_height_ten_seed_stable_regions.R` (AFR) and `extract_height_eur_ten_seed_stable_regions.R` (EUR) on the complete saved fit outputs.
2. Run the GeneCards Top500 then Top1000 coordinate mappers with the frozen ranking, GENCODE v19 and HGNC snapshot. Keep their completion markers and mapping audits.
3. `map_height_all10_regions_to_genes.R` and the Top500/Top1000 overlap scripts produce region/gene tables. `analyze_height_all10_genecards_topN_sensitivity.R` and `count_height_eur_all10_genecards_topN.py` assemble the Top-N comparisons for Table S11. The containment rule requires the entire gene body to lie inside a selected region.
4. For Table S12, `extract_ng_height_supported_genes.py` audits the supplied XLSX reference tables; `compare_height_eur_all10_ng_height202.py` uses the frozen file named `ng_height_202_candidate_from_table9_stars_NOT_CONFIRMED.csv` in the reference audit directory. The script intentionally records the panel's unresolved provenance/build qualification; do not remove it or equate a matching count with a resolved panel audit.
5. `build_height_annogk_only_gene_evidence.py` is an ancillary literature-evidence analysis. It additionally requires `height_annogk_only_gene_evidence_2026-09-14.json` at the workspace root and the frozen coordinate/recurrence inputs. This JSON and the references are not included in the code import.

### `scz_validation_workspace`

Put four-method fits under `result/`. `summarize_scz_seed_regions.R` validates the 4,200 expected ancestry/chromosome/seed files and writes `hundred_seed_region_stability_q0p1/`. `summarize_scz_first10_regions.R` writes `first10_seed_region_stability_q0p1/`; this subset is not certified as the final ten-run manuscript data.

Ancillary SCHEMA/GeneCards checks additionally need `reference/41586_2022_4556_MOESM3_ESM.xlsx`, `reference/Singh_2022_TableS5_FDR_lt0p05_32genes.tsv`, `genecards_SCZ_top100.csv`, and the GENCODE v19 GTF under the configured **Height** workspace's `reference/`. Run the two gene-panel mappers before `compare_first10_union_gene_panels.py`. These ancillary checks do not substitute for a missing final figure workflow.

### `gtex_validation_workspace`

Place original fit results under `result/`, alternate-seed results under `new_seed/result/`, and gene coordinates under `gene_coor/`. The prior `GTEx_functional.R` uses seed 1234 and writes to `new_seed/result/`; the promoter variant uses `new_seed/result_promoter/`. They also write logs under `new_seed/`. Create the corresponding result/log subdirectories before launching these prior drivers; the workspace root is required input and the runner does not create its internal layout.

GTEx raw-data fits also require the separately configured covariate-adjusted expression, ancestry/MAF-filtered PLINK, gene/SNP coordinates and baselineLD annotations. The archive driver uses seed 1000 and a different result root. Keep seed and annotation-setting versions explicit. Select the ten manuscript tissues and both FDR thresholds; the Pancreas diagnostic is separate. Four-setting sensitivity table assembly still needs a frozen complete configuration.

`extract_gtex_annokn_only_egenes.R` derives method-specific candidates; its optional arguments are `[result_dir] [output_dir] [q] [full|structure]`. Subsequent support/overlap/seed-retention audits use the historical named subdirectories created in this workspace (or their explicit CLI overrides). Live GTEx/eQTL Catalogue API audits require frozen responses for exact repeatability. They do not implement the Jensen TISSUES enrichment figures.

## Remaining data and workflow preparation

The code import does not distribute raw genotypes, GWAS/reference data, GeneCards exports, saved RData, frozen API responses or a dependency lockfile. Before submission, prepare the permitted data/result bundles and access/preprocessing instructions, freeze all manuscript seeds/settings and resolve the explicitly missing or conflicting workflows. Repository anonymization remains a separate review-submission step.
