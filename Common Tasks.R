#SUBSETTING

subset()

#By a factor:
subset(d, col.name == factor)
#E.g.:
subset(halloween.data, year == 2012)
#By a character string:
dSubset <- d[grep("string", d$column), ]
#E.g:
irisSubset <- iris[grep("osa", iris$Species), ]
#E.g:
info.msa <- raw.info[grep("C", raw.info$area_fips), ]


#MERGING

new.df <- merge(first.df, second.df, by.x="SelectedColumn", by.y = "SelectedColumn", all.x = TRUE, all.y = TRUE)
#E.g:
merged.0 <- merge(key.fips.msa.names, construction.lq, by.x = "area_fips", by.y = "area_fips", all.x = TRUE, all.y = TRUE)
#NOTE: GOOD IDEA TO ALWAYS DO all.x=TRUE and all.y=TRUE BECAUSE THAT WAY YOU CAN SEE THE DATA
#THAT DOESN'T MATCH UP, INSTEAD OF IT JUST DISAPPEARING. THIS IS IMPORTANT BECAUSE SOMETIMES
#IT MIGHT HELP YOU CATCH ANOMALIES IN DATA, E.G. LIKE ONE OBSERVATION BEING "SEATTLE, WA" AND 
#ANOTHER BEING "SEATTLE, WASHINGTON").

#REPLACING STRINGS OF TEXT IN A COLUMN:

df$column <- gsub("old.text", "new.text", df$column)
#E.g: 
home.val.msa$GEO.display.label <- gsub("Metro Area", "MSA", home.val.msa$GEO.display.label)


#REPLACING A COLUMN NAME

names(df)[names(df) == 'old.var.name'] <- 'new.var.name'
#E.g: 
names(home.val.msa)[names(home.val.msa) == "GEO.display.label"] <- "area_title"
