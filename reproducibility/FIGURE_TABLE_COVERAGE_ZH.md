# AnnoKn 最终稿逐图逐表：代码对应、一致性与所需数据

整理日期：2026-11-03。代码基准为已推送的 `jasa-reproducibility` 分支提交 `2bff170b804691ca93c90c4b3f4d49062ab78e6d`。本文件针对最终稿，不沿用旧稿编号。

核对文件：`final_manu/AnnoKn_manuscript.pdf`（35 页）、`Supplementary_materials_v1.pdf`（73 页）、`Response_for_reviewer.pdf`（31 页）。正文 4 图+3 表，补充材料 45 图+12 表，共 **64 项正文/补充图表**；回复信 30 项在文末另列对应关系。下文按 PDF 中实际出现的页序排列，同页按编号排列，页码为 PDF 页码。

## 如何理解“有代码”和“一致”

- **有对应代码**：仓库中存在相关生成/拟合、汇总或绘图脚本；若缺后续步骤会明确写“部分代码”。脚本主题相同不等于默认运行即可复现。
- **保存结果相符**：此前审计核对过指定统计量与最终稿；仅对写明的指标成立，不代表原始数据拟合已重跑，也不代表整张图所有元素均已相同。
- **待核对 / 存在差异**：尚未确认最终输入/种子/参数，或已经发现重复次数、文件版本等具体冲突。
- 本次不是完整数值复现实验，**没有把任何整张图表认证为“从原始数据到最终导出已全部复现”**。已完成的代码与少量汇总验证见 [VALIDATION.md](VALIDATION.md)。

代码链接均相对本目录 `reproducibility/`。三部分代码均已整合；完全相同的副本合并记录在 [source_manifest.tsv](source_manifest.tsv)。所需原始数据、冻结参考、RData 及 API 响应尚未随代码上传；某些保存结果已存在本地 HPC，但仍需整理成可共享的数据包。

每一项分别列出“直接汇总/作图的数据”和“从头计算的数据”。配置键和文件布局见 [config/paths.tsv](config/paths.tsv)，各工作区与执行顺序见 [DATA_REQUIREMENTS.md](DATA_REQUIREMENTS.md)。历史 source 函数及比较方法依赖也是运行条件；安装 AnnoKn/AnnoGKR 两个包不能自动补齐全部旧脚本依赖。

