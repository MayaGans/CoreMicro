
library(phyloseq)
library(parallelDist)
library(vegan)
library(backbone)
library(tidyverse)
library(igraph)
library(visNetwork)

human_core_df <- core_methods(arabidopsis) %>% data.frame()
table(human_core_df$name, human_core_df$value)



# Create table all taxa that are never assigned.
wide_human<-pivot_wider(human_core_df)
#table(rowSums(wide_human[,5:8]))
wide_human$num_methods<-(rowSums(wide_human[,5:8]))
#tables number assigned by each method to add in paper. 
#table(wide_human$`Proportion of Sequence Reads`)
#table(wide_human$`Proportion of Sequence Reads and Replicates`)
#table(wide_human$`Hard Cut Off`)
#table(wide_human$`Proportion of Sequence Replicates`)
#pull out those common taxa found by all
core_4<-(wide_human[wide_human$num_methods==4,])$X
#pull out those taxa included by each method
prop_seq_reads_core<-(wide_human[wide_human$`Summation of Sequence Reads`==1,])$X
prop_seq_readsnrep_core<-(wide_human[wide_human$`Proportion of Sequence Reads and Replicates`==1,])$X
HC_core<-(wide_human[wide_human$`Hard Cut Off`==1,])$X
prop_rep_core<-(wide_human[wide_human$`Proportion of Sequence Replicates`==1,])$X

md_a<-data.frame(sample_data(arabidopsis_m21_4))
otu_a<-data.frame(otu_table(arabidopsis_m21_4))
otu_a_t<-data.frame(t(otu_a))
otu_a_t<-data.matrix(otu_a_t)
otu_human_dist<-parallelDist(otu_a_t, method = "bray")
#adonis(otu_human_dist ~ visitno + sex + RUNCENTER, data=md_a)
otu_human_dist<-parallelDist(otu_a_t, method = "binary")
#adonis(otu_human_dist ~ visitno + sex + RUNCENTER, data=md_a)


otu_a_t<-data.frame(otu_a_t)
human_core_4<- otu_a_t[,names(otu_a_t) %in% core_4]
human_core_4<-data.matrix(human_core_4)
human_core_4_dist<-parallelDist(human_core_4, method = "bray")
#adonis(human_core_4_dist ~ visitno + sex + RUNCENTER, data=md_a)
human_core_4_dist<-parallelDist(human_core_4, method = "binary")
#adonis(human_core_4_dist ~ visitno + sex + RUNCENTER, data=md_a)

otu_a_t<-data.frame(otu_a_t)
human_prop_seq_reads_core<- otu_a_t[,names(otu_a_t) %in% prop_seq_reads_core]
human_prop_seq_reads_core<-data.matrix(human_prop_seq_reads_core)
human_prop_seq_reads_core_dist<-parallelDist(human_prop_seq_reads_core, method = "bray")
#adonis(human_prop_seq_reads_core_dist ~ visitno + sex + RUNCENTER, data=md_a)
human_prop_seq_reads_core_dist<-parallelDist(human_prop_seq_reads_core, method = "binary")
#adonis(human_prop_seq_reads_core_dist ~ visitno + sex + RUNCENTER, data=md_a)

otu_a_t<-data.frame(otu_a_t)
human_prop_rnr_core<- otu_a_t[,names(otu_a_t) %in% prop_seq_readsnrep_core]
human_prop_rnr_core<-data.matrix(human_prop_rnr_core)
human_prop_rnr_core_dist<-parallelDist(human_prop_rnr_core, method = "bray")
#adonis(human_prop_rnr_core_dist ~ visitno + sex + RUNCENTER, data=md_a)
human_prop_rnr_core_dist<-parallelDist(human_prop_rnr_core, method = "binary")
#adonis(human_prop_rnr_core_dist ~ visitno + sex + RUNCENTER, data=md_a)

