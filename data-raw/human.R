
hmbp_md<-read.csv("/Users/gordoncuster/Desktop/Manuscript Submissions/Core_community/November2020/Data_for_additional_analyses/old/v35_map_uniquebyPSN.csv")
rownames(hmbp_md)<-hmbp_md$X.SampleID
hmbp_md$X.SampleID = NULL

hmbp_otu<-read.csv("/Users/gordoncuster/Desktop/Manuscript Submissions/Core_community/November2020/Data_for_additional_analyses/old/otu_table_psn_v35_2.csv", sep = "\t")
#end long so it grabs everything
names(hmbp_otu)<-substr(names(hmbp_otu), start = 2, stop = 20)
rownames(hmbp_otu)<-hmbp_otu$.OTU_ID
hmbp_otu$.OTU_ID = NULL

commonalities<-intersect(names(hmbp_otu), rownames(hmbp_md))
hmbp_otu_sub<-hmbp_otu[,names(hmbp_otu) %in% commonalities]
hmbp_md_sub<-hmbp_md[rownames(hmbp_md) %in% commonalities,]

human_tabb<-otu_table(hmbp_otu_sub, taxa_are_rows = T)
human_sample_data<-sample_data(hmbp_md_sub)

human_ps<-phyloseq(human_tabb, human_sample_data)


human_ps<-phyloseq(human_tabb, human_sample_data)
#subset to those samples that our core analysis was conducted with
hmbp_working_set<-subset_samples(physeq = human_ps, HMPbodysubsite=="Stool")

human_working_set<- prune_taxa(taxa_sums(hmbp_working_set) >=1, hmbp_working_set)

otu_human_a<-data.frame(otu_table(human_working_set))

X<-as.character(rownames(otu_human_a))
otu_human_a<-cbind(X, otu_human_a)
rownames(otu_human_a)=NULL

human_stool<-otu_human_a

usethis::use_data(human_stool)


saveRDS(human_working_set, "./data/human_working_set.rda")
