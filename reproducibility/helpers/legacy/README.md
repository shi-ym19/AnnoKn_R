# Historical source dependencies

These files are the historical implementations referenced by the imported analysis drivers. They are bundled so a checkout can resolve its active `source()` calls without access to the original HPC filesystem. Only indentation, trailing whitespace and end-of-file whitespace were normalized; parsed R expressions are unchanged. Original/current hashes are recorded in [`source_manifest.tsv`](../../source_manifest.tsv).

| Configuration key | Directory | Files |
| --- | --- | --- |
| `annokn_source` | `annokn/` | `KF_anno.R` |
| `annogk_source` | `annogk/` | `GK_anno.R`, `GhostKnockoff.R` |
| `comparison_utils` | `comparison_utils/` | `all_other_methods.R`, `adaptive_knockoff.R`, `filter_EM.R`, `filter_gam.R`, `filter_glm.R`, `filter_randomForest.R`, `All_q_est_functions.R`, `accumulation_test_functions.R` |

The Figure 1 driver sources the eight comparison utilities followed by `KF_anno.R`. The other two files support older AnnoGK analyses. None of these files sources another file. The five active newer revision helpers remain in `../revision_comparators/`: some comparator implementations differ between versions, so these directories must not be merged or substituted indiscriminately. Inactive, commented-out archived source calls are not part of this bundle.

The runner resolves these keys inside the repository by default. Remove any overrides of these three keys from an older `config.local.R` to use these defaults. Installing the AnnoKn/AnnoGKR packages is still required for package-based drivers; it does not load this historical source bundle.

## R environment

Loading Figure 1 sources requires `xtune`, `adaptMT`, `splines`, `knockoff`, `SNPknock`, `dplyr`, `corpcor`, `glmnet`, `MASS`, `gam`, `randomForest`, `tidyverse`, `mgcv`, `expm`, and `rdist`. Plotting additionally uses `ggplot2`, `gridExtra`, and `grid`. Historical AnnoGK loading also needs `hdi` and `ghostbasil`; GhostKnockoff branches use `Matrix`, `Rdsdp`, `RSpectra`, `gtools`, and optionally `susieR` or Julia integrations. The optional `adaptive_knockoff()` wrapper uses `doMC`; Figure 1 uses the individual filters and does not invoke that wrapper.

[`legacy_package_versions.tsv`](../../environment/legacy_package_versions.tsv) records versions observed during the source-loading check (R 4.3.3), not a complete dependency lockfile. The installed GitHub package metadata identified these revisions:

- `JingxuanH/xtune@33d88886b6f66decb262fd90eb8e688e14d073bc`
- `lihualei71/adaptMT@d912b9f7b454803f55623e73cb371424a4fefaa2`
- `msesia/snpknock@f0d027b4891fa9a0ec2a541c231fb80a8dbbabc8` (R package name `SNPknock`)
- `szcf-weiya/ghostbasil@0f55b03db9b7641c335de16a67abbded6ac83b07`

These identifiers can be supplied to `remotes::install_github()`. Installation into a fresh environment has not yet been tested. A source-loading check can be run from the repository root after installing the dependencies:

```sh
Rscript reproducibility/tests/test_source_bundle.R reproducibility --load
Rscript reproducibility/run.R --check simulations/annokn/1dim/1dim.R 1
```

Without `--load`, the first check verifies all active analysis source paths and absence of nested source calls without loading third-party packages. These checks do not run complete simulations, test optional algorithm branches, or verify final figure values. Dataset availability, frozen simulation settings and manuscript correspondence remain documented in the main reproducibility inventory.
