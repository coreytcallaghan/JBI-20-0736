## A script for summarizing the results of the analysis
## these results come from the 'complete_species_phylo' script
## we found a strong phylogenetic signal for urbanness for each month
## and thus will focus on running phylogenetic linear models
## for these analyses

# packages
library(dplyr)
library(ggplot2)
library(scales)
library(patchwork)
library(tidyr)
library(ggrepel)
library(wesanderson)
library(lemon)

# source functions
source("R/global_functions.R")


# read in phylogenetic modelling results
load("Results/complete_species_phylo.RData")
load("Results/complete_species_phylo_migrants_only.RData")
load("Results/complete_species_phylo_residents_only.RData")



model_averaging_results <- phylo_model_averaging_results %>%
  mutate(Species="All") %>%
  bind_rows(phylo_model_averaging_results.migrants %>% mutate(Species="Migrants")) %>%
  bind_rows(phylo_model_averaging_results.residents %>% mutate(Species="Residents"))

global_model_results <- phylo_global_model_results %>%
  mutate(Species="All") %>%
  bind_rows(phylo_global_model_results.migrants %>% mutate(Species="Migrants")) %>%
  bind_rows(phylo_global_model_results.residents %>% mutate(Species="Residents"))

# show that the model averaging and global model results show similar patterns
phylo_global_model_results %>%
  dplyr::select(term, estimate, lwr_95_confint,
                upr_95_confint, model_type, MONTH) %>%
  bind_rows(., phylo_model_averaging_results %>%
              dplyr::select(term, estimate, lwr_95_confint,
                            upr_95_confint, model_type, MONTH)) %>%
  mutate(MONTH=factor(.$MONTH, levels=c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                                        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))) %>%
  dplyr::filter(term != "(Intercept)") %>%
  pivot_wider(names_from=model_type, values_from=c(estimate, lwr_95_confint, upr_95_confint)) %>%
  ggplot(., aes(x=estimate_phylo_global_mod, y=estimate_model_averaging))+
  geom_point(color="limegreen")+
  geom_smooth(method="lm", color="orchid3")+
  facet_wrap(~MONTH, scales="free")+
  theme_classic()+
  theme(axis.text=element_text(color="black"))+
  xlab("Global model estimate")+
  ylab("Model averaing estimate")

ggsave("Figures/global_vs_model_averaging.png", width=8.5, height=7, units="in")

# will simply focus on presenting the global model results
# since we know that they correlate strongly with the model averaging results
# global model paramter estimates throughout the year
# this is one model where the migrants and residents were lumped together
# and migrants/resident status was included as a variable
phylo_global_model_results %>%
  dplyr::filter(term != "(Intercept)") %>%
  mutate(term=case_when(
    term == "rescale(log_body_size)" ~ "Body size (log)",
    term == "rescale(log_flock_size)" ~ "Mean flock size (log)",
    term == "rescale(log_range_size)" ~ "Range size (log km2)",
    term == "rescale(brain_residual)" ~ "Brain residual",
    term == "rescale(clutch_size)" ~ "Clutch size",
    term == "rescale(habitat_generalism_scaled)" ~ "Habitat generalism",
    term == "rescale(diet_breadth)" ~ "Diet breadth",
    term == "migration_statusResident" ~ "Resident")) %>%
  arrange(term, MONTH) %>%
  mutate(month_num=rep(1:12, 8)) %>%
  ggplot(., aes(x=month_num, y=estimate))+
  geom_hline(yintercept=0, linetype="dashed", color="black")+
  geom_line(color="#377EB8")+
  geom_errorbar(aes(ymin=lwr_95_confint, ymax=upr_95_confint), width=0.4)+
  geom_point(color="#E41A1C")+
  facet_wrap(~factor(term, levels=c("Clutch size", "Mean flock size (log)",
                                    "Brain residual", "Diet breadth",
                                    "Resident", "Habitat generalism",
                                    "Body size (log)", "Range size (log km2)")), scales="free", ncol=2)+
  theme_bw()+
  theme(axis.text=element_text(color="black"))+
  ylab("Parameter estimate")+
  xlab("")+
  #geom_smooth(method = "gam", formula = y ~ s(x, bs = "cs", k=11), color="orchid3")+
  scale_x_continuous(breaks=c(1:12), labels=c("Jan", "", "", "", "", "Jun", 
                                              "", "", "", "", "", "Dec"))

ggsave("Figures/all_species_global_model_results.png", width=5, height=8.5, units="in")

