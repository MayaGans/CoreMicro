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
#tables number assigned by each method
#table(wide_arab$`Proportion of Sequence Reads`)
#table(wide_arab$`Proportion of Sequence Reads and Replicates`)
#table(wide_arab$`Hard Cut Off`)
#table(wide_arab$`Proportion of Sequence Replicates`)


#HMBP
#human_core<-core_methods(human_tib)
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