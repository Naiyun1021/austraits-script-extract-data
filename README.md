
# 🌿 AusTraits Script: Extract & Summarise Plant Trait Data

This repository provides an R script to extract, clean, and summarise trait data for Australian plant species using the [AusTraits](https://github.com/traitecoevo/austraits) dataset.

🔗 **Repo URL:** [github.com/Naiyun1021/austraits-script-extract-data](https://github.com/Naiyun1021/austraits-script-extract-data)

---

## 📋 What This Script Does

The script:
- Installs required R packages
- Downloads the most recent AusTraits dataset from Zenodo
- Loads a list of target plant species and traits
- Separates traits into **categorical** and **numeric**
- Summarises trait data for your species list
- Saves a final summary CSV with wide-format traits

---

## 🗂️ Files in This Repo

| File | Description |
|------|-------------|
| `final_trait_summary_script.R` | Main script to extract and summarise traits |
| `ALA-Plant-checklist-2025-04-21.csv` | CSV input: list of species names |
| `TraitsCombine-helen-Dorothy.xlsx` | Excel input: list of trait names |
| `final_trait_summary.csv` | Output: wide-form summary of traits (created after running the script) |

---

## 🚀 How to Run the Script

### ✅ 1. Clone This Repository

```bash
git clone https://github.com/Naiyun1021/austraits-script-extract-data.git
cd austraits-script-extract-data
```

### ✅ 2. Open the R Script

Open `final_trait_summary_script.R` in **RStudio** or another R environment.

### ✅ 3. Ensure Input Files Are in the Same Folder

Make sure these files are present:
- `ALA-Plant-checklist-2025-04-21.csv`
- `TraitsCombine-helen-Dorothy.xlsx`

### ✅ 4. Run the Script

The script will:
- Automatically install required packages (`austraits`, `remotes`, `readxl`, `tidyverse`)
- Process trait and species data
- Write `final_trait_summary.csv` to the working directory

---

## 🧪 Example Output Format

| taxon_name           | growth_form         | leaf_area | ... |
|----------------------|---------------------|-----------|-----|
| Acacia dealbata      | tree (15); shrub (5)| 10.34     | ... |
| Eucalyptus globulus  | tree (20)           | 55.12     | ... |

---

## 📦 Required Packages

These will be installed automatically by the script:

- `austraits`
- `remotes`
- `readxl`
- `tidyverse`

---

## 🙋‍♂️ Author

**Naiyun Liang**  
Bachelor of Science in IT @ UTS  
Data Analytics | Cybersecurity | R Programming

---

## 📬 Questions or Suggestions?

Feel free to open an [issue](https://github.com/Naiyun1021/austraits-script-extract-data/issues) or contact me through GitHub!