otu_a_t<-data.frame(otu_a_t)
human_HC_core<- otu_a_t[,names(otu_a_t) %in% HC_core]
human_HC_core<-data.matrix(human_HC_core)
human_HC_core_dist<-parallelDist(human_HC_core, method = "bray")
#adonis(human_HC_core_dist ~ visitno + sex + RUNCENTER, data=md_a)
human_HC_core_dist<-parallelDist(human_HC_core, method = "binary")
#adonis(human_HC_core_dist ~ visitno + sex + RUNCENTER, data=md_a)

otu_a_t<-data.frame(otu_a_t)
human_prop_rep_core<- otu_a_t[,names(otu_a_t) %in% prop_rep_core]
human_prop_rep_core<-data.matrix(human_prop_rep_core)
human_prop_rep_core_dist<-parallelDist(human_prop_rep_core, method = "bray")
#adonis(human_prop_rep_core_dist ~ visitno + sex + RUNCENTER, data=md_a)
human_prop_rep_core_dist<-parallelDist(human_prop_rep_core, method = "binary")
#adonis(human_prop_rep_core_dist ~ visitno + sex + RUNCENTER, data=md_a)

md_a<-data.frame(sample_data(arabidopsis_m21_4))
md_a$visitno<-as.factor(md_a$visitno)
otu_a<-data.frame(otu_table(arabidopsis_m21_4))
#Network of full dataset
#http://pablobarbera.com/big-data-upf/html/02b-networks-descriptive-analysis.html
network_test_dat<-otu_a
network_test_dat2 <- network_test_dat %>% mutate_if(is.numeric, ~1 * (. > 0))
rownames(network_test_dat2)<-rownames(network_test_dat)
network_human<-hyperg(as.matrix(network_test_dat2))
hyperg_human_network_sig <- backbone.extract(network_human, alpha = .0001, class = "igraph", fwer = "bonferroni", narrative = TRUE)
#Gives same output as below.
#sorted_degree_human_nodes<-sort(degree(hyperg_human_network_sig), decreasing = T)
node_extract_full_human<-hyperg_human_network_sig[[]]
nodes_with_sig_full_human<-node_extract_full_human[lapply(node_extract_full_human,length)>0]
full_human_node_w_num_edges<-sort(lengths(nodes_with_sig_full_human), decreasing = T) 
str(full_human_node_w_num_edges)
human_node_list<-names(full_human_node_w_num_edges)


#Core_4
core_network_non_common_core4<-full_human_node_w_num_edges[!names(full_human_node_w_num_edges) %in% intersect(core_4, human_node_list)]
core_network_commanlity_core4<-full_human_node_w_num_edges[names(full_human_node_w_num_edges) %in% intersect(core_4, human_node_list)]
#Prop_Reads
core_network_non_common_prop_reads<-full_human_node_w_num_edges[!names(full_human_node_w_num_edges) %in% intersect(prop_seq_reads_core, human_node_list)]
core_network_commanlity_prop_reads<-full_human_node_w_num_edges[names(full_human_node_w_num_edges) %in% intersect(prop_seq_reads_core, human_node_list)]
#Prop_Reps
core_network_non_common_prop_reps<-full_human_node_w_num_edges[!names(full_human_node_w_num_edges) %in% intersect(prop_rep_core, human_node_list)]
core_network_commanlity_prop_reps<-full_human_node_w_num_edges[names(full_human_node_w_num_edges) %in% intersect(prop_rep_core, human_node_list)]
#PropRnR
core_network_non_common_PropRnR<-full_human_node_w_num_edges[!names(full_human_node_w_num_edges) %in% intersect(prop_seq_readsnrep_core, human_node_list)]
core_network_commanlity_Prop_RnR<-full_human_node_w_num_edges[names(full_human_node_w_num_edges) %in% intersect(prop_seq_readsnrep_core, human_node_list)]
#HCs
core_network_non_common_HC<-full_human_node_w_num_edges[!names(full_human_node_w_num_edges) %in% intersect(HC_core, human_node_list)]
core_network_commanlity_HC<-full_human_node_w_num_edges[names(full_human_node_w_num_edges) %in% intersect(HC_core, human_node_list)]

