library(doParallel)
library(foreach)

## Exercise 1

guess <- c()
for(i in 1:nchar(word)){
  
  for(j in 1:52){
    if(substr(word,i,i) == c(letters,LETTERS)[j]) {
      break
    }
  }
  guess <- c(guess,c(letters,LETTERS)[j]) ## output guess letter
  guess <- paste(guess, collapse="")
}
print(paste0(guess, " Number of guesses = ", (i*52)+j))




## set up cluster
cl <- makeCluster(6, type="PSOCK")
registerDoParallel(cl)

## Solution 1
guess <- foreach(i = 1:nchar(word), .combine=paste0)  %dopar% {
  iletter <- substr(word,i,i) ## which word is being selected 
  guessletter <- grep(iletter, c(letters,LETTERS), value=T) ## select the matching letter
  guessletter ## output selected letter
  
}
print(paste0(guess," Number of guesses = ",nchar(word)))




### Exercise 2

head(climate)
head(population)

trees <- c(500,1000,1500,2000)
mtrys <- 1:ncol(climate)

outDF <- data.frame()
for(i in trees){
  for(j in mtrys){
    
    rf1 <- randomForest(Pop1 ~ MAT + MAP + TMN + TMX, importance=T, ntree=i, data=population) 
    RSQ <- rf1$rsq[length(rf1$rsq)] ## extract psuedo rsquared values
    MSE <- rf1$mse[length(rf1$mse)] ## extracted mean square errors
    tempDF <- data.frame(ntrees = i, mtry = j, rsq=RSQ, mse=MSE) ## create dataframe of parameters and outputs
    outDF <- rbind(outDF, tempDF)
  }
}
outDF




### Create cluster

cl <- makeCluster(4, type="PSOCK")
registerDoParallel(cl)

## Load different parameters
trees <- c(500,1000,1500,2000)
mtrys <- 1:ncol(climate)

##
# clusterExport(cl, c("climate", "population", "trees","mtrys")) ## NB you need to specify cluster


outDF <-foreach(i = trees, .combine=rbind, .packages=c("foreach","randomForest")) %:% 
  foreach(j = mtrys, .combine=rbind, .packages=c("randomForest")) %dopar% {
    
    rf1 <- randomForest(Pop1 ~ MAT + MAP + TMN + TMX, importance=T, ntree=i, mtrys=j, data=population) 
    RSQ <- rf1$rsq[length(rf1$rsq)] ## extract psuedo rsquared values
    MSE <- rf1$mse[length(rf1$mse)] ## extracted mean square errors
    tempDF <- data.frame(ntrees = i, mtry = j, rsq=RSQ, mse=MSE) ## create dataframe of parameters and outputs
    tempDF
  }
outDF
stopCluster(cl)
  