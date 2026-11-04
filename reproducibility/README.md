# Reproducibility directory guide

UK Biobank individual-level genotypes and GTEx individual-level genotype/expression inputs are not shared here; access must be obtained from the respective providers. GWAS summary statistics, 1000 Genomes reference data, and saved analysis outputs are also external inputs.

Paths are relative to this directory. **Main** refers to the manuscript; **S** refers to the supplementary material. The tables identify the experiments and results supported by each module.

## Simulation scripts

Each generator saves replicate results; its summary script reads those results to calculate power, FDR, runtime, or annotation-coefficient summaries.

| Directory | Files and purpose | Paper section / experiment | Related results |
| --- | --- | --- | --- |
| [`simulations/annokn/1dim/`](simulations/annokn/1dim/) | `1dim.R`: generate and fit; `1dim_result.R`: summarize and plot | Main §4.1; §S4.1 — one-dimensional continuous/binary annotations | Main Fig. 1; Figs. S1, S12 (left) |
| [`simulations/annokn/2dim/`](simulations/annokn/2dim/) | `2dim.R`: generate and fit; `2dim_result.R`: signal layouts, summaries, and plots | Main §4.1; §§S4.2, S5.1 — two-dimensional annotation scenarios | Figs. S2–S4, S12 (right) |
| [`simulations/annokn/5dim/`](simulations/annokn/5dim/) | `5dim.R`: generate and fit; `5dim_result.R`: performance and coefficient plots | Main §4.1; §S5.3 — robustness to non-informative annotations | Figs. S8–S11 |
| [`simulations/annogk/`](simulations/annogk/) | `continuous.R`, `binary.R`: simulate and fit; `figure2_result.R`: main Figure 2 summary/export; `result.R`: other summaries/plots; `README.md`: Figure 2 commands | Main §4.2 — summary-statistic methods with continuous/binary annotations | Main Fig. 2; Figs. S13–S14, S18–S20, S23 |
| [`simulations/transfer_learning/`](simulations/transfer_learning/) | `numerical_experiments_synthetic_data.R` → `plot_results.R`: homogeneous setting; `numerical_experiments_new_example.R` → `plot_results_new_example.R`: heterogeneous setting | §S5.2 — transfer-learning knockoff comparisons | Figs. S5–S7 |
| [`simulations/summary_adakn/`](simulations/summary_adakn/) | `continuous.R`, `binary.R`: simulate and fit comparisons; `result.R`: summarize and plot | §S5.4 — AdaKn with summary statistics | Figs. S15–S17 |
| [`simulations/true_genotype/`](simulations/true_genotype/) | `simu_insample.R` → `result_insample.R`: sample LD; `simu_external.R` → `result_external.R`: external-reference LD | §S5.5; data described in §§S7.1–S7.2 — simulated phenotypes on UKBB genotypes | Figs. S21–S22 |
| [`simulations/annotation_dependence/`](simulations/annotation_dependence/) | `1dim.R` → `1dim_result.R`: dependent annotations; `1dim_indep.R` → `1dim_indep_result.R`: independent annotations | §S5.6 — dependence of annotations on covariates and outcomes | Figs. S24–S25 |
| [`simulations/hybrid/`](simulations/hybrid/) | `1dim.R`: fit AnnoKn and apply AdaKn filtering; `1dim_result.R`: summarize and plot | §S5.8 — combining AnnoKn with AdaKn | Fig. S27 |

## GTEx scripts

These analyses use GTEx inputs and functional annotations described in Main §5.1 and §§S7.3–S7.4. Diagnostics with simulated genotypes also use GTEx expression inputs.