taxa_in_core_by_any_method <- unique(c(as.character(prop_seq_reads_core), as.character(prop_rep_core), as.character(prop_seq_readsnrep_core), as.character(HC_core)))
#taxa in network with edge > 1
full_human_node_w_num_edges
#could be accomplished with just the intersect command too. Its currenlty the long way. 
Shared_core_network_taxa<-full_human_node_w_num_edges[names(full_human_node_w_num_edges) %in% intersect(taxa_in_core_by_any_method, human_node_list)]
taxa_only_in_core<-taxa_in_core_by_any_method[!taxa_in_core_by_any_method %in% names(Shared_core_network_taxa)]
taxa_only_in_network<-full_human_node_w_num_edges[!names(full_human_node_w_num_edges) %in% names(Shared_core_network_taxa)] 
#summary of degree of each node. No info is available for taxa only in the core becasue they werent included in the network. 
summary(Shared_core_network_taxa)
summary(taxa_only_in_network)
# I think this would be better as a venn diagram actaully. 
counts<-(c(length(Shared_core_network_taxa), length(taxa_only_in_core), length(taxa_only_in_network)))
barplot(counts)


circleFun <- function(center = c(0,0),diameter = 1, npoints = 100){
  r = diameter / 2
  tt <- seq(0,2*pi,length.out = npoints)
  xx <- center[1] + r * cos(tt)
  yy <- center[2] + r * sin(tt)
  return(data.frame(x = xx, y = yy))
}

circle1      <- circleFun(c(1,-1),1.7,npoints = 100)
circle2      <- circleFun(c(-1,1),1.7,npoints = 100)
circle3      <- circleFun(c(-1,-1),1.7,npoints = 100)
circle4      <- circleFun(c(1,1),1.7,npoints = 100)
middlecircle <- circleFun(c(0,0),2.5,npoints = 100)

#geom_path will do open circles, geom_polygon will do filled circles
ggplot(middlecircle,aes(x,y)) + 
  geom_path() +
  geom_path(data = circle1, aes(x, y)) +
  geom_path(data = circle2, aes(x, y)) +
  geom_path(data = circle3, aes(x, y)) +
  geom_path(data = circle4, aes(x, y)) +
  theme_void() +
  annotate("text", x = 1, y=2, label = "Summation of Reads") +
  annotate("text", x = -1.05, y=2, label = "Proportion of Reads and Replicates") +
  annotate("text", x = 1, y=-2, label = "Proportion of Replicates") +
  annotate("text", x = -1.05, y=-2, label = "Hard Cut Off") +
  annotate("text", x = 0, y=0.2, label = "Network") +
  annotate("text", x = 0, y=-0, label = length(taxa_only_in_network), size= 8) +
  annotate("text", x = 1.2, y=1.2, label = length(core_network_non_common_prop_reads), size= 8) +
  annotate("text", x = 0.5, y=0.8, label = length(core_network_commanlity_prop_reads), size= 8) +
  annotate("text", x = 1.2, y=-1.2, label = length(core_network_non_common_prop_reps), size= 8) +
  annotate("text", x = 0.5, y=-0.8, label = length(core_network_commanlity_prop_reps), size= 8) +
  annotate("text", x = -1.2, y=1.2, label = length(core_network_non_common_PropRnR), size= 8) +
  annotate("text", x = -0.5, y=0.8, label = length(core_network_commanlity_Prop_RnR), size= 8) +
  annotate("text", x = -1.2, y=-1.2, label = length(core_network_non_common_HC), size= 8) +
  annotate("text", x = -0.5, y=-0.8, label = length(core_network_commanlity_HC), size= 8) +
  ggtitle(italic('Arabidopsis') ~ "Dataset") +
  theme(plot.title = element_text(hjust = 0.5, size = 20))

