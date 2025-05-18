
# 📦 Step 1: Install required packages (run only once)
install.packages("devtools")
install.packages("remotes")
install.packages("readxl")
install.packages("tidyverse")

# 📥 Step 2: Install the austraits package from GitHub
remotes::install_github("traitecoevo/austraits", dependencies = TRUE, upgrade = "ask")

# 📚 Step 3: Load necessary libraries
library(devtools)
library(remotes)
library(readxl)
library(tidyverse)
library(austraits)

# 🌐 Step 4: Load the latest AusTraits dataset from Zenodo
most_recent_doi <- austraits::get_versions() %>%
  dplyr::pull("doi") %>%
  dplyr::first()

austraits <- austraits::load_austraits(doi = most_recent_doi)

# 📂 Step 5: Read input files
species_checklist <- read_csv("ALA-Plant-checklist-2025-04-21.csv")
traits_to_use <- read_excel("TraitsCombine-helen-Dorothy.xlsx") %>%
  select(trait) %>%
  distinct()

# 🔠 Step 6: Split traits into categorical and numeric
categorical_traits_vector <- traits_to_use %>%
  filter(str_detect(trait, "[:alpha:]")) %>%
  filter(!str_detect(trait, "_mean|_min|max")) %>%
  pull(trait)

numeric_traits_vector <- traits_to_use %>%
  filter(!trait %in% categorical_traits_vector) %>%
  pull(trait)

# 🌱 Step 7: Extract species vector
species_name_vector <- species_checklist$SpeciesName %>% as.vector()

# 🧩 Step 8: Define helper functions
categorical_summary <- function(austraits, trait_names) {
  austraits$traits %>%
    filter(trait_name %in% trait_names) %>%
    select(dataset_id, taxon_name, trait_name, location_id, observation_id, value) %>%
    mutate(value_tmp = stringr::str_split(value, " ")) %>%
    unnest_longer(value_tmp) %>%
    group_by(taxon_name, trait_name, value_tmp) %>%
    summarise(replicates = n(), .groups = "drop") %>%
    mutate(tmp_summary = paste0(value_tmp, " (", replicates, ")")) %>%
    group_by(taxon_name, trait_name) %>%
    summarise(value_summary = paste(tmp_summary, collapse = "; "), .groups = "drop")
}

austraits_weighted_means <- function(austraits, traits) {
  data_means <- (austraits %>% join_location_coordinates())$traits %>%
    filter(trait_name %in% traits) %>%
    filter(value_type %in% c("mean", "raw", "median")) %>%
    mutate(
      replicates = 1,
      log_value = ifelse(!is.na(value) & as.numeric(value) > 0, log10(as.numeric(value)), NA)
    ) %>%
    group_by(taxon_name, trait_name) %>%
    summarise(
      mean = mean(as.numeric(value), na.rm = TRUE),
      min = min(as.numeric(value), na.rm = TRUE),
      max = max(as.numeric(value), na.rm = TRUE),
      median = median(as.numeric(value), na.rm = TRUE),
      geom_mean = mean(log_value, na.rm = TRUE),
      all_replicates = sum(replicates), .groups = "drop"
    ) %>%
    mutate(geom_mean = 10^geom_mean)

  return(data_means)
}

# 🔍 Step 9: Extract and summarise categorical traits
subset_cat <- austraits %>%
  extract_trait(trait = categorical_traits_vector) %>%
  extract_taxa(taxon_name = species_name_vector)

categorical_summary_result <- categorical_summary(subset_cat, categorical_traits_vector)

# 🔢 Step 10: Extract and summarise numeric traits
numeric_summary_result <- tibble()  # default empty

if (length(numeric_traits_vector) > 0) {
  subset_num <- austraits %>%
    extract_trait(trait = numeric_traits_vector) %>%
    extract_taxa(taxon_name = species_name_vector)

  numeric_summary_result <- austraits_weighted_means(subset_num, numeric_traits_vector)
}

# 🧾 Step 11: Combine results
final_summary <- categorical_summary_result

if (nrow(numeric_summary_result) > 0) {
  numeric_clean <- numeric_summary_result %>%
    select(taxon_name, trait_name, value_summary = mean) %>%
    mutate(
      value_summary = round(value_summary, 2),
      value_summary = as.character(value_summary)
    )

  final_summary <- bind_rows(numeric_clean, categorical_summary_result)
}

# 🔄 Step 12: Pivot final result and export
final_summary <- final_summary %>%
  pivot_wider(names_from = trait_name, values_from = value_summary)

write_csv(final_summary, "final_trait_summary.csv", na = "")