# plot difference between migrants and residents
migrants_vs_residents <- global_model_results %>%
  dplyr::filter(model_type=="phylo_global_mod") %>%
  dplyr::filter(Species != "All") %>%
  dplyr::filter(term != "(Intercept)") %>%
  arrange(term, MONTH) %>%
  mutate(term=case_when(
    term == "rescale(log_body_size)" ~ "Body size (log)",
    term == "rescale(log_flock_size)" ~ "Mean flock size (log)",
    term == "rescale(log_range_size)" ~ "Range size (log km2)",
    term == "rescale(brain_residual)" ~ "Brain residual",
    term == "rescale(clutch_size)" ~ "Clutch size",
    term == "rescale(habitat_generalism_scaled)" ~ "Habitat generalism",
    term == "rescale(diet_breadth)" ~ "Diet breadth")) %>%
  mutate(month_num=case_when(
    MONTH=="Jan" ~ 1,
    MONTH=="Feb" ~ 2,
    MONTH=="Mar" ~ 3,
    MONTH=="Apr" ~ 4,
    MONTH=="May" ~ 5,
    MONTH=="Jun" ~ 6,
    MONTH=="Jul" ~ 7,
    MONTH=="Aug" ~ 8,
    MONTH=="Sep" ~ 9,
    MONTH=="Oct" ~ 10,
    MONTH=="Nov" ~ 11,
    MONTH=="Dec" ~ 12)) %>%
  ggplot(., aes(x=month_num, y=estimate, color=Species))+
  #geom_errorbar(aes(ymin=lwr_95_confint, ymax=upr_95_confint), width=0.4)+
  geom_hline(yintercept=0, linetype="dashed", color="black")+
  geom_point()+
  geom_line()+
  scale_color_brewer(palette="Set1")+
  facet_wrap(~factor(term, levels=c("Clutch size", "Mean flock size (log)",
                                    "Brain residual", "Diet breadth",
                                    "Habitat generalism",
                                    "Body size (log)", "Range size (log km2)")), scales="free", ncol=2)+
  theme_bw()+
  theme(axis.text=element_text(color="black"))+
  ylab("Parameter estimate")+
  xlab("")+
  #geom_smooth(method = "gam", formula = y ~ s(x, bs = "cs", k=11), color="orchid3")+
  scale_x_continuous(breaks=c(1:12), labels=c("Jan", "", "", "", "", "Jun", 
                                              "", "", "", "", "", "Dec"))+
  theme(legend.direction='horizontal')+
  labs(color="")
  
shift_legend2(migrants_vs_residents)


png(filename="Figures/migrants_vs_residents_parameter_estimates.png",
    height=8, width=5.5, res=400, units="in")
shift_legend2(migrants_vs_residents)
dev.off()



# model averaging results
# but will focus on global model results
# and if a reviewer asks we can show the patterns are the same!
phylo_model_averaging_results %>%
  dplyr::filter(term != "(Intercept)") %>%
  mutate(term=gsub("rescale\\(", "z.", .$term)) %>%
  mutate(term=gsub("\\)", "", .$term)) %>%
  arrange(term, MONTH) %>%
  mutate(month_num=case_when(
    MONTH=="Jan" ~ 1,
    MONTH=="Feb" ~ 2,
    MONTH=="Mar" ~ 3,
    MONTH=="Apr" ~ 4,
    MONTH=="May" ~ 5,
    MONTH=="Jun" ~ 6,
    MONTH=="Jul" ~ 7,
    MONTH=="Aug" ~ 8,
    MONTH=="Sep" ~ 9,
    MONTH=="Oct" ~ 10,
    MONTH=="Nov" ~ 11,
    MONTH=="Dec" ~ 12)) %>%
  ggplot(., aes(x=month_num, y=estimate))+
  #geom_line(color="orchid3")+
  geom_errorbar(aes(ymin=lwr_95_confint, ymax=upr_95_confint), width=0.4)+
  geom_point(color="limegreen")+
  facet_wrap(~term, scales="free_y")+
  theme_classic()+
  theme(axis.text=element_text(color="black"))+
  ylab("Parameter estimate")+
  xlab("")+
  #geom_smooth(method = "gam", formula = y ~ s(x, bs = "cs", k=11), color="orchid3")+
  scale_x_continuous(breaks=c(1:12), labels=c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                                              "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))+
  ggtitle("Phylogenetic model averaging results")




# Same thing as above, but remove the categorical functional group
global_model_results %>%
  dplyr::filter(model_type=="phylo_global_mod") %>%
  dplyr::filter(Species != "All") %>%
  dplyr::filter(term != "(Intercept)") %>%
  dplyr::select(term, estimate, lwr_95_confint,
                upr_95_confint, model_type, MONTH, Species) %>%
  mutate(term=case_when(
    term == "rescale(log_body_size)" ~ "Body size (log)",
    term == "rescale(log_flock_size)" ~ "Mean flock size (log)",
    term == "rescale(log_range_size)" ~ "Range size (log km2)",
    term == "rescale(brain_residual)" ~ "Brain residual",
    term == "rescale(clutch_size)" ~ "Clutch size",
    term == "rescale(habitat_generalism_scaled)" ~ "Habitat generalism",
    term == "rescale(diet_breadth)" ~ "Diet breadth")) %>%
  mutate(MONTH=factor(.$MONTH, levels=c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                                        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))) %>%
  ggplot(., aes(x=term, y=estimate, color=Species))+
  geom_errorbar(aes(ymin=lwr_95_confint, ymax=upr_95_confint), width=0.8, position=position_dodge(width=0.6))+
  geom_point(position=position_dodge(width=0.6))+
  coord_flip()+
  facet_wrap(~MONTH)+
  theme_bw()+
  theme(axis.text=element_text(color="black"))+
  geom_hline(yintercept=0, linetype="dashed", color="black")+
  scale_color_brewer(palette="Set1")+
  xlab("")+
  ylab("Parameter estimate")+
  guides(colour = guide_legend(title="    Model"))

ggsave("Figures/monthly_parameter_estimates.png", width=9, height=8, units="in")








