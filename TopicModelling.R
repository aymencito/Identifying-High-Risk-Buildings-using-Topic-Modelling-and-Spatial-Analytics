
install.packages("SnowballC")
library(SnowballC)

install.packages("tseries")
library(tseries)

install.packages("stm")
library(stm)

install.packages("reshape")
library(reshape)

install.packages("tm")
library(tm)

install.packages("qtl")
library(qtl)

install.packages("igraph")
library(igraph)

install.packages("wordcloud")
library(wordcloud)

install.packages("stringr")
library(stringr)





data <- read.csv('...UTILITY_DATA_CLEANED.csv', header=T, na.strings=c("","NA"))


names(data)
data <-  data[,c('TroubleType','Notes','Boro','Gas','Illegal') ]
data <-  data[,c('President','MonthDate','Year','Text') ]



#TOPIC MODELING ANALYSIS
data <- rename(data, c('Notes'="documents"))
data <- rename(data, c('Text'="documents"))

data <- na.omit(data)


#PREPARE DATA FOR ANALYSIS
data$documents <- str_replace_all(data$documents,"[^[:graph:]]", " ")

processed_uc <- textProcessor(data$documents, metadata=data)

out <- prepDocuments(processed_uc$documents, processed_uc$vocab, processed_uc$meta)

docs <- out$documents
vocab <- out$vocab
meta <- out$meta



#merging topics with original dataset, same order, able to be combined like that
#nrow(meta)
#names(meta)

#names(model)
#dtp <- model$theta

#meta.dtp <- cbind(dtp,meta)

#names()

#CREATE MODELS

#with covariates, the order of the covariates does not matter
#set the seed, s() is for continuous variables spline interpolation

#without covariates
#model <- stm(out$documents,out$vocab,K=5, max.em.its=1000, data=out$meta, interactions=FALSE, seed = 7483955)

#WITH COVARIATES
model <- stm(out$documents,out$vocab,K=30, prevalence =~ President + MonthDate + Year, max.em.its=1000, data=out$meta)
#using spectrual option which can use effectively without seed, init.type = "Spectral"
#model <- stm(out$documents,out$vocab,K=20, prevalence =~ TroubleType + Gas + Illegal, max.em.its=1000, data=out$meta, init.type = "Spectral")

#can  run above model without seed, and then can get seed with this command
#model$settings$seed

#Select model, selects optimum topic model
#without covariates
#modelSelect <- selectModel(out$documents,out$vocab,K=10,max.em.its=1000,data=meta,runs=20)
#plotModels(modelSelect)
#model <- modelSelect$runout[[3]]

#SELECT MODEL W/ COVARIATES
modelSelect <- selectModel(out$documents,out$vocab,K=30, prevalence =~ President + MonthDate + Year, max.em.its=1000,data=meta,runs=20)
plotModels(modelSelect)
#take a look at the plotModel and choose the model with the highest average
#exclusivity and coherence, then dump the model into object to analyze
model <- modelSelect$runout[[2]]

#get the seed to use in model wo/ covariates
model$settings$seed

#get output for each respondent
model$theta

#Choose number of topics, outputs sem coherence, exclusivity, and other measures
#storage <- searchK(out$documents, out$vocab, K = c(8), prevalence =~ married + cohort + gender + EducLevel, data = meta, seed = 6011677)

#BEGIN INTERPRETING MODEL
#plot the  topic proportions
plot.STM(model, type="summary", xlim=c(0,.4))
#lists topics, and those with highest words, plus other diagnostics 
labelTopics(model, c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30))
#this command spits out: 
#Error in t.default(logbeta) : argument is not a matrix



#word cloud
cloud(model, topic=8)
cloud(model)

#look at the documents associated with the topic
thoughts1<-findThoughts(model, texts=out$meta$documents, n=30, topics=1)$docs[[1]]
thoughts1 

thoughts2<-findThoughts(model, texts=out$meta$documents, n=20, topics=2)$docs[[1]]
thoughts2 

thoughts3<-findThoughts(model, texts=out$meta$documents, n=20, topics=3)$docs[[1]]
thoughts3 