快速跳转：[正文](#main-items) · [补充图](#supplement-figures) · [补充表](#supplement-tables) · [回复信对应](#response-items) · [优先补齐项目](#remaining-work)

<a id="main-items"></a>
## 正文：按图表在 PDF 中的出现顺序

<a id="main-figure-1"></a>
### 图 1｜一维连续注释下的个体数据方法比较（PDF 第 16 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annokn/1dim/1dim.R](simulations/annokn/1dim/1dim.R)；[simulations/annokn/1dim/1dim_result.R](simulations/annokn/1dim/1dim_result.R)。

**是否与最终稿一致：存在设置或版本差异。** 分析模型和方法系列对应，但汇总脚本读取 150 次重复，最终稿规定 100 次；需先统一重复集合。尚未重跑并逐点比对最终图。 本项选择连续注释，并同步调整输出名。

- **直接汇总/作图所需数据：** 完整的一维模拟逐参数、逐重复结果 RData（annokn_1d_results，`result_<annotation>_amp_<amp>_<replicate>.RData`），包括 power/FDR。
- **从头计算还需要：** 模拟驱动自行生成 X、Y、注释和 knockoff；无需外部真实数据。需原版 AnnoKn 与比较方法 source 文件、随机种子及参数表。

<a id="main-figure-2"></a>
### 图 2｜p=1000 的连续注释汇总统计方法比较（PDF 第 18 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annogk/continuous.R](simulations/annogk/continuous.R)；[simulations/annogk/result.R](simulations/annogk/result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 有生成及绘图代码；需按本图选择 p、注释模式和结果文件。连续图默认 p=600、二元图默认 p=300，输出名也需同步调整。尚未逐点验证最终图。 本项要求 连续注释、p=1000。

- **直接汇总/作图所需数据：** annogk_results 下所选 p、h²、连续/二元注释的完整逐次 RData；图中需读取相应方法的 power/FDR 或 time。
- **从头计算还需要：** 驱动生成 AR(1) X、Y、注释及汇总统计；无需外部真实数据。需要匹配的 AnnoKn/AnnoGK/比较函数版本。

<a id="main-table-1"></a>
### 表 1｜GTEx 十个组织、三种方法的 eGene 数量（PDF 第 20 页）

**是否有代码：** 部分代码；尚缺完整汇总/绘图流程。

代码：[real_data/gtex/expanded_annotations/GTEx_functional.R](real_data/gtex/expanded_annotations/GTEx_functional.R)；[real_data/gtex/expanded_annotations/GTEx_result.R](real_data/gtex/expanded_annotations/GTEx_result.R)；[real_data/gtex/revision/fit_annotations.R](real_data/gtex/revision/fit_annotations.R)；[real_data/gtex/revision/summarize_annotations.R](real_data/gtex/revision/summarize_annotations.R)。

**是否与最终稿一致：仅部分步骤对应。** 已有三注释（type=1：Promoter、Enhancer、TFBS）拟合及 eGene 计数逻辑。最终稿使用十个组织及 q=0.1/0.2；还需冻结匹配的种子、结果文件和全部导出步骤，尚未逐项确认完整表/图。

- **直接汇总/作图所需数据：** 十个组织、三注释、最终种子版本的逐染色体/组织/type RData（`chr_<chr>_ct_<tissue>_type_<type>.RData`），包含各方法选择统计和 eGene 列表；两种 q 阈值。
- **从头计算还需要：** GTEx 祖源/MAF 筛选后的 PLINK、协变量校正表达量、基因坐标及 hg38 SNP 映射、GRCh38 baselineLD 注释（Promoter、Enhancer、TFBS）。

<a id="main-figure-3"></a>
### 图 3｜GTEx 三注释下的 Jensen TISSUES 富集（PDF 第 21 页）

**是否有代码：** 尚无完整对应代码入库。

代码：当前仓库尚无可作为本图/表完整入口的脚本；外部候选若存在，见下述说明。

**是否与最终稿一致：暂不能验证。** 现有 GTEx 脚本只能提供候选输入基因集，完整富集检验及最终图导出尚未纳入。此前在三部分材料之外发现 GTEx_verify.R 候选，但含手工 p 值绘图，仍缺可追溯的输入、背景和原始富集响应，不能称为已复现。

- **直接汇总/作图所需数据：** 最终 q=0.2 的两方法 eGene 集、每组织全部候选基因背景、基因 ID 映射、Jensen TISSUES 数据库快照、十个组织的匹配关系及原始 Enrichr 响应。
- **从头计算还需要：** 先按正文表 1 的三注释 GTEx 输入生成匹配的基因集；还需数据库/接口版本及背景处理方式。

<a id="main-table-2"></a>
### 表 2｜Height 十次重复的 SNP / 区域发现数（PDF 第 24 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/height/revision/fit_additional_seeds.R](real_data/height/revision/fit_additional_seeds.R)；[real_data/height/revision/fit_single.R](real_data/height/revision/fit_single.R)；[real_data/height/revision/summarize_single.R](real_data/height/revision/summarize_single.R)；[real_data/height/revision/summarize_ten_runs.R](real_data/height/revision/summarize_ten_runs.R)；[real_data/height/validation/extract_height_ten_seed_stable_regions.R](real_data/height/validation/extract_height_ten_seed_stable_regions.R)；[real_data/height/validation/extract_height_eur_ten_seed_stable_regions.R](real_data/height/validation/extract_height_eur_ten_seed_stable_regions.R)。

**是否与最终稿一致：保存结果已有部分数值核对。** 已有十次运行拟合、汇总和区域验证代码。此前保存结果中的区域计数、交集/Jaccard 已核对；这一证据不能扩展为所有 SNP 数量、图中每个点或原始数据拟合均已重现。seed=1000 与 seeds=100..900 原本分开输出，需核对版本后组装完整十次结果。 区域列已有对应核对，SNP 列仍需独立逐项确认。

- **直接汇总/作图所需数据：** EUR/AFR 各染色体、seeds=100..1000 的完整十次 result_dss RData，包含区域坐标、SNP ID、q 值和方法选择；区域核对也可从逐 seed 检出 TSV 开始。
- **从头计算还需要：** 对应 GIANT/Yengo Height GWAS 汇总统计、各祖源 1000G bed/bim/fam、候选区域定义及 SNP/等位基因对齐信息。配置为 height_gwas、cross_ancestry_plink 和 Height 各 result/region 键。

<a id="main-figure-4"></a>
### 图 4｜Height 十次重复后，各人群内两种方法的重叠（PDF 第 25 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/height/revision/fit_additional_seeds.R](real_data/height/revision/fit_additional_seeds.R)；[real_data/height/revision/fit_single.R](real_data/height/revision/fit_single.R)；[real_data/height/revision/summarize_single.R](real_data/height/revision/summarize_single.R)；[real_data/height/revision/summarize_ten_runs.R](real_data/height/revision/summarize_ten_runs.R)；[real_data/height/validation/extract_height_ten_seed_stable_regions.R](real_data/height/validation/extract_height_ten_seed_stable_regions.R)；[real_data/height/validation/extract_height_eur_ten_seed_stable_regions.R](real_data/height/validation/extract_height_eur_ten_seed_stable_regions.R)。

**是否与最终稿一致：保存结果已有部分数值核对。** 已有十次运行拟合、汇总和区域验证代码。此前保存结果中的区域计数、交集/Jaccard 已核对；这一证据不能扩展为所有 SNP 数量、图中每个点或原始数据拟合均已重现。seed=1000 与 seeds=100..900 原本分开输出，需核对版本后组装完整十次结果。 图中比较的是 EUR 内、AFR 内两方法的区域重叠；不是直接画 EUR 与 AFR 的交集。

- **直接汇总/作图所需数据：** EUR/AFR 各染色体、seeds=100..1000 的完整十次 result_dss RData，包含区域坐标、SNP ID、q 值和方法选择；区域核对也可从逐 seed 检出 TSV 开始。
- **从头计算还需要：** 对应 GIANT/Yengo Height GWAS 汇总统计、各祖源 1000G bed/bim/fam、候选区域定义及 SNP/等位基因对齐信息。配置为 height_gwas、cross_ancestry_plink 和 Height 各 result/region 键。

<a id="main-table-3"></a>
### 表 3｜SCZ 四种方法、100 次重复的发现数（PDF 第 27 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/scz/revision/fit_four_methods.R](real_data/scz/revision/fit_four_methods.R)；[real_data/scz/revision/summarize_four_methods.R](real_data/scz/revision/summarize_four_methods.R)；[real_data/scz/validation/summarize_scz_seed_regions.R](real_data/scz/validation/summarize_scz_seed_regions.R)。

**是否与最终稿一致：保存结果已有部分数值核对。** 四方法 100 次拟合及汇总代码已入库。此前保存的区域汇总与最终表相符；SNP 数及从原始数据重新拟合尚未独立验证。

- **直接汇总/作图所需数据：** EUR/EAS、100 个 seed（100..10000）、除 chr21 外的 21 条常染色体四方法 RData；现有验证器预期 4,200 个文件，包含 risk_region、snp、q_gk、q_gkanno、q_transfer、rej_adakn。
- **从头计算还需要：** SCZ 各祖源 GWAS 汇总统计、匹配的 1000G 参考 PLINK、risk-region 定义、跨祖源注释及 SNP 对齐信息。

<a id="supplement-figures"></a>
## 补充材料

<a id="supplement-figure-s1"></a>
### 图 S1｜一维二元注释模拟（PDF 第 1 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annokn/1dim/1dim.R](simulations/annokn/1dim/1dim.R)；[simulations/annokn/1dim/1dim_result.R](simulations/annokn/1dim/1dim_result.R)。

**是否与最终稿一致：存在设置或版本差异。** 分析模型和方法系列对应，但汇总脚本读取 150 次重复，最终稿规定 100 次；需先统一重复集合。尚未重跑并逐点比对最终图。 本项选择二元注释，并同步调整输出名。

- **直接汇总/作图所需数据：** 完整的一维模拟逐参数、逐重复结果 RData（annokn_1d_results，`result_<annotation>_amp_<amp>_<replicate>.RData`），包括 power/FDR。
- **从头计算还需要：** 模拟驱动自行生成 X、Y、注释和 knockoff；无需外部真实数据。需原版 AnnoKn 与比较方法 source 文件、随机种子及参数表。

<a id="supplement-figure-s2"></a>
### 图 S2｜二维信号分布示意（PDF 第 2 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annokn/2dim/2dim.R](simulations/annokn/2dim/2dim.R)；[simulations/annokn/2dim/2dim_result.R](simulations/annokn/2dim/2dim_result.R)。

**是否与最终稿一致：存在设置或版本差异。** 四种场景及空间协方差代码对应补充材料 S4.2；同一最终稿 S5.1 又称协变量独立同分布，稿件描述存在差异，不能直接认定当前默认设置完全一致。 绘制信号布局的代码段还依赖未在该段初始化的 k、p 和随机种子。

- **直接汇总/作图所需数据：** 四种场景的坐标、信号位置/注释矩阵及 k、p、种子；这张示意图无需先生成所有模型拟合 RData。
- **从头计算还需要：** 驱动生成模拟数据和空间/信号位置；需源函数依赖及固定场景、种子。

<a id="supplement-figure-s3"></a>
### 图 S3｜二维连续注释模拟（PDF 第 3 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annokn/2dim/2dim.R](simulations/annokn/2dim/2dim.R)；[simulations/annokn/2dim/2dim_result.R](simulations/annokn/2dim/2dim_result.R)。

**是否与最终稿一致：存在设置或版本差异。** 四种场景及空间协方差代码对应补充材料 S4.2；同一最终稿 S5.1 又称协变量独立同分布，稿件描述存在差异，不能直接认定当前默认设置完全一致。 本项选择连续注释。

- **直接汇总/作图所需数据：** 二维四场景、注释模式、协方差类型和重复编号匹配的 RData（annokn_2d_results；文件名含 type 与 cor）。
- **从头计算还需要：** 驱动生成模拟数据和空间/信号位置；需源函数依赖及固定场景、种子。

<a id="supplement-figure-s4"></a>
### 图 S4｜二维二元注释模拟（PDF 第 3 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annokn/2dim/2dim.R](simulations/annokn/2dim/2dim.R)；[simulations/annokn/2dim/2dim_result.R](simulations/annokn/2dim/2dim_result.R)。

**是否与最终稿一致：存在设置或版本差异。** 四种场景及空间协方差代码对应补充材料 S4.2；同一最终稿 S5.1 又称协变量独立同分布，稿件描述存在差异，不能直接认定当前默认设置完全一致。 本项选择二元注释。

- **直接汇总/作图所需数据：** 二维四场景、注释模式、协方差类型和重复编号匹配的 RData（annokn_2d_results；文件名含 type 与 cor）。
- **从头计算还需要：** 驱动生成模拟数据和空间/信号位置；需源函数依赖及固定场景、种子。

<a id="supplement-figure-s5"></a>
### 图 S5｜同质注释下的迁移学习比较（PDF 第 4 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/transfer_learning/numerical_experiments_synthetic_data.R](simulations/transfer_learning/numerical_experiments_synthetic_data.R)；[simulations/transfer_learning/plot_results.R](simulations/transfer_learning/plot_results.R)。

**是否与最终稿一致：存在设置或版本差异。** 模拟与绘图逻辑均已入库；还需锁定生成/读取文件名、注释模式及完整重复集合。 同质生成器 error=""，读取器使用 error="corrected"，须先核实文件对应关系。

- **直接汇总/作图所需数据：** transfer_results 中 homogeneous 的 output* 或 heterogeneous 的 new_output_* 文件；包含每种方法的选择结果和 λ。
- **从头计算还需要：** 驱动生成多个环境的模拟数据；需固定 overlap、single/all 等参数及 bundled transfer_functions.R。

<a id="supplement-figure-s6"></a>
### 图 S6｜异质注释下的迁移学习比较（PDF 第 5 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/transfer_learning/numerical_experiments_new_example.R](simulations/transfer_learning/numerical_experiments_new_example.R)；[simulations/transfer_learning/plot_results_new_example.R](simulations/transfer_learning/plot_results_new_example.R)。

**是否与最终稿一致：存在设置或版本差异。** 模拟与绘图逻辑均已入库；还需锁定生成/读取文件名、注释模式及完整重复集合。 异质生成器默认 single，需要与论文中的 single/all 对照配置对应。

- **直接汇总/作图所需数据：** transfer_results 中 homogeneous 的 output* 或 heterogeneous 的 new_output_* 文件；包含每种方法的选择结果和 λ。
- **从头计算还需要：** 驱动生成多个环境的模拟数据；需固定 overlap、single/all 等参数及 bundled transfer_functions.R。

<a id="supplement-figure-s7"></a>
### 图 S7｜异质注释下的 λ 参数（PDF 第 6 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/transfer_learning/numerical_experiments_new_example.R](simulations/transfer_learning/numerical_experiments_new_example.R)；[simulations/transfer_learning/plot_results_new_example.R](simulations/transfer_learning/plot_results_new_example.R)。

**是否与最终稿一致：存在设置或版本差异。** 模拟与绘图逻辑均已入库；还需锁定生成/读取文件名、注释模式及完整重复集合。 异质生成器默认 single，需要与论文中的 single/all 对照配置对应。

- **直接汇总/作图所需数据：** 异质迁移实验逐重复、逐注释的估计 λ 及 single/all、overlap 对应标签；仅有 power/FDR 均值不够。
- **从头计算还需要：** 驱动生成多个环境的模拟数据；需固定 overlap、single/all 等参数及 bundled transfer_functions.R。

<a id="supplement-figure-s8"></a>
### 图 S8｜五维连续注释模拟（PDF 第 7 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annokn/5dim/5dim.R](simulations/annokn/5dim/5dim.R)；[simulations/annokn/5dim/5dim_result.R](simulations/annokn/5dim/5dim_result.R)。

**是否与最终稿一致：存在设置或版本差异。** 主题对应；汇总脚本使用 120 次重复，最终稿规定 100 次。当前默认是二元注释，λ 图输出名却写 continuous，必须按图选择注释模式并区分输出名。 本项为连续注释的 power/FDR 比较。

- **直接汇总/作图所需数据：** 五维模拟结果 RData（annokn_5d_results），包括 power/FDR 与每个注释的估计 λ。
- **从头计算还需要：** 驱动生成含信息注释及四个噪声注释的模拟数据；固定注释模式、种子和重复次数。

<a id="supplement-figure-s9"></a>
### 图 S9｜五维连续注释的 λ 参数（PDF 第 7 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annokn/5dim/5dim.R](simulations/annokn/5dim/5dim.R)；[simulations/annokn/5dim/5dim_result.R](simulations/annokn/5dim/5dim_result.R)。

**是否与最终稿一致：存在设置或版本差异。** 主题对应；汇总脚本使用 120 次重复，最终稿规定 100 次。当前默认是二元注释，λ 图输出名却写 continuous，必须按图选择注释模式并区分输出名。 本项为连续注释的 λ 分布。

- **直接汇总/作图所需数据：** 五维模拟结果 RData（annokn_5d_results），包括 power/FDR 与每个注释的估计 λ。
- **从头计算还需要：** 驱动生成含信息注释及四个噪声注释的模拟数据；固定注释模式、种子和重复次数。

<a id="supplement-figure-s10"></a>
### 图 S10｜五维二元注释模拟（PDF 第 8 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annokn/5dim/5dim.R](simulations/annokn/5dim/5dim.R)；[simulations/annokn/5dim/5dim_result.R](simulations/annokn/5dim/5dim_result.R)。

**是否与最终稿一致：存在设置或版本差异。** 主题对应；汇总脚本使用 120 次重复，最终稿规定 100 次。当前默认是二元注释，λ 图输出名却写 continuous，必须按图选择注释模式并区分输出名。 本项为二元注释的 power/FDR 比较。

- **直接汇总/作图所需数据：** 五维模拟结果 RData（annokn_5d_results），包括 power/FDR 与每个注释的估计 λ。
- **从头计算还需要：** 驱动生成含信息注释及四个噪声注释的模拟数据；固定注释模式、种子和重复次数。

<a id="supplement-figure-s11"></a>
### 图 S11｜五维二元注释的 λ 参数（PDF 第 8 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annokn/5dim/5dim.R](simulations/annokn/5dim/5dim.R)；[simulations/annokn/5dim/5dim_result.R](simulations/annokn/5dim/5dim_result.R)。

**是否与最终稿一致：存在设置或版本差异。** 主题对应；汇总脚本使用 120 次重复，最终稿规定 100 次。当前默认是二元注释，λ 图输出名却写 continuous，必须按图选择注释模式并区分输出名。 本项为二元注释的 λ 分布。

- **直接汇总/作图所需数据：** 五维模拟结果 RData（annokn_5d_results），包括 power/FDR 与每个注释的估计 λ。
- **从头计算还需要：** 驱动生成含信息注释及四个噪声注释的模拟数据；固定注释模式、种子和重复次数。

<a id="supplement-figure-s12"></a>
### 图 S12｜个体数据模拟的运行时间（PDF 第 9 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annokn/1dim/1dim.R](simulations/annokn/1dim/1dim.R)；[simulations/annokn/1dim/1dim_result.R](simulations/annokn/1dim/1dim_result.R)；[simulations/annokn/2dim/2dim.R](simulations/annokn/2dim/2dim.R)；[simulations/annokn/2dim/2dim_result.R](simulations/annokn/2dim/2dim_result.R)。

**是否与最终稿一致：存在设置或版本差异。** 有计时代码，但 1D 汇总读取 150 次而时间标签使用 each=100；最终图为 100 次。2D 时间读取文件名与另一套结果有关，还需核对完整输入集合，并记录硬件、线程及软件环境。

- **直接汇总/作图所需数据：** 1D 与 2D scenario 1 的逐次时间记录；特别核对 annokn_2d_timing_results 中不含 cor 字段的历史命名。
- **从头计算还需要：** 对应模拟驱动及依赖；还需原运行硬件、线程、R/包版本信息，才能合理比较时间。

<a id="supplement-figure-s13"></a>
### 图 S13｜连续注释汇总统计模拟，p=300（PDF 第 10 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annogk/continuous.R](simulations/annogk/continuous.R)；[simulations/annogk/result.R](simulations/annogk/result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 有生成及绘图代码；需按本图选择 p、注释模式和结果文件。连续图默认 p=600、二元图默认 p=300，输出名也需同步调整。尚未逐点验证最终图。 本项要求 连续注释、p=300。

- **直接汇总/作图所需数据：** annogk_results 下所选 p、h²、连续/二元注释的完整逐次 RData；图中需读取相应方法的 power/FDR 或 time。
- **从头计算还需要：** 驱动生成 AR(1) X、Y、注释及汇总统计；无需外部真实数据。需要匹配的 AnnoKn/AnnoGK/比较函数版本。

<a id="supplement-figure-s14"></a>
### 图 S14｜连续注释汇总统计模拟，p=600（PDF 第 11 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annogk/continuous.R](simulations/annogk/continuous.R)；[simulations/annogk/result.R](simulations/annogk/result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 有生成及绘图代码；需按本图选择 p、注释模式和结果文件。连续图默认 p=600、二元图默认 p=300，输出名也需同步调整。尚未逐点验证最终图。 本项要求 连续注释、p=600。

- **直接汇总/作图所需数据：** annogk_results 下所选 p、h²、连续/二元注释的完整逐次 RData；图中需读取相应方法的 power/FDR 或 time。
- **从头计算还需要：** 驱动生成 AR(1) X、Y、注释及汇总统计；无需外部真实数据。需要匹配的 AnnoKn/AnnoGK/比较函数版本。

<a id="supplement-figure-s15"></a>
### 图 S15｜含 AdaKn 对照的汇总统计模拟，p=300（PDF 第 12 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/summary_adakn/continuous.R](simulations/summary_adakn/continuous.R)；[simulations/summary_adakn/result.R](simulations/summary_adakn/result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 已有对应 AdaKn / summary-AdaKn 比较代码；需选择本图 p 值和连续注释设置。此版本结果第 7/8 个方法位置与旧 AnnoGK/DSS 文件含义不同，不能混读。尚未确认最终各点数值。 本项 p=300。

- **直接汇总/作图所需数据：** summary_adakn_results 中该版本专用的逐 p、h²、重复 RData；保留 AdaKn 方法顺序，不与旧 DSS 结果混用。
- **从头计算还需要：** 对应 continuous/binary 生成器及依赖生成模拟数据。

<a id="supplement-figure-s16"></a>
### 图 S16｜含 AdaKn 对照的汇总统计模拟，p=600（PDF 第 13 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/summary_adakn/continuous.R](simulations/summary_adakn/continuous.R)；[simulations/summary_adakn/result.R](simulations/summary_adakn/result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 已有对应 AdaKn / summary-AdaKn 比较代码；需选择本图 p 值和连续注释设置。此版本结果第 7/8 个方法位置与旧 AnnoGK/DSS 文件含义不同，不能混读。尚未确认最终各点数值。 本项 p=600。

- **直接汇总/作图所需数据：** summary_adakn_results 中该版本专用的逐 p、h²、重复 RData；保留 AdaKn 方法顺序，不与旧 DSS 结果混用。
- **从头计算还需要：** 对应 continuous/binary 生成器及依赖生成模拟数据。

<a id="supplement-figure-s17"></a>
### 图 S17｜含 AdaKn 对照的汇总统计模拟，p=1000（PDF 第 14 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/summary_adakn/continuous.R](simulations/summary_adakn/continuous.R)；[simulations/summary_adakn/result.R](simulations/summary_adakn/result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 已有对应 AdaKn / summary-AdaKn 比较代码；需选择本图 p 值和连续注释设置。此版本结果第 7/8 个方法位置与旧 AnnoGK/DSS 文件含义不同，不能混读。尚未确认最终各点数值。 本项 p=1000。

- **直接汇总/作图所需数据：** summary_adakn_results 中该版本专用的逐 p、h²、重复 RData；保留 AdaKn 方法顺序，不与旧 DSS 结果混用。
- **从头计算还需要：** 对应 continuous/binary 生成器及依赖生成模拟数据。

<a id="supplement-figure-s18"></a>
### 图 S18｜二元注释汇总统计模拟，p=300（PDF 第 15 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annogk/binary.R](simulations/annogk/binary.R)；[simulations/annogk/result.R](simulations/annogk/result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 有生成及绘图代码；需按本图选择 p、注释模式和结果文件。连续图默认 p=600、二元图默认 p=300，输出名也需同步调整。尚未逐点验证最终图。 本项要求 二元注释、p=300。

- **直接汇总/作图所需数据：** annogk_results 下所选 p、h²、连续/二元注释的完整逐次 RData；图中需读取相应方法的 power/FDR 或 time。
- **从头计算还需要：** 驱动生成 AR(1) X、Y、注释及汇总统计；无需外部真实数据。需要匹配的 AnnoKn/AnnoGK/比较函数版本。

<a id="supplement-figure-s19"></a>
### 图 S19｜二元注释汇总统计模拟，p=600（PDF 第 16 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annogk/binary.R](simulations/annogk/binary.R)；[simulations/annogk/result.R](simulations/annogk/result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 有生成及绘图代码；需按本图选择 p、注释模式和结果文件。连续图默认 p=600、二元图默认 p=300，输出名也需同步调整。尚未逐点验证最终图。 本项要求 二元注释、p=600。

- **直接汇总/作图所需数据：** annogk_results 下所选 p、h²、连续/二元注释的完整逐次 RData；图中需读取相应方法的 power/FDR 或 time。
- **从头计算还需要：** 驱动生成 AR(1) X、Y、注释及汇总统计；无需外部真实数据。需要匹配的 AnnoKn/AnnoGK/比较函数版本。

<a id="supplement-figure-s20"></a>
### 图 S20｜二元注释汇总统计模拟，p=1000（PDF 第 17 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annogk/binary.R](simulations/annogk/binary.R)；[simulations/annogk/result.R](simulations/annogk/result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 有生成及绘图代码；需按本图选择 p、注释模式和结果文件。连续图默认 p=600、二元图默认 p=300，输出名也需同步调整。尚未逐点验证最终图。 本项要求 二元注释、p=1000。

- **直接汇总/作图所需数据：** annogk_results 下所选 p、h²、连续/二元注释的完整逐次 RData；图中需读取相应方法的 power/FDR 或 time。
- **从头计算还需要：** 驱动生成 AR(1) X、Y、注释及汇总统计；无需外部真实数据。需要匹配的 AnnoKn/AnnoGK/比较函数版本。

<a id="supplement-figure-s21"></a>
### 图 S21｜UKBB 真实基因型模拟：样本内 LD（PDF 第 18 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/true_genotype/simu_insample.R](simulations/true_genotype/simu_insample.R)；[simulations/true_genotype/result_insample.R](simulations/true_genotype/result_insample.R)。

**是否与最终稿一致：存在设置或版本差异。** 存在明确生成/读取版本冲突。最终稿要求 2 Mb 窗口、前 100 个代表 SNP 中选 30 个因果 SNP、h²={0.02,0.05,0.1}；现有生成器使用 LD block、alphae*p 个因果 SNP、h²={0.05,0.1,0.2}，读图脚本却期待 2MB 文件。不能只改路径或文件名后视为一致。

- **直接汇总/作图所需数据：** true_genotype_paper_results 下最终 2MB、insample 版本的 RData；当前 legacy 输出不能直接替代。
- **从头计算还需要：** UKBB 筛选后的 PLINK bed/bim/fam、SNP/区域元数据；最终 2 Mb 窗口划分、因果位点及种子配置。UKBB 数据不在仓库内。

<a id="supplement-figure-s22"></a>
### 图 S22｜UKBB 真实基因型模拟：外部 LD（PDF 第 19 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/true_genotype/simu_external.R](simulations/true_genotype/simu_external.R)；[simulations/true_genotype/result_external.R](simulations/true_genotype/result_external.R)。

**是否与最终稿一致：存在设置或版本差异。** 除 S21 的窗口、因果 SNP 数、h² 和文件名差异外，现有生成器使用 0.1*I+0.9*LD；最终稿及读取端要求 shrinkage=0.2。尚未确认对应最终设置的完整生成版本。

- **直接汇总/作图所需数据：** true_genotype_paper_results 下最终 2MB、external、regu_0.2 版本的 RData。
- **从头计算还需要：** S21 的 UKBB 输入，加对应外部 1000G PLINK 参考、等位基因/SNP 对齐资料和 shrinkage=0.2 的 LD 版本。

<a id="supplement-figure-s23"></a>
### 图 S23｜汇总统计模拟的运行时间（PDF 第 20 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annogk/continuous.R](simulations/annogk/continuous.R)；[simulations/annogk/result.R](simulations/annogk/result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 有生成及绘图代码；需按本图选择 p、注释模式和结果文件。连续图默认 p=600、二元图默认 p=300，输出名也需同步调整。尚未逐点验证最终图。 本项要求 连续注释、p=1000。 运行时间图还要求 h²=0.1、100 次重复及硬件环境记录。

- **直接汇总/作图所需数据：** annogk_results 下所选 p、h²、连续/二元注释的完整逐次 RData；图中需读取相应方法的 power/FDR 或 time。
- **从头计算还需要：** 驱动生成 AR(1) X、Y、注释及汇总统计；无需外部真实数据。需要匹配的 AnnoKn/AnnoGK/比较函数版本。

<a id="supplement-figure-s24"></a>
### 图 S24｜相关注释模拟（PDF 第 21 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annotation_dependence/1dim.R](simulations/annotation_dependence/1dim.R)；[simulations/annotation_dependence/1dim_result.R](simulations/annotation_dependence/1dim_result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 已有对应模拟及读取/绘图代码；须选择正确注释场景及完整重复集合。实验主题对应，但尚未逐点核对最终图。

- **直接汇总/作图所需数据：** annotation_dependence_results 下匹配相关/独立场景的 result_*/result_indep_* RData。
- **从头计算还需要：** 对应驱动生成模拟数据及注释；无需外部真实数据。

<a id="supplement-figure-s25"></a>
### 图 S25｜独立注释模拟（PDF 第 21 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/annotation_dependence/1dim_indep.R](simulations/annotation_dependence/1dim_indep.R)；[simulations/annotation_dependence/1dim_indep_result.R](simulations/annotation_dependence/1dim_indep_result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 已有对应模拟及读取/绘图代码；须选择正确注释场景及完整重复集合。实验主题对应，但尚未逐点核对最终图。

- **直接汇总/作图所需数据：** annotation_dependence_results 下匹配相关/独立场景的 result_*/result_indep_* RData。
- **从头计算还需要：** 对应驱动生成模拟数据及注释；无需外部真实数据。

<a id="supplement-figure-s26"></a>
### 图 S26｜MLR / AnnoMLR 比较（PDF 第 22 页）

**是否有代码：** 尚无完整对应代码入库。

代码：当前仓库尚无可作为本图/表完整入口的脚本；外部候选若存在，见下述说明。

**是否与最终稿一致：暂不能验证。** 在两份 ZIP 和本次整理的既往 revision 代码中，尚未定位 MLR / AnnoMLR 的对应驱动及完整实现，不能确认数值一致性。

- **直接汇总/作图所需数据：** 尚未确认对应实现、模拟结果和绘图输入；无法据现有材料给出可执行的完整清单。
- **从头计算还需要：** 先找回 MLR/AnnoMLR 的实现及参数、种子、数据生成规范。

<a id="supplement-figure-s27"></a>
### 图 S27｜AnnoKn + AdaKn 混合方法（PDF 第 23 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[simulations/hybrid/1dim.R](simulations/hybrid/1dim.R)；[simulations/hybrid/1dim_result.R](simulations/hybrid/1dim_result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 已包含先构造 AnnoKn 统计量、再使用 AdaKn EM filter 的实现和绘图代码；尚未完整重跑或逐点确认最终图。

- **直接汇总/作图所需数据：** hybrid_results 下完整逐参数、逐重复 RData，包含混合方法与比较方法结果。
- **从头计算还需要：** 对应驱动生成模拟数据；需 AnnoKn 和 AdaKn EM 的匹配实现。

<a id="supplement-figure-s28"></a>
### 图 S28｜GTEx 50 个组织的样本量（PDF 第 24 页）

**是否有代码：** 尚无完整对应代码入库。

代码：当前仓库尚无可作为本图/表完整入口的脚本；外部候选若存在，见下述说明。

**是否与最终稿一致：暂不能验证。** 尚无 GTEx 50 组织样本量统计及最终绘图的完整驱动；已入库的 PCG 计数代码计算的是基因数，不能替代样本量。

- **直接汇总/作图所需数据：** 最终版本 GTEx v8 的 50 个组织名称、每组织可用样本数及样本纳入/排除规则。
- **从头计算还需要：** GTEx 样本/组织 metadata，以及与分析过滤一致的样本清单；若直接提供已核对样本量表，则绘图不必读取原始基因型。

<a id="supplement-figure-s29"></a>
### 图 S29｜GTEx 三注释下的 eGene 增益（PDF 第 25 页）

**是否有代码：** 部分代码；尚缺完整汇总/绘图流程。

代码：[real_data/gtex/expanded_annotations/GTEx_functional.R](real_data/gtex/expanded_annotations/GTEx_functional.R)；[real_data/gtex/expanded_annotations/GTEx_result.R](real_data/gtex/expanded_annotations/GTEx_result.R)；[real_data/gtex/revision/fit_annotations.R](real_data/gtex/revision/fit_annotations.R)；[real_data/gtex/revision/summarize_annotations.R](real_data/gtex/revision/summarize_annotations.R)。

**是否与最终稿一致：仅部分步骤对应。** 已有三注释（type=1：Promoter、Enhancer、TFBS）拟合及 eGene 计数逻辑。最终稿使用十个组织及 q=0.1/0.2；还需冻结匹配的种子、结果文件和全部导出步骤，尚未逐项确认完整表/图。 已计算 improve_prop_0 等增益量，但正式图的绘制/导出仍需补齐。

- **直接汇总/作图所需数据：** 十个组织、三注释、最终种子版本的逐染色体/组织/type RData（`chr_<chr>_ct_<tissue>_type_<type>.RData`），包含各方法选择统计和 eGene 列表；两种 q 阈值。 由相同输入计数计算 AnnoKn 相对 Knockoff 的增益，避免与另一种子或注释版本混用。
- **从头计算还需要：** GTEx 祖源/MAF 筛选后的 PLINK、协变量校正表达量、基因坐标及 hg38 SNP 映射、GRCh38 baselineLD 注释（Promoter、Enhancer、TFBS）。

<a id="supplement-figure-s30"></a>
### 图 S30｜真实基因型零假设下的 W 统计量（PDF 第 26 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/gtex/null_diagnostics/GTEx_check.R](real_data/gtex/null_diagnostics/GTEx_check.R)；[real_data/gtex/null_diagnostics/result.R](real_data/gtex/null_diagnostics/result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 有对应零假设生成及诊断代码。最终图均为 chr1、Muscle_Skeletal、置换表达量；生成器当前默认 Adipose_Subcutaneous，两个脚本都默认 simulation=TRUE。必须明确组织、真实/模拟模式及各自输出名。 本项应设 simulation=FALSE（真实基因型）。

- **直接汇总/作图所需数据：** gtex_null_results 中匹配 chr1、组织、真实/模拟模式的统计量及零假设诊断 RData；真实与模拟输出应分开。
- **从头计算还需要：** Muscle_Skeletal 的校正表达量及置换种子、GTEx 真实基因型（真实模式），或脚本生成的基因型（模拟模式）；以及相应基因/SNP 坐标及注释输入。

<a id="supplement-figure-s31"></a>
### 图 S31｜真实基因型零假设下的符号性质（PDF 第 27 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/gtex/null_diagnostics/GTEx_check.R](real_data/gtex/null_diagnostics/GTEx_check.R)；[real_data/gtex/null_diagnostics/result.R](real_data/gtex/null_diagnostics/result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 有对应零假设生成及诊断代码。最终图均为 chr1、Muscle_Skeletal、置换表达量；生成器当前默认 Adipose_Subcutaneous，两个脚本都默认 simulation=TRUE。必须明确组织、真实/模拟模式及各自输出名。 本项应设 simulation=FALSE（真实基因型）。

- **直接汇总/作图所需数据：** gtex_null_results 中匹配 chr1、组织、真实/模拟模式的统计量及零假设诊断 RData；真实与模拟输出应分开。
- **从头计算还需要：** Muscle_Skeletal 的校正表达量及置换种子、GTEx 真实基因型（真实模式），或脚本生成的基因型（模拟模式）；以及相应基因/SNP 坐标及注释输入。

<a id="supplement-figure-s32"></a>
### 图 S32｜模拟基因型零假设下的 W 统计量（PDF 第 28 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/gtex/null_diagnostics/GTEx_check.R](real_data/gtex/null_diagnostics/GTEx_check.R)；[real_data/gtex/null_diagnostics/result.R](real_data/gtex/null_diagnostics/result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 有对应零假设生成及诊断代码。最终图均为 chr1、Muscle_Skeletal、置换表达量；生成器当前默认 Adipose_Subcutaneous，两个脚本都默认 simulation=TRUE。必须明确组织、真实/模拟模式及各自输出名。 本项应设 simulation=TRUE（模拟基因型）。

- **直接汇总/作图所需数据：** gtex_null_results 中匹配 chr1、组织、真实/模拟模式的统计量及零假设诊断 RData；真实与模拟输出应分开。
- **从头计算还需要：** Muscle_Skeletal 的校正表达量及置换种子、GTEx 真实基因型（真实模式），或脚本生成的基因型（模拟模式）；以及相应基因/SNP 坐标及注释输入。

<a id="supplement-figure-s33"></a>
### 图 S33｜模拟基因型零假设下的符号性质（PDF 第 29 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/gtex/null_diagnostics/GTEx_check.R](real_data/gtex/null_diagnostics/GTEx_check.R)；[real_data/gtex/null_diagnostics/result.R](real_data/gtex/null_diagnostics/result.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 有对应零假设生成及诊断代码。最终图均为 chr1、Muscle_Skeletal、置换表达量；生成器当前默认 Adipose_Subcutaneous，两个脚本都默认 simulation=TRUE。必须明确组织、真实/模拟模式及各自输出名。 本项应设 simulation=TRUE（模拟基因型）。

- **直接汇总/作图所需数据：** gtex_null_results 中匹配 chr1、组织、真实/模拟模式的统计量及零假设诊断 RData；真实与模拟输出应分开。
- **从头计算还需要：** Muscle_Skeletal 的校正表达量及置换种子、GTEx 真实基因型（真实模式），或脚本生成的基因型（模拟模式）；以及相应基因/SNP 坐标及注释输入。

<a id="supplement-figure-s34"></a>
### 图 S34｜GTEx 三种注释的 λ 参数方向（PDF 第 30 页）

**是否有代码：** 部分代码；尚缺完整汇总/绘图流程。

代码：[real_data/gtex/expanded_annotations/GTEx_functional.R](real_data/gtex/expanded_annotations/GTEx_functional.R)；[real_data/gtex/expanded_annotations/GTEx_result.R](real_data/gtex/expanded_annotations/GTEx_result.R)；[real_data/gtex/revision/fit_annotations.R](real_data/gtex/revision/fit_annotations.R)；[real_data/gtex/revision/summarize_annotations.R](real_data/gtex/revision/summarize_annotations.R)。

**是否与最终稿一致：仅部分步骤对应。** 已收集 lambda_s，但尚未包含按 λ<-1、λ>1 对每种组织/注释汇总及导出最终图的完整步骤；有中间输入代码，不是完整绘图流程。

- **直接汇总/作图所需数据：** 十个组织、三种注释、全部可用 PCG 的 lambda_s；不能只保留显著 eGenes。需要按组织/注释汇总 λ<-1 与 λ>1 的计数。
- **从头计算还需要：** 正文表 1 对应的 GTEx 输入及同一分析版本的模型结果。

<a id="supplement-figure-s35"></a>
### 图 S35｜GTEx 全部注释下的 eGene 增益（PDF 第 31 页）

**是否有代码：** 部分代码；尚缺完整汇总/绘图流程。

代码：[real_data/gtex/expanded_annotations/GTEx_functional.R](real_data/gtex/expanded_annotations/GTEx_functional.R)；[real_data/gtex/expanded_annotations/GTEx_result.R](real_data/gtex/expanded_annotations/GTEx_result.R)；[real_data/gtex/revision/fit_annotations.R](real_data/gtex/revision/fit_annotations.R)；[real_data/gtex/revision/summarize_annotations.R](real_data/gtex/revision/summarize_annotations.R)。

**是否与最终稿一致：仅部分步骤对应。** 已有全部注释的分支，但当前默认 type=1（三注释）；需在生成和读取端都选 type=3 并确认列数。尚未冻结全部注释版本的十组织、两阈值结果。 有计数/增益计算，但正式绘图及导出尚缺。

- **直接汇总/作图所需数据：** 十个组织、全部注释（type=3）的 RData、两阈值 eGene 列表/计数，以及确切注释列清单。
- **从头计算还需要：** GTEx PLINK、校正表达量、基因/SNP 坐标和完整 baselineLD 注释版本；核实实际进入模型的注释列。

<a id="supplement-figure-s36"></a>
### 图 S36｜GTEx 全部注释下的组织富集（PDF 第 32 页）

**是否有代码：** 部分代码；尚缺完整汇总/绘图流程。

代码：[real_data/gtex/expanded_annotations/GTEx_functional.R](real_data/gtex/expanded_annotations/GTEx_functional.R)；[real_data/gtex/expanded_annotations/GTEx_result.R](real_data/gtex/expanded_annotations/GTEx_result.R)；[real_data/gtex/revision/fit_annotations.R](real_data/gtex/revision/fit_annotations.R)；[real_data/gtex/revision/summarize_annotations.R](real_data/gtex/revision/summarize_annotations.R)。

**是否与最终稿一致：仅部分步骤对应。** 现有 type=3 分支可提供全部注释的 eGene 输入；完整 Jensen 富集检验、背景处理和最终图导出仍缺失。不能用三注释的富集值替代。

- **直接汇总/作图所需数据：** 全部注释、q=0.2、最终种子对应 eGene 集，加每组织候选背景、Jensen 版本/组织映射及原始 Enrichr 响应。
- **从头计算还需要：** GTEx PLINK、校正表达量、基因/SNP 坐标和完整 baselineLD 注释版本；核实实际进入模型的注释列。

<a id="supplement-figure-s37"></a>
### 图 S37｜Height Manhattan 图（PDF 第 32 页）

**是否有代码：** 尚无完整对应代码入库。

代码：当前仓库尚无可作为本图/表完整入口的脚本；外部候选若存在，见下述说明。

**是否与最终稿一致：暂不能验证。** 本次三部分材料整合后的仓库没有完整对应绘图入口。此前另在作者目录发现 Height_popcorn.R 候选，但其确切数据/导出版本尚未整合验证；不能写成已复现。

- **直接汇总/作图所需数据：** 最终绘图用 EUR/AFR SNP 的 chr、position、p 值及筛选规则、坐标 build；图中仅绘 p<10⁻³ 的 SNP，红线为 5×10⁻⁸。
- **从头计算还需要：** 最终使用的 Height GWAS 汇总统计和绘图/过滤配置；此图本身通常不需要重新拟合 AnnoGK。

<a id="supplement-figure-s38"></a>
### 图 S38｜Height 候选区域分布（PDF 第 33 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/height/revision/fit_single.R](real_data/height/revision/fit_single.R)；[real_data/height/revision/summarize_single.R](real_data/height/revision/summarize_single.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** summarize_single.R 含候选区域计数/分布图逻辑，但 PDF 导出被注释；仍需确认 EUR 候选区域输入与最终图一致。

- **直接汇总/作图所需数据：** 最终 EUR 的逐染色体候选区域定义/计数（Height risk_region 文件）；图注采用 p<5×10⁻⁸ 信号上下游各 250 kb 并合并重叠区间；主要输入是区域定义，不是“十次都显著”的稳定区域。
- **从头计算还需要：** 最终候选区域构建所用 EUR Height GWAS 汇总统计及一致的区域生成参数。

<a id="supplement-figure-s39"></a>
### 图 S39｜Height 的 λ 参数分布（PDF 第 34 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/height/revision/summarize_ten_runs.R](real_data/height/revision/summarize_ten_runs.R)；[real_data/height/revision/variants/reviewer2_4_summary.R](real_data/height/revision/variants/reviewer2_4_summary.R)。

**是否与最终稿一致：存在设置或版本差异。** 存在明确重复次数差异：最终图注写 100 次，已检查的绘图代码聚合 10 次；保存结果中的 4,069 个 region–repetition pairs 对应十次。需核实最终图输入和图注后才能确认一致。

- **直接汇总/作图所需数据：** EUR 的显著 region–repetition 对应 lambda_s、显著性 q 值及完整 seed 清单；保存的 4,069 对需与实际图的输入核对。
- **从头计算还需要：** Height EUR/AFR GWAS 与参考基因型，或上述已保存的模型输出；先确认究竟汇总十次还是一百次。

<a id="supplement-figure-s40"></a>
### 图 S40｜Height 单次运行的方法重叠（PDF 第 35 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/height/revision/fit_single.R](real_data/height/revision/fit_single.R)；[real_data/height/revision/summarize_single.R](real_data/height/revision/summarize_single.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 有 seed=1000 的单次拟合和汇总代码；部分图片导出被注释。还需锁定最终单次输入和数值，不能仅根据“单次”标签断言完全一致。

- **直接汇总/作图所需数据：** 最终单次、候选 seed=1000 的 EUR/AFR 各染色体 result_dss RData 和候选区域文件。
- **从头计算还需要：** 同一版本 Height EUR/AFR GWAS 汇总统计及 1000G 参考、SNP 对齐和候选区域。

<a id="supplement-figure-s41"></a>
### 图 S41｜Height 十次运行的发现增益（PDF 第 36 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/height/revision/fit_additional_seeds.R](real_data/height/revision/fit_additional_seeds.R)；[real_data/height/revision/fit_single.R](real_data/height/revision/fit_single.R)；[real_data/height/revision/summarize_single.R](real_data/height/revision/summarize_single.R)；[real_data/height/revision/summarize_ten_runs.R](real_data/height/revision/summarize_ten_runs.R)；[real_data/height/validation/extract_height_ten_seed_stable_regions.R](real_data/height/validation/extract_height_ten_seed_stable_regions.R)；[real_data/height/validation/extract_height_eur_ten_seed_stable_regions.R](real_data/height/validation/extract_height_eur_ten_seed_stable_regions.R)。

**是否与最终稿一致：相关区域统计已核对；逐次增益分布待核对。** 有十次区域检出与增益绘图逻辑，保存的区域汇总已有核对；本图是十次独立运行的区域增益比率分布，仍需逐次比对。十次并集/交集相符不能直接证明分布图相同。

- **直接汇总/作图所需数据：** EUR/AFR 每次运行两方法的显著区域数，用于逐次计算 AnnoGK 相对 GhostKnockoff 的区域增益比率；无需 SNP 频率表。
- **从头计算还需要：** 对应 GIANT/Yengo Height GWAS 汇总统计、各祖源 1000G bed/bim/fam、候选区域定义及 SNP/等位基因对齐信息。配置为 height_gwas、cross_ancestry_plink 和 Height 各 result/region 键。

<a id="supplement-figure-s42"></a>
### 图 S42｜SCZ 四个人群的 Manhattan 图（PDF 第 37 页）

**是否有代码：** 尚无完整对应代码入库。

代码：当前仓库尚无可作为本图/表完整入口的脚本；外部候选若存在，见下述说明。

**是否与最终稿一致：暂不能验证。** 本次三部分材料整合后的仓库没有完整四人群 Manhattan 绘图入口。此前另发现 SCZ_popcorn.R 候选，尚未锁定最终输入及导出版本。

- **直接汇总/作图所需数据：** 最终四个人群的 SNP chr、position、p 值和各人群 GWAS 样本/数据版本、过滤规则；图中仅绘 p<10⁻³ 的 SNP，红线为 5×10⁻⁸。
- **从头计算还需要：** 最终 SCZ GWAS 汇总统计及坐标 build/绘图配置；此图本身通常不需要重新拟合 AnnoGK。

<a id="supplement-figure-s43"></a>
### 图 S43｜SCZ 候选区域分布（排除 MHC）（PDF 第 38 页）

**是否有代码：** 尚无完整对应代码入库。

代码：当前仓库尚无可作为本图/表完整入口的脚本；外部候选若存在，见下述说明。

**是否与最终稿一致：暂不能验证。** 当前三部分材料中尚无该候选区域概览图的完整绘图入口。已有 SCZ 风险区域定义可作输入，但不等于已生成最终图。

- **直接汇总/作图所需数据：** EUR SCZ 最终候选区域坐标/数量、MHC 排除边界及染色体处理规则；图注要求 p<5×10⁻⁸ 信号上下游各 250 kb、合并重叠区间并排除 chr6 MHC 区域。
- **从头计算还需要：** 最终 EUR SCZ GWAS 汇总统计、区域构建规则及必要参考信息。

<a id="supplement-figure-s44"></a>
### 图 S44｜SCZ 十次运行的区域发现频率（PDF 第 39 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/scz/revision/fit_four_methods.R](real_data/scz/revision/fit_four_methods.R)；[real_data/scz/revision/summarize_four_methods.R](real_data/scz/revision/summarize_four_methods.R)；[real_data/scz/validation/summarize_scz_first10_regions.R](real_data/scz/validation/summarize_scz_first10_regions.R)。

**是否与最终稿一致：存在设置或版本差异。** 存在结果版本冲突：归档汇总默认 100 次；现有 first10 脚本固定 seeds=100..1000，其保存结果与最终稿十次结果不一致。必须找回论文实际使用的十个种子及对应结果，不能直接把 100 改成 10。

- **直接汇总/作图所需数据：** 论文实际选定的十次 EUR/EAS 结果，包括每次区域、SNP、q 值及完整 seed 清单；当前 first10 数据不能自动视作最终输入。 本图统计对象为区域；需保留逐次检出状态，不能只提供十次并集。
- **从头计算还需要：** 与 SCZ 100 次分析相同的 GWAS/参考/区域输入，加最终十次重复所用种子和版本记录。

<a id="supplement-figure-s45"></a>
### 图 S45｜SCZ 十次运行的 SNP 发现频率（PDF 第 40 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/scz/revision/fit_four_methods.R](real_data/scz/revision/fit_four_methods.R)；[real_data/scz/revision/summarize_four_methods.R](real_data/scz/revision/summarize_four_methods.R)；[real_data/scz/validation/summarize_scz_first10_regions.R](real_data/scz/validation/summarize_scz_first10_regions.R)。

**是否与最终稿一致：存在设置或版本差异。** 存在结果版本冲突：归档汇总默认 100 次；现有 first10 脚本固定 seeds=100..1000，其保存结果与最终稿十次结果不一致。必须找回论文实际使用的十个种子及对应结果，不能直接把 100 改成 10。

- **直接汇总/作图所需数据：** 论文实际选定的十次 EUR/EAS 结果，包括每次区域、SNP、q 值及完整 seed 清单；当前 first10 数据不能自动视作最终输入。 本图统计对象为SNP；需保留逐次检出状态，不能只提供十次并集。
- **从头计算还需要：** 与 SCZ 100 次分析相同的 GWAS/参考/区域输入，加最终十次重复所用种子和版本记录。

<a id="supplement-tables"></a>
## 补充表

<a id="supplement-table-s1"></a>
### 表 S1｜GTEx 可用蛋白编码基因数与 Jensen 组织映射（PDF 第 41 页）

**是否有代码：** 部分代码；尚缺完整汇总/绘图流程。

代码：[real_data/gtex/expanded_annotations/GTEx_functional.R](real_data/gtex/expanded_annotations/GTEx_functional.R)；[real_data/gtex/expanded_annotations/GTEx_result.R](real_data/gtex/expanded_annotations/GTEx_result.R)；[real_data/gtex/revision/fit_annotations.R](real_data/gtex/revision/fit_annotations.R)；[real_data/gtex/revision/summarize_annotations.R](real_data/gtex/revision/summarize_annotations.R)。

**是否与最终稿一致：仅部分步骤对应。** 可用 PCG 计数代码已入库，但 Jensen 组织映射尚需提供明确数据表并核对十个组织的最终计数；尚未完整复现本表。

- **直接汇总/作图所需数据：** 每组织可用表达矩阵/基因清单、蛋白编码基因注释及 Jensen 目标组织映射表。
- **从头计算还需要：** 与最终稿一致的 GTEx 数据版本和过滤规则；样本量图另需样本/供体及组织 metadata。

<a id="supplement-table-s2"></a>
### 表 S2｜GTEx 更换随机种子的独立重复（PDF 第 42 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/gtex/validation/GTEx_functional.R](real_data/gtex/validation/GTEx_functional.R)；[real_data/gtex/revision/summarize_annotations.R](real_data/gtex/revision/summarize_annotations.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 既往 revision 驱动使用 seed=1234；新 ZIP 的驱动使用 seed=1000。需要锁定最终表对应的独立重复结果，并将汇总输入指向同一版本，不能混读两套结果。

- **直接汇总/作图所需数据：** 最终独立种子对应的十组织 RData；既往工作区候选为 new_seed/result/，汇总需 q=0.1/0.2。
- **从头计算还需要：** 与正文表 1 相同的三注释 GTEx 输入；只改变约定的随机种子并保留种子记录。

<a id="supplement-table-s3"></a>
### 表 S3｜GTEx 全部注释下的 eGene 数量（PDF 第 42 页）

**是否有代码：** 部分代码；尚缺完整汇总/绘图流程。

代码：[real_data/gtex/expanded_annotations/GTEx_functional.R](real_data/gtex/expanded_annotations/GTEx_functional.R)；[real_data/gtex/expanded_annotations/GTEx_result.R](real_data/gtex/expanded_annotations/GTEx_result.R)；[real_data/gtex/revision/fit_annotations.R](real_data/gtex/revision/fit_annotations.R)；[real_data/gtex/revision/summarize_annotations.R](real_data/gtex/revision/summarize_annotations.R)。

**是否与最终稿一致：仅部分步骤对应。** 已有全部注释的分支，但当前默认 type=1（三注释）；需在生成和读取端都选 type=3 并确认列数。尚未冻结全部注释版本的十组织、两阈值结果。 计数逻辑存在，仍需完成 q=0.1/0.2 及十组织组表核对；本表不要求 Jensen 富集计算。

- **直接汇总/作图所需数据：** 十个组织、全部注释（type=3）的 RData、两阈值 eGene 列表/计数，以及确切注释列清单。
- **从头计算还需要：** GTEx PLINK、校正表达量、基因/SNP 坐标和完整 baselineLD 注释版本；核实实际进入模型的注释列。

<a id="supplement-table-s4"></a>
### 表 S4｜GTEx 注释组合敏感性分析（PDF 第 43 页）

**是否有代码：** 部分代码；尚缺完整汇总/绘图流程。

代码：[real_data/gtex/validation/GTEx_functional.R](real_data/gtex/validation/GTEx_functional.R)；[real_data/gtex/validation/promoter/GTEx_functional.R](real_data/gtex/validation/promoter/GTEx_functional.R)；[real_data/gtex/revision/fit_annotations.R](real_data/gtex/revision/fit_annotations.R)；[real_data/gtex/revision/summarize_annotations.R](real_data/gtex/revision/summarize_annotations.R)。

**是否与最终稿一致：仅部分步骤对应。** 此前已核对保存的四种设置计数，与最终表十个组织的计数/汇总相符（须排除 Pancreas）。现有通用分支和 promoter 脚本尚未组成四种设置从头生成并自动组表的完整流程。

- **直接汇总/作图所需数据：** P+E+T、P+E、P、E 四套匹配的逐组织结果，两阈值计数；既往 sensitivity_annotation_settings_detail.csv 可作核对依据，但该数据文件未上传。
- **从头计算还需要：** 同一 GTEx 输入/基因集、对应四种注释子集与一致的种子/过滤规则；最终汇总排除 Pancreas。

<a id="supplement-table-s5"></a>
### 表 S5｜Height / SCZ 遗传力与跨人群遗传相关（PDF 第 44 页）

**是否有代码：** 尚无完整对应代码入库。

代码：当前仓库尚无可作为本图/表完整入口的脚本；外部候选若存在，见下述说明。

**是否与最终稿一致：暂不能验证。** 当前没有完整 Popcorn 拟合命令、输入版本、最终输出及组表流程。外部 Height_popcorn.R / SCZ_popcorn.R 是预处理候选，不能据此认定最终遗传力和遗传相关数值已复现。

- **直接汇总/作图所需数据：** 最终遗传力/遗传相关估计及标准误、日志、完整 Popcorn 命令与软件版本。
- **从头计算还需要：** Height EUR/AFR、SCZ EUR/EAS 的 GWAS 汇总统计、每人群样本量/病例对照信息、对齐的参考 LD/LD scores 和 SNP 过滤清单；具体最终文件尚未锁定。

<a id="supplement-table-s6"></a>
### 表 S6｜Height 单次运行的发现数（PDF 第 44 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/height/revision/fit_single.R](real_data/height/revision/fit_single.R)；[real_data/height/revision/summarize_single.R](real_data/height/revision/summarize_single.R)。

**是否与最终稿一致：待核对；尚未确认完整图表数值一致。** 有 seed=1000 的单次拟合和汇总代码；部分图片导出被注释。还需锁定最终单次输入和数值，不能仅根据“单次”标签断言完全一致。

- **直接汇总/作图所需数据：** 最终单次、候选 seed=1000 的 EUR/AFR 各染色体 result_dss RData 和候选区域文件。
- **从头计算还需要：** 同一版本 Height EUR/AFR GWAS 汇总统计及 1000G 参考、SNP 对齐和候选区域。

<a id="supplement-table-s7"></a>
### 表 S7｜Height 十次运行间的 Jaccard 稳定性（PDF 第 44 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/height/revision/fit_additional_seeds.R](real_data/height/revision/fit_additional_seeds.R)；[real_data/height/revision/fit_single.R](real_data/height/revision/fit_single.R)；[real_data/height/revision/summarize_single.R](real_data/height/revision/summarize_single.R)；[real_data/height/revision/summarize_ten_runs.R](real_data/height/revision/summarize_ten_runs.R)；[real_data/height/validation/extract_height_ten_seed_stable_regions.R](real_data/height/validation/extract_height_ten_seed_stable_regions.R)；[real_data/height/validation/extract_height_eur_ten_seed_stable_regions.R](real_data/height/validation/extract_height_eur_ten_seed_stable_regions.R)。

**是否与最终稿一致：保存的区域稳定性指标与最终表相符。** 已有十次区域检出及 Jaccard 汇总代码。此前保存结果按十次的全部 45 对组合计算均值±标准差，四舍五入后与最终表相符；尚未重新拟合十次模型。

- **直接汇总/作图所需数据：** EUR/AFR 每方法十次逐次区域检出集合（不是仅并集，也不是仅 all-ten 交集），以及 45 对 Jaccard 的汇总结果。
- **从头计算还需要：** 对应 GIANT/Yengo Height GWAS 汇总统计、各祖源 1000G bed/bim/fam、候选区域定义及 SNP/等位基因对齐信息。配置为 height_gwas、cross_ancestry_plink 和 Height 各 result/region 键。

<a id="supplement-table-s8"></a>
### 表 S8｜SCZ 十个重复区块间的 Jaccard 稳定性（PDF 第 44 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/scz/revision/fit_four_methods.R](real_data/scz/revision/fit_four_methods.R)；[real_data/scz/revision/summarize_four_methods.R](real_data/scz/revision/summarize_four_methods.R)；[real_data/scz/validation/summarize_scz_seed_regions.R](real_data/scz/validation/summarize_scz_seed_regions.R)。

**是否与最终稿一致：保存结果已有部分数值核对。** 此前已按 100 次运行分成十个连续区块核对保存的区域稳定性，四舍五入后与最终表相符；这是保存结果的区域级复核，未重新拟合全部模型。

- **直接汇总/作图所需数据：** SCZ 100 次逐 seed 的区域检出结果；可使用 hundred_seed_region_stability_q0p1/region_by_seed_detections.tsv 等保存汇总，再按十个区块组织。 对十区块全部 45 对组合计算 Jaccard 均值±标准差；保留区块内十次并集规则。
- **从头计算还需要：** 如果从头计算，需 SCZ GWAS、1000G 参考、候选区域及完整 100 次四方法输出。

<a id="supplement-table-s9"></a>
### 表 S9｜SCZ 十次运行的发现数（PDF 第 45 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/scz/revision/fit_four_methods.R](real_data/scz/revision/fit_four_methods.R)；[real_data/scz/revision/summarize_four_methods.R](real_data/scz/revision/summarize_four_methods.R)；[real_data/scz/validation/summarize_scz_first10_regions.R](real_data/scz/validation/summarize_scz_first10_regions.R)。

**是否与最终稿一致：存在设置或版本差异。** 存在结果版本冲突：归档汇总默认 100 次；现有 first10 脚本固定 seeds=100..1000，其保存结果与最终稿十次结果不一致。必须找回论文实际使用的十个种子及对应结果，不能直接把 100 改成 10。 已检查 first10 保存结果中 GhostKnockoff 的 EUR/EAS 区域为 42/22、AnnoGK 为 54/25；最终表为 40/13、53/16，因此不能宣称对应。

- **直接汇总/作图所需数据：** 论文实际选定的十次 EUR/EAS 结果，包括每次区域、SNP、q 值及完整 seed 清单；当前 first10 数据不能自动视作最终输入。
- **从头计算还需要：** 与 SCZ 100 次分析相同的 GWAS/参考/区域输入，加最终十次重复所用种子和版本记录。

<a id="supplement-table-s10"></a>
### 表 S10｜SCZ 跨人群共享与稳定性（PDF 第 45 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/scz/revision/fit_four_methods.R](real_data/scz/revision/fit_four_methods.R)；[real_data/scz/revision/summarize_four_methods.R](real_data/scz/revision/summarize_four_methods.R)；[real_data/scz/validation/summarize_scz_seed_regions.R](real_data/scz/validation/summarize_scz_seed_regions.R)。

**是否与最终稿一致：保存结果已有部分数值核对。** 此前已按 100 次运行分成十个连续区块核对保存的区域稳定性，四舍五入后与最终表相符；这是保存结果的区域级复核，未重新拟合全部模型。

- **直接汇总/作图所需数据：** SCZ 100 次逐 seed 的区域检出结果；可使用 hundred_seed_region_stability_q0p1/region_by_seed_detections.tsv 等保存汇总，再按十个区块组织。 每个区块的 EUR/EAS 区域集合，用于 EUR→EAS replication rate 与跨人群 Jaccard；不能代替为同一人群的区块间比较。
- **从头计算还需要：** 如果从头计算，需 SCZ GWAS、1000G 参考、候选区域及完整 100 次四方法输出。

<a id="supplement-table-s11"></a>
### 表 S11｜Height 稳定区域覆盖的 GeneCards Top-N 基因数（PDF 第 45 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/height/validation/extract_height_ten_seed_stable_regions.R](real_data/height/validation/extract_height_ten_seed_stable_regions.R)；[real_data/height/validation/extract_height_eur_ten_seed_stable_regions.R](real_data/height/validation/extract_height_eur_ten_seed_stable_regions.R)；[real_data/height/validation/map_genecards_height_top500_to_hg19.R](real_data/height/validation/map_genecards_height_top500_to_hg19.R)；[real_data/height/validation/map_genecards_height_top1000_to_hg19.R](real_data/height/validation/map_genecards_height_top1000_to_hg19.R)；[real_data/height/validation/map_height_all10_regions_to_genecards_top1000.R](real_data/height/validation/map_height_all10_regions_to_genecards_top1000.R)；[real_data/height/validation/analyze_height_all10_genecards_topN_sensitivity.R](real_data/height/validation/analyze_height_all10_genecards_topN_sensitivity.R)；[real_data/height/validation/count_height_eur_all10_genecards_topN.py](real_data/height/validation/count_height_eur_all10_genecards_topN.py)。

**是否与最终稿一致：保存计数与最终表相符，部分汇总已重新运行验证。** 此前已逐表核对 EUR/AFR Top100..1000 计数与最终稿相符。本次代码整合又在复制输入上运行 Python EUR 计数/成员表及 R AFR 四张敏感性汇总表，输出与原保存结果逐字节一致；未重新拟合 Height。AFR 的 Top200/300 是平局，不能写成所有阈值均严格提高。

- **直接汇总/作图所需数据：** EUR/AFR_all10_union_regions.tsv、冻结的 GeneCards Top1000 排名及 hg19 基因坐标、AFR 已有严格包含计数/overlap_long TSV；Top-N 分析使用原始排名而不是映射后重新排序。
- **从头计算还需要：** 若从头准备，需完整十次 Height 结果、genecards_height_top500/top1000.csv、GENCODE v19 GTF、hgnc_complete_set_2026-08-30.tsv 及其来源/映射完成标记。

<a id="supplement-table-s12"></a>
### 表 S12｜Height 稳定区域覆盖的文献 202 基因面板（PDF 第 46 页）

**是否有代码：** 有对应分析代码；需完成所列配置/核对。

代码：[real_data/height/validation/extract_height_eur_ten_seed_stable_regions.R](real_data/height/validation/extract_height_eur_ten_seed_stable_regions.R)；[real_data/height/validation/extract_ng_height_supported_genes.py](real_data/height/validation/extract_ng_height_supported_genes.py)；[real_data/height/validation/compare_height_eur_all10_ng_height202.py](real_data/height/validation/compare_height_eur_all10_ng_height202.py)。

**是否与最终稿一致：保存计数与最终表相符；参考面板来源仍有待核对。** 已保存结果与最终表相符：GhostKnockoff 为 99 个区域、45 个含参考基因区域、67 个基因（33.2%）；AnnoGK 为 192、86、119（58.9%）。但冻结的 202 基因候选面板仍保留来源/build 审计疑点，不能因计数相等认定面板来源已解决。

- **直接汇总/作图所需数据：** EUR_all10_union_regions.tsv、EUR 候选区域坐标、GENCODE v19 GTF，以及冻结 ng_height_202_candidate_from_table9_stars_NOT_CONFIRMED.csv。
- **从头计算还需要：** 若重建面板，需相应文献补充 XLSX 与官方核对副本（supplementary13/16.xlsx、ng3097_official_supplementary13/16.xlsx）及面板审计记录；从头拟合另需十次 Height 输入。

<a id="response-items"></a>
## 回复信图表：按 PDF 页序对应到上述分析

“对应”表示分析主题相同，不能自动证明回复信某个面板/方法子集与正文或补充表逐项相等。代码与数据要求沿用链接条目；回复信数值仍需针对其方法子集核对。

| 回复信图/表 | PDF 页 | 对应正文/补充条目 | 一致性证据或限制 |
| --- | --- | --- | --- |
| 图 1 | 2 | [补充图 S24](#supplement-figure-s24) | 待核对；尚未确认完整图表数值一致 |
| 图 2 | 2 | [补充图 S25](#supplement-figure-s25) | 待核对；尚未确认完整图表数值一致 |
| 图 3 | 4 | [补充图 S5](#supplement-figure-s5) | 存在设置或版本差异 |
| 图 4 | 5 | [补充图 S6](#supplement-figure-s6) | 存在设置或版本差异 |
| 图 5 | 6 | [补充图 S7](#supplement-figure-s7) | 存在设置或版本差异 |
| 表 1 | 6 | [正文表 3](#main-table-3) | 保存结果已有部分数值核对 |
| 图 6 | 8 | [补充图 S26](#supplement-figure-s26) | 暂不能验证 |
| 图 7 | 10 | [补充图 S15](#supplement-figure-s15) | 待核对；尚未确认完整图表数值一致 |
| 图 8 | 10 | [补充图 S16](#supplement-figure-s16) | 待核对；尚未确认完整图表数值一致 |
| 图 9 | 11 | [补充图 S17](#supplement-figure-s17) | 待核对；尚未确认完整图表数值一致 |
| 图 10 | 12 | [补充图 S27](#supplement-figure-s27) | 待核对；尚未确认完整图表数值一致 |
| 表 2 | 12 | [正文表 2](#main-table-2) | 保存结果已有部分数值核对 |
| 图 11 | 13 | [正文图 4](#main-figure-4) | 保存结果已有部分数值核对 |
| 图 12 | 13 | [补充图 S41](#supplement-figure-s41) | 相关区域统计已核对；逐次增益分布待核对 |
| 表 3 | 14 | [补充表 S10](#supplement-table-s10) | 保存结果已有部分数值核对 |
| 图 13 | 17 | [补充图 S30](#supplement-figure-s30) | 待核对；尚未确认完整图表数值一致 |
| 图 14 | 18 | [补充图 S31](#supplement-figure-s31) | 待核对；尚未确认完整图表数值一致 |
| 图 15 | 19 | [补充图 S32](#supplement-figure-s32) | 待核对；尚未确认完整图表数值一致 |
| 图 16 | 20 | [补充图 S33](#supplement-figure-s33) | 待核对；尚未确认完整图表数值一致 |
| 图 17 | 21 | [补充图 S34](#supplement-figure-s34) | 仅部分步骤对应 |
| 图 18 | 22 | [补充图 S39](#supplement-figure-s39) | 存在设置或版本差异 |
| 表 4 | 23 | [补充表 S4](#supplement-table-s4) | 仅部分步骤对应 |
| 表 5 | 24 | [补充表 S2](#supplement-table-s2) | 待核对；尚未确认完整图表数值一致 |
| 表 6 | 25 | [正文表 3](#main-table-3) | 保存结果已有部分数值核对 |
| 表 7 | 25 | [补充表 S7](#supplement-table-s7) | 保存的区域稳定性指标与最终表相符 |
| 表 8 | 26 | [补充表 S8](#supplement-table-s8) | 保存结果已有部分数值核对 |
| 表 9 | 27 | [正文表 1](#main-table-1) | 仅部分步骤对应 |
| 表 10 | 27 | [正文表 3](#main-table-3) | 保存结果已有部分数值核对 |
| 表 11 | 28 | [补充表 S11](#supplement-table-s11) | 保存计数与最终表相符，部分汇总已重新运行验证 |
| 表 12 | 29 | [补充表 S12](#supplement-table-s12) | 保存计数与最终表相符；参考面板来源仍有待核对 |

<a id="remaining-work"></a>
## 优先补齐项目

1. **找回/补齐完整流程：** MLR/AnnoMLR（S26）；GTEx 富集（正文图 3、S36）；50 组织样本量（S28）；Height/SCZ Manhattan 与 SCZ 候选区域图（S37、S42、S43）；Popcorn（表 S5）。GTEx S29/S34/S35 也需补齐正式汇总/导出。
2. **锁定版本差异：** 1D/5D 的 150/120 vs 100 次；UKBB S21/S22 的模拟设计；迁移模拟文件名及 single/all；SCZ 十次重复的实际 seed/result；Height S39 的 100 次图注与十次输入。
3. **整理可复现输入包：** 优先冻结可共享的逐次结果、基因/区域集合、参考面板、数据库响应和参数/种子清单，再补原始数据获取与预处理说明。对数据访问受限的分析，应说明所需授权及可公开的替代中间结果。
4. **逐项形成最终验收证据：** 先用冻结中间结果生成图/表并逐值比较，再在具备数据与计算条件时重跑生成流程。表 S11 的部分汇总已重新运行并与保存结果一致；其他条目的证据范围以上文为准。

## 稿件版本指纹

用于确认今后更换 PDF 后是否需要重新核对编号和对应关系：

| 文件 | SHA-256 |
| --- | --- |
| AnnoKn_manuscript.pdf | `cfe4e3bd13fce2ba1c7459063298bd83c06e5ea3bc65db83c2dbd316defa6c7e` |
| Supplementary_materials_v1.pdf | `78f0826e0e26fe5df7cf31a7d642614cd5a0426eab64fae36569e360047f5c7a` |
| Response_for_reviewer.pdf | `9838c67ce3cbe1765d8498815b0b58bc6d18f1ffbd0aa4114dc8b5179466b574` |

机器可读中文版清单：[FIGURE_TABLE_COVERAGE_ZH.tsv](FIGURE_TABLE_COVERAGE_ZH.tsv)。英文总清单：[figure_table_map.tsv](figure_table_map.tsv)。
