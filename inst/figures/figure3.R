library(patchwork)

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


