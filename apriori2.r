############  connection  ######################################
library(rmongodb)
m <- mongo.create()
ns <- "database.collection"
mongo.is.connected(m)
list <- list(c("milk","butter"),
             c("pulses"),c("cookies"),c("jam","cookies"),c("bread"),c("milk","bread"),
             c("eggs","jam","bread"),
             c("bread","milk"),c("eggs","pulses"),
             c("milk","cookies"),c("bread","jam"),
             c("milk","pulses"),
             c("eggs"),c("eggs","jam","cookies"),c("bread","milk","jam"),
             c("milk","bread","butter"),c("pulses"),
             c("eggs","pulses","butter"),c("bread","jam"),c("pulses","butter"))

bson <- mongo.bson.from.list(list)
mongo.insert(m,ns,bson)
alist <- mongo.bson.to.list(bson)

####################### apriori logic   #####################################
library(arules)
names(alist) <- paste("Tr",c(1:20), sep = "")
trans <- as(alist,"transactions")
rules<-apriori(trans,parameter=list(supp=.02, conf=.7, target="rules"))
inspect(head(sort(rules,by="lift"),n=5))
