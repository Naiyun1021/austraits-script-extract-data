# 🌱 AusTraits Summary Script

This repository contains an R script to extract and summarise trait data for Australian plant species using the [AusTraits](https://github.com/traitecoevo/austraits) dataset.

## 📌 What It Does

This script:
- Downloads the latest version of the AusTraits dataset from Zenodo
- Loads a species checklist and a list of traits
- Separates traits into **categorical** and **numeric**
- Summarises both types across your species list
- Outputs a wide-form CSV with trait values for each species

## 📁 Files

- `final_trait_summary_script.R` – The main R script to run the summary process
- `ALA-Plant-checklist-2025-04-21.csv` – Your plant species checklist (input)
- `TraitsCombine-helen-Dorothy.xlsx` – Your list of traits to extract (input)
- `final_trait_summary.csv` – The output file generated after running the script

## 🚀 How to Use

1. Clone or download this repo:
    ```bash
    git clone https://github.com/your-username/your-repo-name.git
    ```

2. Open `final_trait_summary_script.R` in RStudio

3. Make sure your working directory contains:
    - Your plant checklist CSV
    - Your Excel file of traits

4. Run the script!  
   It will install any needed packages, download the latest dataset, process your inputs, and write the summary to `final_trait_summary.csv`.

## 📦 Required R Packages

The script will install these automatically:
- `austraits`
- `remotes`
- `readxl`
- `tidyverse`

You just need R and an internet connection the first time.

## 🧪 Example Output

| taxon_name              | leaf_area       | growth_form        | ... |
|------------------------|-----------------|--------------------|-----|
| Acacia dealbata        | 12.34           | shrub (20); tree (5) | ... |
| Eucalyptus globulus    | 45.67           | tree (30)          | ... |

## 📬 Contact

For questions or suggestions, feel free to open an issue or contact [your name] at [your email].

---

