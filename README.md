# AnnoKn

**AnnoKn** (Annotation-informed Knockoffs) is an R package for high-dimensional variable selection that leverages external functional annotations. By incorporating prior knowledge through an iterative optimization framework, AnnoKn improves the selection power of the knockoff filter while maintaining rigorous False Discovery Rate (FDR) control.

---

## Installation

To ensure a stable environment and correct compilation of dependencies (such as `glmnet` and `knockoff`), we recommend using **Conda** to manage your R environment.

### 1. Create a Dedicated Environment
Run the following commands in your terminal to create and activate a clean environment with the necessary R version and C++ compilers:

```bash
# Create a new environment named 'annokn_test'
conda create -n annokn_test r-base=4.3.3 r-essentials gcc_linux-64 -c conda-forge

# Activate the environment
conda activate annokn_test
