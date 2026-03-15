library(dplyr)
library(ggplot2)

# IMPORTANT: adjust if you source from manuscript/ in Quarto
# In Quarto (working dir = manuscript), you'll call: source("../simulation/07-...R")
# Here, inside the script, we assume it is called with correct working directory.
source("../simulation/01-functions.R")

# --- helpers: UTOS scenarios -------------------------------------------------

draw_MOD <- function(n, scenario = c("lowMOD", "highMOD")) {
  scenario <- match.arg(scenario)
  if (scenario == "lowMOD")  return(stats::rbeta(n, 2, 6) * 4 + 1)   # mass around 1–2
  if (scenario == "highMOD") return(stats::rbeta(n, 6, 2) * 4 + 1)   # mass around 4–5
}

draw_base_resp <- function(n, scenario = c("U_lowVar", "U_highVar")) {
  scenario <- match.arg(scenario)
  if (scenario == "U_lowVar")  return(stats::rbeta(n, 8, 3))  # narrower / less heterogeneity
  if (scenario == "U_highVar") return(stats::rbeta(n, 2, 2))  # broader / more heterogeneity
}

# Settings as cue "stability": add jitter around the treated cues values
apply_cues_setting <- function(cues_vec, scenario = c("S_stable", "S_variable")) {
  scenario <- match.arg(scenario)
  sd_jit <- if (scenario == "S_stable") 0.03 else 0.15
  cues_new <- cues_vec + stats::rnorm(length(cues_vec), mean = 0, sd = sd_jit)
  cues_new <- pmin(pmax(cues_new, 0), 1)
  return(cues_new)
}

# --- simulation: 2×2 extremes -> effect Δ = M(HH)-M(LL) ----------------------

simulate_delta <- function(n_per_cond = 800, seed = 1,
                           ce_variant = c("linear", "linear_weak", "threshold"),
                           mod_scenario = c("lowMOD", "highMOD"),
                           unit_scenario = c("U_lowVar", "U_highVar"),
                           setting_scenario = c("S_stable", "S_variable"),
                           AN_low = 0.2, AN_high = 0.8,
                           cues_lowInv = 0.8, cues_highInv = 0.2) {
  
  ce_variant <- match.arg(ce_variant)
  mod_scenario <- match.arg(mod_scenario)
  unit_scenario <- match.arg(unit_scenario)
  setting_scenario <- match.arg(setting_scenario)
  
  set.seed(seed)
  
  df <- tibble(
    cond = rep(c("LL", "HH"), each = n_per_cond),
    anonymity = rep(c(AN_low, AN_high), each = n_per_cond),
    cues_raw  = rep(c(cues_lowInv, cues_highInv), each = n_per_cond)
  )
  
  # UTOS: Units + Treatments (here: MOD scenario) + Settings (cue stability)
  df$MOD <- draw_MOD(nrow(df), scenario = mod_scenario)
  df$base_resp <- draw_base_resp(nrow(df), scenario = unit_scenario)
  df$cues <- apply_cues_setting(df$cues_raw, scenario = setting_scenario)
  
  df$bad_sentence_percentage <- curse_function(
    anonymity = df$anonymity,
    cues      = df$cues,
    MOD       = df$MOD,
    base_resp = df$base_resp,
    ce_variant = ce_variant
  )
  
  m <- df %>% group_by(cond) %>% summarise(m = mean(bad_sentence_percentage), sd = sd(bad_sentence_percentage), .groups = "drop")
  
  m_LL <- m$m[m$cond == "LL"]
  m_HH <- m$m[m$cond == "HH"]
  delta <- m_HH - m_LL
  
  # Cohen's d (pooled SD)
  sd_LL <- m$sd[m$cond == "LL"]
  sd_HH <- m$sd[m$cond == "HH"]
  sd_pooled <- sqrt((sd_LL^2 + sd_HH^2) / 2)
  d <- delta / sd_pooled
  
  tibble(delta = delta, d = d)
}

# --- run tournament × UTOS ---------------------------------------------------

run_tournament_utos <- function(n_per_cond = 800, seeds = c(1,2,3)) {
  
  grid <- expand.grid(
    ce_variant = c("linear", "linear_weak", "threshold"),
    mod_scenario = c("lowMOD", "highMOD"),
    unit_scenario = c("U_lowVar", "U_highVar"),
    setting_scenario = c("S_stable", "S_variable"),
    stringsAsFactors = FALSE
  )
  
  res <- grid %>%
    rowwise() %>%
    mutate(
      delta = mean(sapply(seeds, function(s) simulate_delta(
        n_per_cond = n_per_cond, seed = s,
        ce_variant = ce_variant,
        mod_scenario = mod_scenario,
        unit_scenario = unit_scenario,
        setting_scenario = setting_scenario
      )$delta)),
      d = mean(sapply(seeds, function(s) simulate_delta(
        n_per_cond = n_per_cond, seed = s,
        ce_variant = ce_variant,
        mod_scenario = mod_scenario,
        unit_scenario = unit_scenario,
        setting_scenario = setting_scenario
      )$d))
    ) %>%
    ungroup() %>%
    mutate(
      UTOS = paste0(unit_scenario, " × ", setting_scenario),
      ce_variant = factor(ce_variant, levels = c("linear", "linear_weak", "threshold"),
                          labels = c("CE = 1 − CAI", "CE = 1 − 0.7·CAI", "CE threshold (logistic)")),
      mod_scenario = factor(mod_scenario, levels = c("lowMOD", "highMOD"))
    )
  
  return(res)
}

res <- run_tournament_utos(n_per_cond = 800, seeds = c(1,2,3))

# Plot: Δ across UTOS scenarios, split by MOD and CE variant
p <- ggplot(res, aes(x = UTOS, y = delta, group = mod_scenario, linetype = mod_scenario, shape = mod_scenario)) +
  geom_hline(yintercept = 0, color = "black") +
  geom_line() +
  geom_point(size = 2) +
  facet_wrap(~ ce_variant, nrow = 1) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 25, hjust = 1)) +
  labs(
    x = "UTOS scenarios (Units × Settings)",
    y = expression(Delta~"="~M[HH]-M[LL]),
    linetype = "MOD scenario",
    shape = "MOD scenario",
    title = "Eigenleistung: Assumption Tournament × UTOS-in-code robustness check"
  )

# Save outputs for Quarto
ggsave("../plots/eigenleistung_tournament_utos.png", p, width = 9.2, height = 3.8, dpi = 300)
write.csv(res, "../plots/eigenleistung_tournament_utos_results.csv", row.names = FALSE)