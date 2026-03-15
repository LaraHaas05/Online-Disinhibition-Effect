# Formalization of a Partial Model of the Online Disinhibition Effect

This repository contains the Quarto manuscript, simulation code, figures, appendix materials, and supporting files for a final report on the formalization of a partial model of Suler’s (2004) *Online Disinhibition Effect*.

The project focuses on a theoretically central submodel of **benign online disinhibition**, with particular emphasis on **dissociative anonymity** and **invisibility** as contextual features of online communication. These are formalized via explicit variables, functional relationships, and simulation-based evaluation in R.

## Project aim

The aim of this project is to demonstrate how a verbal psychological theory can be translated into a transparent, explicit, and evaluable formal model. The workflow includes:

1. conceptual clarification of constructs and target phenomena,
2. representation of relationships in a VAST display,
3. formal specification of variables and functions,
4. implementation of the model in R,
5. evaluation with simulated data, and
6. critical reflection on the formalization process.

The report does not claim to provide a complete formalization of the full theory. Instead, it presents a focused and reproducible partial model.

## Theoretical scope

The formalization centers on two contextual features discussed by Suler:

- **Dissociative anonymity**, operationalized via **Anonymity (AN)**
- **Invisibility**, operationalized via the **number of interpersonal cues (NIC/cues)**

These inputs influence intermediate constructs such as **Identity Compartmentalization (IC)**, **Felt Responsibility (FR)**, **Concern about impression on others (CAI)**, and **Courage to express oneself (CE)**, which jointly contribute to **State Disinhibition** and the observable outcome **Curse**.

## Individual extension

In addition to the shared baseline model, this repository contains an individual robustness-oriented extension. This extension includes:

- an **assumption tournament** for the CAI → CE relation,
- **UTOS-in-code** scenario variation,
- additional **lowMOD** and **highMOD** configurations.

The purpose of this extension is to test whether the qualitative reproduction of the target phenomenon remains stable across plausible modeling assumptions.

## Repository structure

- `final_report.qmd` — main Quarto source file  
- `final_report.pdf` — rendered report  
- `simulation/` — R functions and simulation scripts  
- `plots/` — generated figures  
- `data/` — appendix tables and related input files  
- `vast/` — VAST display and conceptual materials  
- `README.md` — repository overview  
- `CITATION.cff` — citation metadata  

## Core files

The most relevant files for understanding and reproducing the project are:

- `final_report.qmd`
- `simulation/01-functions.R`
- `simulation/07-eigenleistung_tournament_utos.R`
- the generated figures in `plots/`
- the appendix input files in `data/`
- the VAST display in `vast/`

## Reproducibility

The report can be rendered from the Quarto source file, provided that the folder structure is preserved and the required software is installed.

### Requirements

- R
- Quarto
- common R packages for data wrangling, plotting, and table generation

Depending on the local setup, the following packages may be required:

- `tidyverse`
- `readr`
- `dplyr`
- `stringr`
- `ggplot2`
- `knitr`
- `kableExtra`

Additional LaTeX support may be necessary for PDF rendering.

### Render command

```bash
quarto render final_report.qmd