# Copy to config.local.R (git-ignored). Relative paths resolve beside that file.
# R scripts and input data are not downloaded by this configuration.
list(
  data_root = "data",
  output_root = "outputs",
  source_root = "external",
  paths = list(
    # Override a dataset independently when it is stored outside data_root:
    # gtex_expression = "/your/data/GTEx_Gene_expression_adjust_covariates",
    # gtex_plink = "/your/data/GTEx/ancestry",
    # ldsc_annotations = "/your/data/baselineLD_v2.2",
    # annokn_source = "/your/frozen/source/KF_anno",
    # annogk_source = "/your/frozen/source/GK_anno",
    # comparison_utils = "/your/frozen/source/knockoff_side/code/utils",
    # height_validation_workspace = "/your/writable/height/workspace",
    # scz_validation_workspace = "/your/writable/scz/workspace",
    # gtex_validation_workspace = "/your/writable/gtex/workspace"
  )
)
