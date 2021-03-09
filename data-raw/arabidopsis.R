arab_md<-read.csv("Lundberg454_MetadataF.csv")
rownames(arab_md) <- arab_md$Sample
arab_md$Sample = NULL

arab_otu<-read.csv("lundfull.csv")
rownames(arab_otu)<-arab_otu$Sample  
arab_otu$Sample  = NULL

arab_tabb<-otu_table(arab_otu, taxa_are_rows = T)
arab_sample_data<-sample_data(arab_md)

arab_ps<-phyloseq(arab_tabb, arab_sample_data)
arabidopsis <- arab_ps

usethis::use_data(arabidopsis)

# subset to those samples that our core analysis was conducted with
arab_working_set<-subset_samples(physeq = arab_ps, Soil.Type=="M21" & Treatment == "R")
arab_m21_r<- prune_taxa(taxa_sums(arab_working_set) >=1, arab_working_set)