thoughts4<-findThoughts(model, texts=out$meta$documents, n=20, topics=4)$docs[[1]]
thoughts4 

thoughts5<-findThoughts(model, texts=out$meta$documents, n=20, topics=5)$docs[[1]]
thoughts5 

thoughts6<-findThoughts(model, texts=out$meta$documents, n=20, topics=6)$docs[[1]]
thoughts6 

thoughts7<-findThoughts(model, texts=out$meta$documents, n=20, topics=7)$docs[[1]]
thoughts7 

thoughts8<-findThoughts(model, texts=out$meta$documents, n=20, topics=8)$docs[[1]]
thoughts8 

thoughts9<-findThoughts(model, texts=out$meta$documents, n=20, topics=9)$docs[[1]]
thoughts9 

thoughts10<-findThoughts(model, texts=out$meta$documents, n=20, topics=10)$docs[[1]]
thoughts10

thoughts11<-findThoughts(model, texts=out$meta$documents, n=30, topics=11)$docs[[1]]
thoughts11

thoughts12<-findThoughts(model, texts=out$meta$documents, n=20, topics=12)$docs[[1]]
thoughts12

thoughts13<-findThoughts(model, texts=out$meta$documents, n=20, topics=13)$docs[[1]]
thoughts13

thoughts14<-findThoughts(model, texts=out$meta$documents, n=20, topics=14)$docs[[1]]
thoughts14

thoughts15<-findThoughts(model, texts=out$meta$documents, n=20, topics=15)$docs[[1]]
thoughts15

thoughts16<-findThoughts(model, texts=out$meta$documents, n=20, topics=16)$docs[[1]]
thoughts16


thoughts17<-findThoughts(model, texts=out$meta$documents, n=20, topics=17)$docs[[1]]
thoughts17

thoughts18<-findThoughts(model, texts=out$meta$documents, n=20, topics=18)$docs[[1]]
thoughts18

thoughts19<-findThoughts(model, texts=out$meta$documents, n=20, topics=19)$docs[[1]]
thoughts19

thoughts20<-findThoughts(model, texts=out$meta$documents, n=20, topics=20)$docs[[1]]
thoughts20



#PLOTS USING COVARIATES
#before plotting, run estimate effect
meta$Illegal<-as.factor(meta$Illegal)

#meta$married<-as.factor(meta$married)
#meta$pet <- as.factor(meta$pet)
# 1:5 because have 5 topics
prep <- estimateEffect(1:12 ~ Illegal,model,meta=meta, uncertainty = "Global")

#plot of young vs old cohort as indepent variable
plot.estimateEffect(prep, covariate = "Illegal", topics = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12), model=model, method="difference", cov.value1="0", cov.value2="1", main = "Effect of Cohort Young vs Old", xlim = c(-0.25,0.25), xlab = "Younger .............. Older",labeltype = "custom", custom.labels = c('Church, class', 'Meetup', 'Join in w/ social group', 'daily soc inter', 'Volunteer'))

#plot of married vs never married
plot.estimateEffect(prep, covariate = "married", topics = c(4, 1, 3, 5, 2), model=model, method="difference", cov.value1="5", cov.value2="1", main = "Married vs Never Married", xlim = c(-0.20,0.20), xlab = "Married ........ Never Married",labeltype = "custom", custom.labels = c('Church, class', 'Meetup', 'Join in w/ social group', 'daily soc inter', 'Volunteer'))

#pet
plot.estimateEffect(prep, covariate = "pet", topics = c(1, 2, 3, 4, 5), model=model, method="difference", cov.value1="1", cov.value2="2", main = "Effect of Have Pet", xlim = c(-0.1,0.1), xlab = "No .............. Yes")


##see graphical of how closely related topics are to one another, 
#(i.e., how likely they are to appear in the same document) Requires 'igraph' package
mod.out.corr<-topicCorr(model)
plot.topicCorr(mod.out.corr)

##VISUALIZE DIFFERENCES BETWEEN TWO DIFFERENT TOPICS using the ,type="perspectives" option
plot.STM(model,type="perspectives", topics=c(7, 10))





