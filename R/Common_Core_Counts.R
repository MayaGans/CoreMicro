#This is a thought for antoher function. 
#This would table counts of each method so we have an idea of the size of inclusion by each
#It may already be included in another funciton though and could just be an intermediate output. 

#arab
#arab_core<-core_methods(arabidopsis)
#arab_core_df<- data.frame(arab_core)
#table(arab_core_df$name, arab_core_df$value)

# Create table all taxa that are never assigned.
#wide_arab<-pivot_wider(arab_core_df)
#table(rowSums(wide_arab[,5:8]))
#wide_arab$num_methods<-(rowSums(wide_arab[,5:8]))
#tables number assigned by each method
#table(wide_arab$`Proportion of Sequence Reads`)
#table(wide_arab$`Proportion of Sequence Reads and Replicates`)
#table(wide_arab$`Hard Cut Off`)
#table(wide_arab$`Proportion of Sequence Replicates`)

#pull out those common taxa found by all
#(wide_arab[wide_arab$num_methods==4,])$X
#pull out those taxa included by each method
#prop_seq_reads_core<-(wide_arab[wide_arab$`Proportion of Sequence Reads`==1,])$X

#prop_seq_readsnrep_core<-(wide_arab[wide_arab$`Proportion of Sequence Reads and Replicates`==1,])$X

#HC_core<-(wide_arab[wide_arab$`Hard Cut Off`==1,])$X

#prop_rep_core<-(wide_arab[wide_arab$`Proportion of Sequence Replicates`==1,])$X



#X<-as.character(rownames(otu_human_a))
#otu_human_a<-cbind(X, otu_human_a)
#rownames(otu_human_a)=NULL
#names(otu_human_a)
#rownames(otu_human_a)

#HMBP
#human_tib<-as_tibble(otu_human_a)
#human_core<-core_methods(otu_test, taxa_as_rows = T)

#human_core_df<- data.frame(human_core)
#table(human_core_df$name, human_core_df$value)

# Create table all taxa that are never assigned.
#wide_human<-pivot_wider(human_core_df)
#table(rowSums(wide_human[,5:8]))
#tables number assigned by each method
#table(wide_human$`Proportion of Sequence Reads`)
#table(wide_human$`Proportion of Sequence Reads and Replicates`)
#table(wide_human$`Hard Cut Off`)
#table(wide_human$`Proportion of Sequence Replicates`)