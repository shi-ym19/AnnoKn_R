# AnnoKn

**AnnoKn** (Annotation-informed Knockoffs) is an R package for high-dimensional variable selection that leverages external functional annotations. By incorporating prior knowledge through an iterative optimization framework, AnnoKn improves the selection power of the knockoff filter while maintaining rigorous False Discovery Rate (FDR) control.

---

## Paper reproducibility

The [reproducibility directory](reproducibility/README.md) integrates the original code archive, revision archive, and prior revision analyses: simulations, GTEx, Height, SCZ, and gene/region validation. See the [final figure/table coverage](reproducibility/FIGURE_TABLE_COVERAGE.md) and [data requirements](reproducibility/DATA_REQUIREMENTS.md) for execution order, agreement evidence, and remaining gaps. This is not yet a complete end-to-end manuscript reproduction workflow.

## Summary-statistic package (AnnoGKR)

The independent [AnnoGKR package](software/AnnoGKR/README.md) is included under
`software/AnnoGKR/`. It contains `GK_anno_M()`, `GK_simple()`, and the historical
`GK_anno_dss()` implementation needed by the DSS simulation comparisons.
Install it separately; installing the root AnnoKn package does not install it.
See its README for dependencies and local or GitHub installation commands.

## Installation

To ensure a stable environment and correct compilation of dependencies (such as `glmnet` and `knockoff`), we recommend using **Conda** to manage your R environment.

### 1. Create a Dedicated Environment
Run the following commands in your terminal to create and activate a clean environment with the necessary R version and C++ compilers:

```bash
# Create a new environment named 'annokn_test'
conda create -n annokn_test r-base=4.3.3 r-essentials gcc_linux-64 -c conda-forge

# Activate the environment
conda activate annokn_test
```

### 2. Install from GitHub
Once the Conda environment is active, launch R and use the remotes package to install AnnoKn directly from this repository:

R
```bash
# Install the remotes package if not already installed
if (!requireNamespace("remotes", quietly = TRUE)) {
    install.packages("remotes")
}

# Install AnnoKn_R from GitHub
remotes::install_github("shi-ym19/AnnoKn_R", ref = "jasa-reproducibility")
```

## Quick Start

This example demonstrates how to use **AnnoKn** to perform variable selection in a high-dimensional setting ($p \approx n$). We simulate a scenario with an AR(1) covariance structure and external functional annotations that provide prior information about causal SNPs.

```R
library(AnnoKn)
library(knockoff)
library(glmnet)

# 1. Simulation Setup
set.seed(1000)
n = 1000  # Number of samples
p = 900   # Number of SNPs
k = 150   # Number of causal SNPs
rho = 0.5 # Correlation strength (AR(1))

# Generate causal SNP indices with decaying probability
sigprob = rep(0, p)
sigprob[1:300] = 1/(1:300)^2 / (sum(1/(1:300)^2))
nonzero = sample(1:p, k, prob = sigprob)

# Generate AR(1) covariates and response vector
Covariance = toeplitz(rho^(0:(p-1)))
X = matrix(rnorm(n * p), n, p) %*% chol(Covariance)
X = scale(X)
beta0 = 3.5 * (1:p %in% nonzero) * sign(rnorm(p)) / sqrt(n)
y = X %*% beta0 + rnorm(n)
y = (y - mean(y)) / sd(y)

# Generate the annotation matrix R (Standardized)
z <- 1:p
R <- scale(as.matrix(z))

# Generate knockoff copies
Xk = create.gaussian(X, rep(0, p), Covariance)

# ---------------------------------------------------------
# 2. Performance Comparison
# ---------------------------------------------------------

# Method 1: Original Knockoff 
mdl = cv.glmnet(cbind(X, Xk), y, alpha = 1)
beta_std = mdl$glmnet.fit$beta[, mdl$lambda == mdl$lambda.min]
W_std = abs(beta_std[1:p]) - abs(beta_std[(p+1):(2*p)])
tau_std = knockoff.threshold(W_std, fdr = 0.1, offset = 1)
rej_std = which(W_std >= tau_std)

# Method 2: AnnoKn 
result_annokn = AnnoKn(X = X, Xk = Xk, y = y, attempts = c(0), R = R)
W_annokn = abs(result_annokn$beta[1:p]) - abs(result_annokn$beta[(p+1):(2*p)])
tau_annokn = knockoff.threshold(W_annokn, fdr = 0.1, offset = 1)
rej_annokn = which(W_annokn >= tau_annokn)

# Method 3: AnnoKn-lite 
result_lite = AnnoKn_lite(X = X, Xk = Xk, y = y, R = R)
W_lite = abs(result_lite$beta[1:p]) - abs(result_lite$beta[(p+1):(2*p)])
tau_lite = knockoff.threshold(W_lite, fdr = 0.1, offset = 1)
rej_lite = which(W_lite >= tau_lite)

# ---------------------------------------------------------
# 3. Evaluate Results
# ---------------------------------------------------------
cat("Standard Knockoff - Power:", power_cal(rej_std, nonzero), "FDR:", fdr_cal(rej_std, nonzero), "\n")
cat("AnnoKn            - Power:", power_cal(rej_annokn, nonzero), "FDR:", fdr_cal(rej_annokn, nonzero), "\n")
cat("AnnoKn-lite       - Power:", power_cal(rej_lite, nonzero), "FDR:", fdr_cal(rej_lite, nonzero), "\n")
```

### Simulation Results

Based on the simulation with $n=1000, p=900, k=150$, and an AR(1) covariance structure ($\rho=0.5$), the comparison between the standard knockoff filter and **AnnoKn** is summarized below:

| Method | Statistical Power | Realized FDR |
| :--- | :---: | :---: |
| **Standard Knockoff** | 27.3% | 0.0% |
| **AnnoKn** | **66.7%** | 9.9% |
| **AnnoKn-lite** | 65.3% | 10.1% |

**Interpretation:**
- **Standard Knockoff:** Maintains a very conservative FDR but suffers from low power in the presence of correlated covariates.
- **AnnoKn / AnnoKn-lite:** By incorporating functional annotations, the power is more than doubled (~2.4x increase) while successfully controlling the FDR near the target level ($\alpha = 0.1$).
