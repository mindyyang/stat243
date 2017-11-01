library(parallel)     
library(doParallel)
library(foreach)

nCores <- as.integer(Sys.getenv("SLURM_CPUS_ON_NODE"))
registerDoParallel(nCores)

nSub <- 959

result <- foreach(i = 0:nSub,
                  .packages = c("readr","dplyr", "stringr"), # libraries to load onto each worker
                  .combine = rbind, # how to combine results
                  .verbose = TRUE) %dopar% {               
                    
                    file <- paste("/global/scratch/paciorek/wikistats_full/dated_for_R/part-", str_pad(i, width=5, side="left", pad="0"), sep="")
                    data <- readr::read_delim(file, delim =" ", col_names=FALSE)
                    data <- as.data.frame(data)
                    Obamaline <- grep("Barack_Obama", data$X4, ignore.case = TRUE)
                    Obamadata <- data[Obamaline,]
                  }

dimresult <- dim(result)
headresult <- result[1:10,]

write.table(dimresult, file="/global/home/users/mengying_yang/dimresult.txt")
write.table(headresult, file="/global/home/users/mengying_yang/headresult.txt")
write.table(result, file="/global/home/users/mengying_yang/result.txt")