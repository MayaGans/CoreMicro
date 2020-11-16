library(patchwork)

# Figure 2
p2.1 <- core_methods(human_stool) %>%
  core_plots(legend_title = "HMP Taxa Count") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

p2.2 <- core_methods(arabidopsis) %>%
  core_plots(high= "#1B301E", 
             low = "#E1E4E1", 
             legend_title = "Arabidopsis Taxa Count")

figure2 <- p2.1 / p2.2 + patchwork::plot_annotation(tag_levels = "A")

ggsave("inst/figures/figure2.tiff", figure2, width = 15)

# Figure 3

p3.1 <- arabidopsis %>% core_methods() %>% core_venn() + 
  ggtitle(expression(paste("Shared Core Membership of ", italic("Arabidopsis")))) +
  theme(plot.title = element_text(size = 20, hjust = 0.5)) +
  guides(fill = FALSE)

p3.2 <- human_stool %>% core_methods() %>% core_venn() + 
  ggtitle("Shared Core Membership of HMBP") +
  theme(plot.title = element_text(size = 20, hjust = 0.5))

figure3 <- p3.1 + p3.2

ggsave("inst/figures/figure3.tiff", figure3, height = 16, width = 23)