| Directory | Files and purpose | Paper section / experiment | Related results |
| --- | --- | --- | --- |
| [`real_data/gtex/expanded_annotations/`](real_data/gtex/expanded_annotations/) | `GTEx_functional.R`: fit Knockoff, AnnoKn, and AdaKn; `GTEx_result.R`: eGene counts and annotation-coefficient summaries | Main §5.1; §§S6.1–S6.2 — three annotations or all 96 annotations | Main Table 1; Figs. S29, S34–S35; Table S3 |
| [`real_data/gtex/revision/`](real_data/gtex/revision/) | `fit_annotations.R`, `summarize_annotations.R`: annotation fits and counts; `export_specific_genes.R`: method-specific gene lists; `diagnostic_pancreas.R`: tissue-specific diagnostic | Main §5.1; §S6.3 — annotation comparisons and eGene interpretation | Supporting calculations for Table S4 and the GTEx discussion |
| [`real_data/gtex/null_diagnostics/`](real_data/gtex/null_diagnostics/) | `GTEx_check.R`: fit under permuted expression; `result.R`: inspect statistic distributions and signs | §S6.1 — null diagnostics with real/simulated genotypes | Figs. S30–S33 |
| [`real_data/gtex/validation/`](real_data/gtex/validation/) | `GTEx_functional.R`: alternative-seed fits; `promoter/GTEx_functional.R`: promoter-only fits | Main §5.1; §S6.3 — seed and annotation sensitivity | Tables S2, S4 |
| Same directory | `extract_gtex_annokn_only_egenes.R`: extract selected genes; `compare_gtex_method_specific_overlap.R`: compare gene sets; `audit_gtex_annokn_only_seed_stability.R`, `summarize_old_method_specific_new_seed_retention.py`: assess retention across seeds | Main §5.1 — robustness and interpretation of eGene discoveries | Supporting GTEx analyses |
| Same directory | `audit_gtex_annokn_only_egenes.py`, `audit_gtex_method_specific_egenes.py`: compare discoveries with GTEx evidence; `audit_independent_eqtl_catalogue.py`: independent eQTL support | Main §5.1 — external biological support | Supporting GTEx analyses |

## Height and schizophrenia (SCZ) scripts

These analyses use ancestry-specific GWAS summary statistics, reference genotypes, and candidate-region definitions. Data preparation is described in §§S7.2, S7.5–S7.6.

| Directory | Files and purpose | Paper section / experiment | Related results |
| --- | --- | --- | --- |
| [`real_data/height/revision/`](real_data/height/revision/) | `fit_single.R`: single-run fit; `fit_additional_seeds.R`: additional runs; `summarize_single.R`, `summarize_ten_runs.R`: discovery counts, overlap, coefficients, and gains | Main §5.2; §§S6.1, S6.5 — Height cross-ancestry analysis | Main Fig. 4 and Table 2; Figs. S38–S41; Tables S6–S7 |
| [`real_data/height/revision/variants/`](real_data/height/revision/variants/) | `reviewer2_4_summary.R`, `reviewer2_5_summary.R`: alternative summaries of Height model outputs | Main §5.2; §S6.5 — Height discovery and repeatability summaries | Related Height results above |
| [`real_data/height/validation/`](real_data/height/validation/) | `height_result.R`: Height result summaries; `extract_height_ten_seed_stable_regions.R`, `extract_height_eur_ten_seed_stable_regions.R`: AFR/EUR region sets, recurrence, and overlap | Main §5.2; §S6.5 — stable discoveries across runs | Main Fig. 4; Tables S7, S11–S12 (region inputs) |
| Same directory | `map_genecards_height_top500_to_hg19.R`, `map_genecards_height_top1000_to_hg19.R`: reference-gene coordinates; `map_height_all10_regions_to_genes.R`: region-to-gene mapping; `map_height_all10_regions_to_genecards_top500.R`, `map_height_all10_regions_to_genecards_top1000.R`: reference overlap | §S6.7 — biological interpretation of Height discoveries | Inputs for Table S11 |
| Same directory | `analyze_height_all10_genecards_topN_sensitivity.R`, `count_height_eur_all10_genecards_topN.py`: counts across GeneCards ranking thresholds | §S6.7 — GeneCards Top-N sensitivity | Table S11 |
| Same directory | `extract_ng_height_supported_genes.py`: extract/check literature reference genes; `compare_height_eur_all10_ng_height202.py`: compare selected regions with the 202-gene panel; `build_height_annogk_only_gene_evidence.py`: compile supporting gene evidence | §S6.7 — literature-based biological interpretation | Table S12 and supporting analyses |
| [`real_data/scz/revision/`](real_data/scz/revision/) | `fit_four_methods.R` → `summarize_four_methods.R`: four-method fits and summaries; `fit_baseline_subset.R` → `summarize_baseline.R`: two-method analysis | Main §5.2; §§S6.4–S6.5 — SCZ cross-ancestry comparisons and discovery frequencies | Main Table 3; Figs. S44–S45; Table S9 |
| [`real_data/scz/validation/`](real_data/scz/validation/) | `summarize_scz_seed_regions.R`: 100-run regional stability and ancestry sharing; `summarize_scz_first10_regions.R`: first-ten-run regional summaries | §§S6.5–S6.6 — randomness reduction and cross-ancestry sharing | Tables S8–S10; regional summaries related to Fig. S44 |
| Same directory | `map_scz_genecards_relevance_gt10.py`: reference-gene mapping; `compare_first10_union_gene_panels.py`, `compare_schema_silver_standard.py`: compare selected regions with gene panels | Supporting biological analyses of SCZ discoveries | Ancillary analyses |

