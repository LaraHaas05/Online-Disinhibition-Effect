# ============================================================
# 05-relationship-plots.R
# Kleine Funktionsplots für jede Beziehung aus der Relationship Table
# ============================================================

set.seed(123)

library(ggplot2)

source("simulation/01-functions.R")

# Output-Ordner
dir.create("plots", showWarnings = FALSE)

# 1) IC(AN)
grid_an <- data.frame(AN = seq(0, 1, length.out = 201))
grid_an$IC <- IC_function(grid_an$AN)

p_ic <- ggplot(grid_an, aes(x = AN, y = IC)) +
  geom_line() +
  labs(x = "AN (Anonymity)", y = "IC (Identity compartmentalization)",
       title = "IC als Funktion von AN")
ggsave("plots/rel_IC_AN.png", p_ic, width = 6, height = 4, dpi = 300)

# 2) FR(IC) bei fixem base_resp
base_resp_fix <- 0.8
grid_ic <- data.frame(IC = seq(0, 1, length.out = 201))
grid_ic$FR <- FR_function(grid_ic$IC, base_resp = base_resp_fix)

p_fr <- ggplot(grid_ic, aes(x = IC, y = FR)) +
  geom_line() +
  labs(x = "IC", y = "FR (Felt Responsibility)",
       title = paste0("FR als Funktion von IC (base_resp = ", base_resp_fix, ")"))
ggsave("plots/rel_FR_IC.png", p_fr, width = 6, height = 4, dpi = 300)

# 3) CAI(NIC)
grid_nic <- data.frame(NIC = seq(0, 1, length.out = 201))
grid_nic$CAI <- CAI_function(grid_nic$NIC)

p_cai <- ggplot(grid_nic, aes(x = NIC, y = CAI)) +
  geom_line() +
  labs(x = "NIC (Number of interpersonal cues)", y = "CAI",
       title = "CAI als Funktion von NIC")
ggsave("plots/rel_CAI_NIC.png", p_cai, width = 6, height = 4, dpi = 300)

# 4) CE(CAI)
grid_cai2 <- data.frame(CAI = seq(0, 1, length.out = 201))
grid_cai2$CE <- CE_function(grid_cai2$CAI)

p_ce <- ggplot(grid_cai2, aes(x = CAI, y = CE)) +
  geom_line() +
  labs(x = "CAI", y = "CE (Courage to express oneself)",
       title = "CE als Funktion von CAI")
ggsave("plots/rel_CE_CAI.png", p_ce, width = 6, height = 4, dpi = 300)

# 5) StateDis: Beispielplot über MOD (mit fixen FR/CE)
grid_mod <- data.frame(MOD = seq(1, 5, length.out = 201))
FR_fix <- 0.6
CE_fix <- 0.6
grid_mod$StateDis <- SD_function(feltresp = FR_fix, courage = CE_fix, MOD = grid_mod$MOD)

p_sd <- ggplot(grid_mod, aes(x = MOD, y = StateDis)) +
  geom_line() +
  labs(x = "MOD", y = "StateDis",
       title = paste0("StateDis als Funktion von MOD (FR=", FR_fix, ", CE=", CE_fix, ")"))
ggsave("plots/rel_StateDis_MOD.png", p_sd, width = 6, height = 4, dpi = 300)

# 6) Curse(StateDis) – ohne Noise (für die Funktion) + mit Noise (ein Beispiel)
grid_sd <- data.frame(StateDis = seq(-0.1, 1.2, length.out = 201))
grid_sd$Curse_det <- (grid_sd$StateDis + 0.1) / 1.3

p_curse <- ggplot(grid_sd, aes(x = StateDis, y = Curse_det)) +
  geom_line() +
  labs(x = "StateDis", y = "Curse (deterministisch)",
       title = "Deterministische Transformation von StateDis zu Curse")
ggsave("plots/rel_Curse_StateDis.png", p_curse, width = 6, height = 4, dpi = 300)

message("Fertig! Plots liegen in /plots")