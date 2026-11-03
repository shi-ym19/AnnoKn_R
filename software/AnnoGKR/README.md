# AnnoGKR with the historical DSS implementation

This subdirectory is an independent R package, based on upstream `AnnoGKR 0.1.0`
at commit `ddf7551b40bafb3398c236337871b9415e4abadd`. The local version is
`0.1.0.9001`. See [SOURCE.txt](SOURCE.txt) for provenance and changes.

It adds the exported `GK_anno_dss()` function and its three internal helpers:
`GhostKnockoff.lambda()`, `sol_beta_and_lam_ps_dss()`, and `cv_func_dss()`.
The original upstream R files and the historical DSS function expressions are
preserved. This package retains upstream's GPL-3 license.

## Install from this repository

After installing the dependencies described below, run from the repository root:

```sh
R CMD INSTALL software/AnnoGKR
```

Or let `remotes` install this subpackage and its available dependencies:

```r
remotes::install_local("software/AnnoGKR", upgrade = "never")
```

The GitHub installation command below selects this augmented subpackage. The
separate `zxy0912/AnnoGK_R` repository does not contain this DSS addition.
Install `ghostbasil` first as described below; it is not installed automatically
from GitHub by the package metadata.

## Run AnnoGK-dss

```r
library(AnnoGKR)

# Z, LD, R, and N.effect must describe the same SNPs in the same order.
# N.effect can be one sample size or a vector with one value per SNP.
set.seed(1000)
fit <- AnnoGKR::GK_anno_dss(
    Z = Z, R = R, M = 1, LD = LD, N.effect = N.effect
)
q <- AnnoGKR::GhostKnockoff.filter(fit$T_0, fit$T_k)$q
selected <- which(q <= 0.1)
```

Use `ts = "lasso"` (the default) for DSS. Direct calls to
`GhostKnockoff.fit()` should explicitly set `method = "lasso"`; the upstream
function retains a `"susie"` default despite omitting that fitting branch.
`GhostKnockoff.prelim()` in this package supports SDP.

Both this package and the root AnnoKn package export `AnnoKn()` and
`AnnoKn_lite()`. Use qualified calls, such as `AnnoKn::AnnoKn()` and
`AnnoGKR::GK_anno_dss()`, when using both packages.

The addition supplies the missing DSS method, but the historical analysis
scripts still need their paths, dependencies, and `source()` calls configured.
It does not certify complete manuscript reproduction or bitwise equivalence
between historical sourced functions and package execution.

## Upstream environment and example

# Install AnnoGK

## Create the conda environment:

```bash
conda env create -f AnnoGK.yml -n AnnoGKR_test
conda activate AnnoGKR_test
```

## Install the required `ghostbasil` package

```bash
mkdir ghostbasil
cd ghostbasil
git clone https://github.com/szcf-weiya/ghostbasil
cd ghostbasil
R CMD INSTALL .
```

## Install AnnoGK

```R
remotes::install_github("shi-ym19/AnnoKn_R", subdir = "software/AnnoGKR",
                            ref = "jasa-reproducibility", upgrade = "never")
```

# AnnoGK Pipeline Example

This example demonstrates how to use the `AnnoGKR` package to perform variable selection on simulated GWAS/TWAS data, comparing the performance of standard GhostKnockoff against annotation-informed versions.

## 1. Data Simulation
We simulate a linear trait with $N=5000$ samples and $p=600$ features, assuming an AR(1) correlation structure for the features.

```R
library(AnnoGKR)

# Simulation Parameters
seed <- 1234
set.seed(seed)
N.effect <- 5000; p <- 600; n0 <- 30; heri <- 0.1; rho <- 0.5
M <- 1; threshold <- 0.1
amplitude <- sqrt(heri / (1 - heri))

# True signal generation
sigprob <- rep(0, p); sigprob[1:60] <- 1/(1:60)^2/sum(1/(1:60)^2)
rand <- sample(1:p, n0, prob = sigprob)
rand_sign <- sample(c(-1, 1), size = p, replace = TRUE)

# Covariates and Response
Covariance <- toeplitz(rho^(0:(p-1)))
X <- scale(matrix(rnorm(N.effect*p), N.effect, p) %*% chol(Covariance))
beta <- rep(0, p);
beta[rand] = amplitude
beta = beta*rand_sign
y <- scale(X %*% beta + sqrt(n0) * rnorm(N.effect))

# Summary Statistics and LD Matrix
Z <- sapply(1:p, function(l) coef(summary(lm(y ~ X[,l])))[2,3])
LD <- cor(X)
R  <- scale(as.matrix(1:p)) # Annotation matrix
```
## 2. Comparison of Methods
We evaluate three strategies to see how incorporating structural annotations improves statistical power while controlling FDR.

Method A: Standard GhostKnockoff (No Annotations)

```R
set.seed(seed)
fit.prelim <- GhostKnockoff.prelim(cor.G = LD, M = M, method = "sdp")
GK1_lasso  <- GhostKnockoff.fit(Z, N.effect, fit.prelim, method = 'lasso')
GK.filter  <- GhostKnockoff.filter(GK1_lasso$T_0[[1]], GK1_lasso$T_k[[1]])

rej <- which(GK.filter$q <= threshold)
cat("Standard Power:", power_cal(rej, rand), "FDR:", fdr_cal(rej, rand), "\n")
```

Method B: AnnoGK-Simple (Annotation-Informed)

```R
set.seed(seed)
GK_simple_res <- GK_simple(Z=Z, R=R, M=M, LD=LD, n=N.effect, ts='lasso')
beta <- GK_simple_res$beta
GK.filter <- GhostKnockoff.filter(abs(beta[1:p]), abs(matrix(beta[-(1:p)], p, M)))

rej <- which(GK.filter$q <= threshold)
cat("Simple-Anno Power:", power_cal(rej, rand), "FDR:", fdr_cal(rej, rand), "\n")
```

Method C: Full AnnoGK-M (Multi-copy Annotation)

```R
set.seed(seed)
GK_anno_res <- GK_anno_M(Z, R, M, LD, N.effect)
GK.filter   <- GhostKnockoff.filter(GK_anno_res$T_0, GK_anno_res$T_k)

rej <- which(GK.filter$q <= threshold)
cat("Full-Anno Power:", power_cal(rej, rand), "FDR:", fdr_cal(rej, rand), "\n")
```

## 3. Performance Comparison

We evaluate three strategies to see how incorporating structural annotations improves statistical power while controlling FDR.

### Performance Summary

| Method | Power | FDR |
| :--- | :--- | :--- |
| **Standard GhostKnockoff** | 0.000 | 0.000 |
| **AnnoGK-Simple** | **0.867** | **0.000** |
| **Full AnnoGK-M** | 0.767 | 0.000 |