## Shared functions, configuration, and documentation

These files support the analysis scripts rather than a separate manuscript experiment.

| File / directory | Purpose |
| --- | --- |
| [`helpers/legacy/annokn/KF_anno.R`](helpers/legacy/annokn/KF_anno.R) | AnnoKn functions sourced by individual-level analyses |
| [`helpers/legacy/annogk/`](helpers/legacy/annogk/) | `GK_anno.R`, `GhostKnockoff.R`: annotation-informed and baseline summary-statistic functions |
| [`helpers/legacy/comparison_utils/`](helpers/legacy/comparison_utils/) | `all_other_methods.R`: comparison methods; `adaptive_knockoff.R`: adaptive-knockoff wrapper; `filter_EM.R`, `filter_gam.R`, `filter_glm.R`, `filter_randomForest.R`: adaptive filters; `All_q_est_functions.R`, `accumulation_test_functions.R`: q-value and accumulation-test utilities |
| [`helpers/revision_comparators/`](helpers/revision_comparators/) | `filter_EM.R`, `filter_gam.R`, `filter_glm.R`, `filter_randomForest.R`: filters used by the comparison experiments; `transfer_functions.R`: transfer-learning helpers; `adakn_gam.R`: unused empty file |
| [`helpers/legacy/README.md`](helpers/legacy/README.md) | Source-function dependencies and R package requirements |
| [`run.R`](run.R), [`R/paths.R`](R/paths.R), [`python/run_analysis.py`](python/run_analysis.py) | Launch analyses and resolve configured paths for R/Python scripts |
| [`config.example.R`](config.example.R) | Template for local data/output settings (`config.local.R`) |
| [`config/`](config/) | `paths.tsv`: input/output keys and expected file layouts; `path_usage.tsv`: scripts using each key |
| [`environment/`](environment/) | `legacy_package_versions.tsv`: recorded R package versions; `transfer_commands.txt`: transfer-analysis environment commands |
| [`tests/`](tests/) | `test_paths.R`: runner/path checks; `test_source_bundle.R`: source-function checks; `test_figure2.R`: Figure 2 summary/export checks |
| [`DATA_REQUIREMENTS.md`](DATA_REQUIREMENTS.md) | Detailed inputs, directory layouts, and execution order |
| [`FIGURE_TABLE_COVERAGE.md`](FIGURE_TABLE_COVERAGE.md), [`FIGURE_TABLE_COVERAGE_ZH.md`](FIGURE_TABLE_COVERAGE_ZH.md) | Detailed English/Chinese figure-and-table inventories; `figure_table_map.tsv`, `FIGURE_TABLE_COVERAGE_ZH.tsv` contain tabular versions |
| [`VALIDATION.md`](VALIDATION.md) | Checks performed on the code and selected outputs |
| [`source_manifest.tsv`](source_manifest.tsv) | File provenance and checksums |

To launch a script from the repository root, use `Rscript reproducibility/run.R <script-path> [arguments]`, where `<script-path>` is relative to `reproducibility/`.
