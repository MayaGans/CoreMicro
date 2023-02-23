arab_md<-read.csv("https://zenodo.org/record/4909346/files/Lundberg454_MetadataF.csv?download=1")
rownames(arab_md) <- arab_md$Sample
arab_md$Sample = NULL

arab_otu<-data.table::fread("https://zenodo.org/record/7544753/files/lundfull.csv?download=1")
rownames(arab_otu)<-arab_otu$Sample  
arab_otu$Sample  = NULL

arab_tabb<-phyloseq::otu_table(arab_otu, taxa_are_rows = T)
arab_sample_data<-phyloseq::sample_data(arab_md)

arab_ps<-phyloseq::phyloseq(arab_tabb, arab_sample_data)
arabidopsis <- arab_ps

# subset to those samples that our core analysis was conducted with
arab_working_set <- phyloseq::subset_samples(
  physeq = arab_ps, 
  Soil.Type=="M21" & Treatment == "R"
)

arab_working_set <- phyloseq::prune_taxa(
  phyloseq::taxa_sums(arab_working_set) >=1, 
  arab_working_set
)

otu_arab_a<-data.frame(
  phyloseq::otu_table(arab_working_set)
)

X<-as.character(rownames(otu_arab_a))
otu_arab_a<-cbind(X, otu_arab_a)
rownames(otu_arab_a)=NULL
arabidopsis_rhizo<-otu_arab_a

usethis::use_data(arab_working_set)
usethis::use_data(arabidopsis_rhizo)

