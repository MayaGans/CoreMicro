
hmbp_md<-read.csv("https://zenodo.org/record/4909346/files/v35_map_uniquebyPSN.txt?download=1", sep = "\t")
rownames(hmbp_md)<-hmbp_md$X.SampleID
hmbp_md$X.SampleID = NULL

temp <- tempfile()
download.file("https://zenodo.org/record/4909346/files/otu_table_psn_v35.txt.zip?download=1",temp)
hmbp_otu <- read.delim(unz(temp, "otu_table_psn_v35.txt"))
unlink(temp)

names(hmbp_otu) <- substr(names(hmbp_otu), start = 2, stop = 20)
rownames(hmbp_otu) <- hmbp_otu$.OTU_ID
hmbp_otu$.OTU_ID = NULL

commonalities <- intersect(names(hmbp_otu), rownames(hmbp_md))
hmbp_otu_sub <- hmbp_otu[,names(hmbp_otu) %in% commonalities]
hmbp_md_sub <- hmbp_md[rownames(hmbp_md) %in% commonalities,]

human_tabb <- phyloseq::otu_table(
  hmbp_otu_sub, 
  taxa_are_rows = T
)

human_sample_data <- phyloseq::sample_data(hmbp_md_sub)

human_ps<-phyloseq::phyloseq(human_tabb, human_sample_data)


human_ps <- phyloseq::phyloseq(human_tabb, human_sample_data)

#subset to those samples that our core analysis was conducted with
hmbp_working_set <- phyloseq::subset_samples(
  physeq = human_ps, 
  HMPbodysubsite=="Stool"
)

human_working_set<- phyloseq::prune_taxa(
  phyloseq::taxa_sums(hmbp_working_set) >=1, hmbp_working_set
)

otu_human_a<-data.frame(
  phyloseq::otu_table(human_working_set)
)

X<-as.character(rownames(otu_human_a))
otu_human_a<-cbind(X, otu_human_a)
rownames(otu_human_a)=NULL

human_stool<-otu_human_a
usethis::use_data(human_stool)
usethis::use_data(human_working_set)
