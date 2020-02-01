library(pROC)
library(tree)
library(rpart)
library(randomForest)
library(regclass)
library(rstanarm)

myurl<- 'https://docs.google.com/spreadsheets/d/e/2PACX-1vS6DAKUUjjgJNmaFaXZOoE5OfWsXB_AyjToJea_64VHCW-_2ALpvmGLDZ2-NOxtR2SkLOgsijvoqruJ/pub?gid=2140190704&single=true&output=csv'
nbadata <- read.csv(url(myurl))
v1<-sort(sample(1000))
nba.train<-nbadata[v1,]
nba.test<-nbadata[-v1,]


nba.logit.train <- glm(nbadata$HOME_TEAM_WINS ~ nbadata$PTS_home
                 + nbadata$FG_PCT_home+nbadata$FG3_PCT_home
                 +nbadata$AST_home+nbadata$REB_home, data=nbadata)
summary(nba.logit.train)
VIF(nba.logit.train)
nba.logit.predict<-predict(nba.logit.train,nba.test)
roc(nba.test$HOME_TEAM_WINS,nba.logit.predict)
cor(nba.logit.predict,nbadata$HOME_TEAM_WINS)
roc(nbadata$HOME_TEAM_WINS,nba.logit.predict,plot=T)

nba.bayeslogit<- stan_glm(
  nbadata$HOME_TEAM_WINS ~ nbadata$PTS_home
  + nbadata$FG_PCT_home+nbadata$FG3_PCT_home
  +nbadata$AST_home+nbadata$REB_home, data=nbadata
)
summary(nba.bayes.logit)
nba.bayeslogit.predict <-predict(nba.bayeslogit,nba.test)
cor(nba.bayeslogit.predict,nbadata$HOME_TEAM_WINS)
roc(nbadata$HOME_TEAM_WINS,nba.bayeslogit.predict,plot=T)



nba.tree<- tree(nbadata$HOME_TEAM_WINS ~ nbadata$PTS_home
                + nbadata$FG_PCT_home+nbadata$FG3_PCT_home
                +nbadata$AST_home+nbadata$REB_home, data=nbadata)
nba.rpart<- rpart(nbadata$HOME_TEAM_WINS ~ nbadata$PTS_home
                  + nbadata$FG_PCT_home+nbadata$FG3_PCT_home
                  +nbadata$AST_home+nbadata$REB_home, data=nbadata)
nbadata$HOME_TEAM_WINS <- as.factor(nbadata$HOME_TEAM_WINS)
nba.forest <- randomForest(nbadata$HOME_TEAM_WINS ~ nbadata$PTS_home
                           + nbadata$FG_PCT_home+nbadata$FG3_PCT_home
                           +nbadata$AST_home+nbadata$REB_home, data=nbadata, na.action= na.omit)

nba.tree.predict<-predict(nba.tree,nbadata)
nba.rpart.predict<-predict(nba.rpart,nbadata)
nbadata$HOME_TEAM_WINS <- as.numeric(nbadata$HOME_TEAM_WINS)
cor(nba.tree.predict,nbadata$HOME_TEAM_WINS)
roc(nbadata$HOME_TEAM_WINS,nba.tree.predict,plot=T)
cor(nba.rpart.predict,nbadata$HOME_TEAM_WINS)
roc(nbadata$HOME_TEAM_WINS,nba.rpart.predict,plot=T)


nba.forest.predict<-predict(nba.forest,nbadata)
nbadata$HOME_TEAM_WINS <- as.numeric(nbadata$HOME_TEAM_WINS)
nba.forest.predict<- as.numeric(nba.forest.predict)
cor(nba.forest.predict,nbadata$HOME_TEAM_WINS)
rf.roc.pred<-roc(nbadata$HOME_TEAM_WINS,nba.forest.predict)
lines.roc(rf.roc.pred,type="lines",col=3)
roc(nbadata$HOME_TEAM_WINS,nba.tree.predict,plot=T)
plot(nba.forest.predict, nbadata$HOME_TEAM_WINS, )
plot(nba.forest)
