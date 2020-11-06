arab_md<-read.csv("/Users/gordoncuster/Desktop/Manuscript Submissions/In Review/Core_community/November2020/Data_for_additional_analyses/Lundberg454_MetadataF.csv")
rownames(arab_md) <- arab_md$Sample
arab_md$Sample = NULL

arab_otu<-read.csv("/Users/gordoncuster/Desktop/Manuscript Submissions/In Review/Core_community/November2020/Data_for_additional_analyses/lundfull.csv")
rownames(arab_otu)<-arab_otu$Sample  
arab_otu$Sample  = NULL

arab_tabb<-otu_table(arab_otu, taxa_are_rows = T)
arab_sample_data<-sample_data(arab_md)

arab_ps<-phyloseq(arab_tabb, arab_sample_data)
#subset to those samples that our core analysis was conducted with
arab_working_set<-subset_samples(physeq = arab_ps, Soil.Type=="M21" & Treatment == "R")
arab_m21_r<- prune_taxa(taxa_sums(arab_working_set) >=1, arab_working_set)