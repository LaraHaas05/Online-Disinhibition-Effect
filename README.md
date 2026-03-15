# Formalization of a Partial Model of the Online Disinhibition Effect

This repository contains the individual submission version of a final report on the formalization of a partial model of Suler’s (2004) *Online Disinhibition Effect*. It includes the Quarto manuscript, simulation code, figures, appendix materials, and repository metadata required to inspect and reproduce the implemented workflow.

The project focuses on a theoretically central submodel of **benign online disinhibition**, with particular emphasis on **dissociative anonymity** and **invisibility** as contextual features of online communication. These features are translated into explicit variables, functional relationships, and simulation-based evaluation in R.

## Project aim

The aim of this project is to demonstrate how a verbal psychological theory can be translated into a transparent, explicit, and evaluable formal model. The workflow includes:

1. conceptual clarification of constructs and target phenomena,
2. representation of relationships in a VAST display,
3. formal specification of variables and functions,
4. implementation of the model in R,
5. evaluation with simulated data, and
6. critical reflection on the formalization process.

The report does not attempt a complete formalization of the full theory. Instead, it presents a focused, theory-guided, and reproducible partial model.

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

## Repository provenance

This repository is an individual submission version based on a shared baseline repository developed in the seminar context. The present version contains the individually extended, independently documented, and submission-ready report.

## Repository structure

- `README.md` — repository overview
- `CITATION.cff` — citation metadata
- `CHANGELOG` — repository changelog inherited from the baseline repository
- `doc/` — additional documentation inherited from the baseline repository
- `manuscript/` — individual final report materials, including the Quarto manuscript, rendered PDF, bibliography, appendix input files, figures, and manuscript-specific simulation files
- `simulation/` — baseline repository simulation materials retained from the shared project structure

## Core files

The most relevant files for understanding and reproducing the individual submission are:

- `manuscript/final_report.qmd`
- `manuscript/final_report.pdf`
- `manuscript/references.bib`
- `manuscript/apa.csl`
- `manuscript/simulation/01-functions.R`
- `manuscript/simulation/05-relationship-plots.R`
- `manuscript/simulation/07-eigenleistung_tournament_utos.R`
- the generated figures in `manuscript/plots/`
- the appendix input tables in `manuscript/`

## Reproducibility

The individual report can be rendered from `manuscript/final_report.qmd`, provided that the repository structure is preserved and the required software is installed.

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
quarto render manuscript/final_report.qmd
```

## Note on file paths

The project uses relative paths between the main Quarto document, simulation scripts, plots, and appendix files. Reproducibility therefore depends on preserving the repository structure.

## Scope and limitations

This repository should be understood as a methodological demonstration of formalization rather than as a complete or definitive model of online behavior. Several parts of the model rely on explicit modeling assumptions where the source literature remains functionally underspecified.

### Key limitations:

- the model covers only a partial subset of the broader Online Disinhibition framework,

- some functional forms are modeling assumptions rather than direct empirical estimates,

- the outcome variable *Curse* is used as an exemplary observable indicator.

## Citation

Citation metadata for this repository are provided in `CITATION.cff`.