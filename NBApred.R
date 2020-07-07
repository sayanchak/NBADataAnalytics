library(shiny)
library(shinythemes)
library(rsconnect)

myurl<- 'https://docs.google.com/spreadsheets/d/e/2PACX-1vS6DAKUUjjgJNmaFaXZOoE5OfWsXB_AyjToJea_64VHCW-_2ALpvmGLDZ2-NOxtR2SkLOgsijvoqruJ/pub?gid=2140190704&single=true&output=csv'
nbadata <- read.csv(url(myurl))
team_name<- c("Atlanta Hawks", "Boston Celtics", "Brooklyn Nets",
              "Charlotte Hornets", "Chicago Bulls", "Cleveland Cavaliers",
              "Dallas Mavericks", "Denver Nuggets", "Detroit Pistons",
              "Golden State Warriors", "Houston Rockets", "Indiana Pacers",
              "Los Angeles Clippers", "Los Angeles Lakers", "Memphis Grizzlies",
              "Miami Heat", "Milwaukee Bucks", "Minnesota Timberwolves",
              "New Orleans Pelicans", "New York Knicks", "Oklahoma City Thunder",
              "Orlando Magic", "Philadelphia 76ers", "Phoenix Suns",
              "Portland Trail Blazers", "Sacramento Kings", "San Antonio Spurs",
              "Toronto Raptors", "Utah Jazz", "Washington Wizards")
team_id <- c(1610612737, 1610612738, 1610612751, 1610612766, 1610612741, 
             1610612739, 1610612742, 1610612743, 1610612765, 1610612744, 
             1610612745, 1610612754,1610612746, 1610612747, 1610612763, 
             1610612748, 1610612749,1610612750, 1610612740, 1610612752, 
             1610612760, 1610612753,1610612755, 1610612756, 1610612757, 
             1610612758, 1610612759,1610612761, 1610612762, 1610612764)
choose_list<-c("Points Per Game","Field Goal Percentage","Free Throw Percentage",
               "Three Point Percentage","Assists Per Game","Rebounds Per Game")
best_player <- c("John Collins", "Enes Kanter", "DeAndre Jordan", "Cody Zeller",
                 "Wendell Carter Jr", "Andre Drummond", "Kristaps Porzingis", "Nikola Jokic",
                 "Christian Wood", "Draymond Green", "Russell Westbrook", "Domantas Sabonis",
                 "Kawhi Leonard", "Dwight Howard", "Jonas Valanciunas", "Bam Adebayo",
                 "Giannis Antetokounmpo", "Karl-Anthony Towns", "Jaxson Hayes", "Julius Randle",
                 "Steven Adams", "Nikola Vucevic", "Joel Embiid", "Deandre Ayton",
                 "Hassan Whiteside", "Richaun Holmes", "Drew Eubanks", "Serge Ibaka",
                 "Rudy Gobert", "Johnathan Williams")
img_player <- c("https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1628381.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/202683.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/201599.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/203469.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1628976.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/203083.png",
                "https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/3102531.png&w=350&h=254",
                "https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/3112335.png&w=350&h=254",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1626174.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/203110.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/201566.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1627734.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/202695.png",
                "https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/2384.png&w=350&h=254",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/202685.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1628389.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/203507.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1626157.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1629637.png",
                "https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/3064514.png&w=350&h=254",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/203500.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/202696.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/203954.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1629028.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/202355.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1626158.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1629234.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/201586.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/203497.png",
                "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1629140.png")


ui <- fluidPage(title = "NBA Data Analytics Project",
                
                theme = shinytheme("superhero"),
                tabsetPanel(              
                  tabPanel(title = "Game Stats",
                           tags$h2("NBA Data Analytics Project",  align = "center",style = "font-weight: 1000; color: #ffa500;"),
                           tags$h4("The ",tags$strong( "Game Stats", style = "color: #add8e6;"), " tab will return data on past matchups and compare game stats between two teams. The ",tags$strong("Betting Odds", style = "color: #add8e6;"), "
                                 will compare the historical betting odds between two teams. The ",tags$strong("Player Analytics", style = "color: #add8e6;")," will explain a team's strategy in detail using factor analysis and will return the team's most statistically useful player. "),
                           selectInput(inputId = "datachoosing", 
                                       label = "What game statistic do you want?", 
                                       choices = choose_list),
                           selectInput(inputId = "team1", 
                                       label = "Choose a team", 
                                       choices = team_name,
                                       selected="Dallas Mavericks"),
                           selectInput(inputId = "team2",
                                       label = "Choose another team",
                                       choices = team_name,
                                       selected="Boston Celtics"),
                           tableOutput("avg"),
                           plotOutput("histplot")
                           
                  ),
                  
                  tabPanel(title = "Betting Odds",
                           tags$h2("NBA Data Analytics Project",  align = "center", style = "font-weight: 1000; color: #ffa500;"),
                           tags$h4("The ",tags$strong( "Game Stats", style = "color: #add8e6;"), " tab will return data on past matchups and compare game stats between two teams. The ",tags$strong("Betting Odds", style = "color: #add8e6;"), "
                                 will compare the historical betting odds between two teams. The ",tags$strong("Player Analytics", style = "color: #add8e6;")," will explain a team's strategy in detail using factor analysis and will return the team's most statistically useful player. "),
                           tags$hr(),
                           tags$h4(tags$strong("Select two teams and I will return the average past historical betting odds.")),
                           selectInput(inputId = "teamchoose1", 
                                       label = "Choose a team", 
                                       choices = team_name,
                                       selected="Dallas Mavericks"),
                           selectInput(inputId = "teamchoose2",
                                       label = "Choose another team",
                                       choices = team_name,
                                       selected="Boston Celtics"),
                           tableOutput("bochart"),
                           plotOutput("piechart")
          
                           
                  ),
                  tabPanel(title = "Player Analytics",
                           tags$h2("NBA Data Analytics Project",  align = "center", style = "font-weight: 1000; color: #ffa500;"),
                           tags$h4("The ",tags$strong( "Game Stats", style = "color: #add8e6;"), " tab will return data on past matchups and compare game stats between two teams. The ",tags$strong("Betting Odds", style = "color: #add8e6;"), "
                                 will compare the historical betting odds between two teams. The ",tags$strong("Player Analytics", style = "color: #add8e6;")," will explain a team's strategy in detail using factor analysis and will return the team's most statistically useful player. "),
                           tags$hr(),
                           tags$h4(tags$strong("Select a team I will return the teams strategy and best player.")),
                           selectInput(inputId = "teamchooser1", 
                                       label = "Choose a team", 
                                       choices = team_name,
                                       selected="Boston Celtics"),
                          htmlOutput("predictortext"),
                          htmlOutput("returnbestplayer"),
                          htmlOutput("img")
                           
                  )
                  
                )
)



get_team_id <- function(name){
  index<-which(team_name %in% c(name))
  return(team_id[index])
}
teamname_finder <- function(team_num){
  ind<-which(team_id %in% c(team_num))
  team_name[ind]
}
get_best_player <- function(team_num){
  ind<-which(team_id %in% c(team_num))
  best_player[ind]
}
get_img <- function(team_num){
  ind<-which(team_id %in% c(team_num))
  img_player[ind]
}

addPTSdensity<- function(team_num1, team_num2){
  indexhome1<-which(nbadata$HOME_TEAM_ID %in% c(team_num1))
  indexaway1<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num1))
  indexhome2<-which(nbadata$HOME_TEAM_ID %in% c(team_num2))
  indexaway2<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num2))
  val_vec<-c()
  val_vec2<-c()
  for (i in 1:length(indexhome1)){
    val_vec<-c(val_vec,nbadata$PTS_home[indexhome1[i]])
  }
  for (i in 1:length(indexaway1)){
    val_vec<-c(val_vec,nbadata$PTS_away[indexaway1[i]])
  }
  for (i in 1:length(indexhome2)){
    val_vec2<-c(val_vec2,nbadata$PTS_home[indexhome2[i]])
  }
  for (i in 1:length(indexaway2)){
    val_vec2<-c(val_vec2,nbadata$PTS_away[indexaway2[i]])
  }
  par(xpd=FALSE)
  par(bg = '#d1dae0')
  titleofplot<- paste(teamname_finder(team_num1)," vs. ",teamname_finder(team_num2))
  plot(density(val_vec),main=titleofplot,col=rgb(1,0,0,0.5),xlab="Points Per Game",pch=16,lwd = 4)
  lines(density(val_vec2),col=rgb(0,0,1,0.5),pch=16,lwd = 4)
}
addFGdensity<- function(team_num1, team_num2, datatype){
  indexhome1<-which(nbadata$HOME_TEAM_ID %in% c(team_num1))
  indexaway1<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num1))
  indexhome2<-which(nbadata$HOME_TEAM_ID %in% c(team_num2))
  indexaway2<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num2))
  val_vec<-c()
  val_vec2<-c()
  for (i in 1:length(indexhome1)){
    val_vec<-c(val_vec,nbadata$FG_PCT_home[indexhome1[i]])
  }
  for (i in 1:length(indexaway1)){
    val_vec<-c(val_vec,nbadata$FG_PCT_away[indexaway1[i]])
  }
  for (i in 1:length(indexhome2)){
    val_vec2<-c(val_vec2,nbadata$FG_PCT_home[indexhome2[i]])
  }
  for (i in 1:length(indexaway2)){
    val_vec2<-c(val_vec2,nbadata$FG_PCT_away[indexaway2[i]])
  }
  par(xpd=FALSE)
  par(bg = '#d1dae0')
  titleofplot<- paste(teamname_finder(team_num1)," vs. ",teamname_finder(team_num2))
  plot(density(val_vec),main=titleofplot,col=rgb(1,0,0,0.5),xlab="Field Goal Percentage",pch=16,lwd = 4)
  lines(density(val_vec2),col=rgb(0,0,1,0.5),pch=16,lwd = 4)
}
addFTdensity<- function(team_num1, team_num2, datatype){
  indexhome1<-which(nbadata$HOME_TEAM_ID %in% c(team_num1))
  indexaway1<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num1))
  indexhome2<-which(nbadata$HOME_TEAM_ID %in% c(team_num2))
  indexaway2<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num2))
  val_vec<-c()
  val_vec2<-c()
  for (i in 1:length(indexhome1)){
    val_vec<-c(val_vec,nbadata$FT_PCT_home[indexhome1[i]])
  }
  for (i in 1:length(indexaway1)){
    val_vec<-c(val_vec,nbadata$FT_PCT_away[indexaway1[i]])
  }
  for (i in 1:length(indexhome2)){
    val_vec2<-c(val_vec2,nbadata$FT_PCT_home[indexhome2[i]])
  }
  for (i in 1:length(indexaway2)){
    val_vec2<-c(val_vec2,nbadata$FT_PCT_away[indexaway2[i]])
  }
  par(xpd=FALSE)
  par(bg = '#d1dae0')
  titleofplot<- paste(teamname_finder(team_num1)," vs. ",teamname_finder(team_num2))
  plot(density(val_vec),main=titleofplot,col=rgb(1,0,0,0.5),xlab="Free Throw Percentage",pch=16,lwd = 4)
  lines(density(val_vec2),col=rgb(0,0,1,0.5),pch=16,lwd = 4)
}
addFG3density<- function(team_num1, team_num2, datatype){
  indexhome1<-which(nbadata$HOME_TEAM_ID %in% c(team_num1))
  indexaway1<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num1))
  indexhome2<-which(nbadata$HOME_TEAM_ID %in% c(team_num2))
  indexaway2<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num2))
  val_vec<-c()
  val_vec2<-c()
  for (i in 1:length(indexhome1)){
    val_vec<-c(val_vec,nbadata$FG3_PCT_home[indexhome1[i]])
  }
  for (i in 1:length(indexaway1)){
    val_vec<-c(val_vec,nbadata$FG3_PCT_away[indexaway1[i]])
  }
  for (i in 1:length(indexhome2)){
    val_vec2<-c(val_vec2,nbadata$FG3_PCT_home[indexhome2[i]])
  }
  for (i in 1:length(indexaway2)){
    val_vec2<-c(val_vec2,nbadata$FG3_PCT_away[indexaway2[i]])
  }
  par(xpd=FALSE)
  par(bg = '#d1dae0')
  titleofplot<- paste(teamname_finder(team_num1)," vs. ",teamname_finder(team_num2))
  plot(density(val_vec),main=titleofplot,col=rgb(1,0,0,0.5),xlab="Three Point Percentage",pch=16,lwd = 4)
  lines(density(val_vec2),col=rgb(0,0,1,0.5),pch=16,lwd = 4)
}
addASTdensity<- function(team_num1, team_num2, datatype){
  indexhome1<-which(nbadata$HOME_TEAM_ID %in% c(team_num1))
  indexaway1<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num1))
  indexhome2<-which(nbadata$HOME_TEAM_ID %in% c(team_num2))
  indexaway2<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num2))
  val_vec<-c()
  val_vec2<-c()
  for (i in 1:length(indexhome1)){
    val_vec<-c(val_vec,nbadata$AST_home[indexhome1[i]])
  }
  for (i in 1:length(indexaway1)){
    val_vec<-c(val_vec,nbadata$AST_away[indexaway1[i]])
  }
  for (i in 1:length(indexhome2)){
    val_vec2<-c(val_vec2,nbadata$AST_home[indexhome2[i]])
  }
  for (i in 1:length(indexaway2)){
    val_vec2<-c(val_vec2,nbadata$AST_away[indexaway2[i]])
  }
  par(xpd=FALSE)
  par(bg = '#d1dae0')
  titleofplot<- paste(teamname_finder(team_num1)," vs. ",teamname_finder(team_num2))
  plot(density(val_vec),main=titleofplot,col=rgb(1,0,0,0.5),xlab="Assists Each Game",pch=16,lwd = 4)
  lines(density(val_vec2),col=rgb(0,0,1,0.5),pch=16,lwd = 4)
}
addREBdensity<- function(team_num1, team_num2, datatype){
  indexhome1<-which(nbadata$HOME_TEAM_ID %in% c(team_num1))
  indexaway1<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num1))
  indexhome2<-which(nbadata$HOME_TEAM_ID %in% c(team_num2))
  indexaway2<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num2))
  val_vec<-c()
  val_vec2<-c()
  for (i in 1:length(indexhome1)){
    val_vec<-c(val_vec,nbadata$REB_home[indexhome1[i]])
  }
  for (i in 1:length(indexaway1)){
    val_vec<-c(val_vec,nbadata$REB_away[indexaway1[i]])
  }
  for (i in 1:length(indexhome2)){
    val_vec2<-c(val_vec2,nbadata$REB_home[indexhome2[i]])
  }
  for (i in 1:length(indexaway2)){
    val_vec2<-c(val_vec2,nbadata$REB_away[indexaway2[i]])
  }
  par(xpd=FALSE)
  par(bg = '#d1dae0')
  titleofplot<- paste(teamname_finder(team_num1)," vs. ",teamname_finder(team_num2))
  plot(density(val_vec),main=titleofplot,col=rgb(1,0,0,0.5),xlab="Rebounds Each Game",pch=16,lwd = 4)
  lines(density(val_vec2),col=rgb(0,0,1,0.5),pch=16,lwd = 4)
}
get_avgPTS<-function(team_num1, team_num2){
  indexhome1<-which(nbadata$HOME_TEAM_ID %in% c(team_num1))
  indexaway1<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num1))
  indexhome2<-which(nbadata$HOME_TEAM_ID %in% c(team_num2))
  indexaway2<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num2))
  val_vec<-c()
  val_vec2<-c()
  for (i in 1:length(indexhome1)){
    val_vec<-c(val_vec,nbadata$PTS_home[indexhome1[i]])
  }
  for (i in 1:length(indexaway1)){
    val_vec<-c(val_vec,nbadata$PTS_away[indexaway1[i]])
  }
  for (i in 1:length(indexhome2)){
    val_vec2<-c(val_vec2,nbadata$PTS_home[indexhome2[i]])
  }
  for (i in 1:length(indexaway2)){
    val_vec2<-c(val_vec2,nbadata$PTS_away[indexaway2[i]])
  }
  out_vec<-c()
  out_vec<-c(out_vec, mean(val_vec))
  out_vec<-c(out_vec, mean(val_vec2))
  return(out_vec)
}
get_avgFG<-function(team_num1, team_num2){
  indexhome1<-which(nbadata$HOME_TEAM_ID %in% c(team_num1))
  indexaway1<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num1))
  indexhome2<-which(nbadata$HOME_TEAM_ID %in% c(team_num2))
  indexaway2<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num2))
  val_vec<-c()
  val_vec2<-c()
  for (i in 1:length(indexhome1)){
    val_vec<-c(val_vec,nbadata$FG_PCT_home[indexhome1[i]])
  }
  for (i in 1:length(indexaway1)){
    val_vec<-c(val_vec,nbadata$FG_PCT_away[indexaway1[i]])
  }
  for (i in 1:length(indexhome2)){
    val_vec2<-c(val_vec2,nbadata$FG_PCT_home[indexhome2[i]])
  }
  for (i in 1:length(indexaway2)){
    val_vec2<-c(val_vec2,nbadata$FG_PCT_away[indexaway2[i]])
  }
  out_vec<-c()
  out_vec<-c(out_vec, mean(val_vec))
  out_vec<-c(out_vec, mean(val_vec2))
  return(out_vec)
}
get_avgFT<-function(team_num1, team_num2){
  indexhome1<-which(nbadata$HOME_TEAM_ID %in% c(team_num1))
  indexaway1<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num1))
  indexhome2<-which(nbadata$HOME_TEAM_ID %in% c(team_num2))
  indexaway2<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num2))
  val_vec<-c()
  val_vec2<-c()
  for (i in 1:length(indexhome1)){
    val_vec<-c(val_vec,nbadata$FT_PCT_home[indexhome1[i]])
  }
  for (i in 1:length(indexaway1)){
    val_vec<-c(val_vec,nbadata$FT_PCT_away[indexaway1[i]])
  }
  for (i in 1:length(indexhome2)){
    val_vec2<-c(val_vec2,nbadata$FT_PCT_home[indexhome2[i]])
  }
  for (i in 1:length(indexaway2)){
    val_vec2<-c(val_vec2,nbadata$FT_PCT_away[indexaway2[i]])
  }
  out_vec<-c()
  out_vec<-c(out_vec, mean(val_vec))
  out_vec<-c(out_vec, mean(val_vec2))
  return(out_vec)
}
get_avgFG3<-function(team_num1, team_num2){
  indexhome1<-which(nbadata$HOME_TEAM_ID %in% c(team_num1))
  indexaway1<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num1))
  indexhome2<-which(nbadata$HOME_TEAM_ID %in% c(team_num2))
  indexaway2<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num2))
  val_vec<-c()
  val_vec2<-c()
  for (i in 1:length(indexhome1)){
    val_vec<-c(val_vec,nbadata$FG3_PCT_home[indexhome1[i]])
  }
  for (i in 1:length(indexaway1)){
    val_vec<-c(val_vec,nbadata$FG3_PCT_away[indexaway1[i]])
  }
  for (i in 1:length(indexhome2)){
    val_vec2<-c(val_vec2,nbadata$FG3_PCT_home[indexhome2[i]])
  }
  for (i in 1:length(indexaway2)){
    val_vec2<-c(val_vec2,nbadata$FG3_PCT_away[indexaway2[i]])
  }
  out_vec<-c()
  out_vec<-c(out_vec, mean(val_vec))
  out_vec<-c(out_vec, mean(val_vec2))
  return(out_vec)
}
get_avgAST<-function(team_num1, team_num2){
  indexhome1<-which(nbadata$HOME_TEAM_ID %in% c(team_num1))
  indexaway1<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num1))
  indexhome2<-which(nbadata$HOME_TEAM_ID %in% c(team_num2))
  indexaway2<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num2))
  val_vec<-c()
  val_vec2<-c()
  for (i in 1:length(indexhome1)){
    val_vec<-c(val_vec,nbadata$AST_home[indexhome1[i]])
  }
  for (i in 1:length(indexaway1)){
    val_vec<-c(val_vec,nbadata$AST_away[indexaway1[i]])
  }
  for (i in 1:length(indexhome2)){
    val_vec2<-c(val_vec2,nbadata$AST_home[indexhome2[i]])
  }
  for (i in 1:length(indexaway2)){
    val_vec2<-c(val_vec2,nbadata$AST_away[indexaway2[i]])
  }
  out_vec<-c()
  out_vec<-c(out_vec, mean(val_vec))
  out_vec<-c(out_vec, mean(val_vec2))
  return(out_vec)
}
get_avgREB<-function(team_num1, team_num2){
  indexhome1<-which(nbadata$HOME_TEAM_ID %in% c(team_num1))
  indexaway1<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num1))
  indexhome2<-which(nbadata$HOME_TEAM_ID %in% c(team_num2))
  indexaway2<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num2))
  val_vec<-c()
  val_vec2<-c()
  for (i in 1:length(indexhome1)){
    val_vec<-c(val_vec,nbadata$REB_home[indexhome1[i]])
  }
  for (i in 1:length(indexaway1)){
    val_vec<-c(val_vec,nbadata$REB_away[indexaway1[i]])
  }
  for (i in 1:length(indexhome2)){
    val_vec2<-c(val_vec2,nbadata$REB_home[indexhome2[i]])
  }
  for (i in 1:length(indexaway2)){
    val_vec2<-c(val_vec2,nbadata$REB_away[indexaway2[i]])
  }
  out_vec<-c()
  out_vec<-c(out_vec, mean(val_vec))
  out_vec<-c(out_vec, mean(val_vec2))
  return(out_vec)
}

vec_teamname<-function(team1,team2){
  namo_vec<-c()
  namo_vec<-c(namo_vec, teamname_finder(team1))
  namo_vec<-c(namo_vec, teamname_finder(team2))
  return(namo_vec)
}
create_df<-function(team1, team2){
  nba_stat_df<-data.frame(vec_teamname(team1, team2),
                          get_avgPTS(team1, team2),
                          get_avgFG(team1, team2),
                          get_avgFT(team1, team2),
                          get_avgFG3(team1, team2),
                          get_avgAST(team1, team2),
                          get_avgREB(team1, team2))
  colnames(nba_stat_df) <- c("Team_Name"," avg_PPG", "avg_FG_%","avg_FT_%", "avg_FG3_%", "avg_AST","avg_REB")
  return(nba_stat_df)
}
get_winpiechart<- function(team_num1, team_num2){
  indexhome1<-which(nbadata$HOME_TEAM_ID %in% c(team_num1))
  indexaway1<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num1))
  indexhome2<-which(nbadata$HOME_TEAM_ID %in% c(team_num2))
  indexaway2<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num2))
  val_vec<-c()
  val_vec2<-c()
  team1_wincount <- 0
  team2_wincount <- 0
  for (i in 1:length(indexhome1)){
    if(nbadata$HOME_TEAM_WINS[indexhome1[i]]==1){
      team1_wincount=team1_wincount+1
    }
  }
  for (i in 1:length(indexaway1)){
    if(nbadata$HOME_TEAM_WINS[indexaway1[i]]==0){
      team1_wincount=team1_wincount+1
    }
  }
  for (i in 1:length(indexhome2)){
    if(nbadata$HOME_TEAM_WINS[indexhome2[i]]==1){
      team2_wincount=team2_wincount+1
    }
  }
  for (i in 1:length(indexaway2)){
    if(nbadata$HOME_TEAM_WINS[indexaway2[i]]==0){
      team2_wincount=team2_wincount+1
    }
  }
  colors <- c("red", "blue")
  slices <- c(team1_wincount, team2_wincount)
  lbls <- c(teamname_finder(team_num1), teamname_finder(team_num2))
  pie(slices, labels = lbls, main="Past Matchup Wins", col=colors)
}
team1bo<-0
team2bo<-0
get_betodds <- function(team_num1, team_num2){
  indexhome1<-which(nbadata$HOME_TEAM_ID %in% c(team_num1))
  indexaway1<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num1))
  indexhome2<-which(nbadata$HOME_TEAM_ID %in% c(team_num2))
  indexaway2<-which(nbadata$VISITOR_TEAM_ID %in% c(team_num2))
  val_vec<-c()
  val_vec2<-c()
  team1_wincount <- 0
  team2_wincount <- 0
  for (i in 1:length(indexhome1)){
    if(nbadata$HOME_TEAM_WINS[indexhome1[i]]==1){
      team1_wincount=team1_wincount+1
    }
  }
  for (i in 1:length(indexaway1)){
    if(nbadata$HOME_TEAM_WINS[indexaway1[i]]==0){
      team1_wincount=team1_wincount+1
    }
  }
  for (i in 1:length(indexhome2)){
    if(nbadata$HOME_TEAM_WINS[indexhome2[i]]==1){
      team2_wincount=team2_wincount+1
    }
  }
  for (i in 1:length(indexaway2)){
    if(nbadata$HOME_TEAM_WINS[indexaway2[i]]==0){
      team2_wincount=team2_wincount+1
    }
  }
  team1mult <- team1_wincount/(team1_wincount+team2_wincount)
  team2mult <- team2_wincount/(team1_wincount+team2_wincount)
  if (team1mult >=.5 && team1mult<.55){
    team1bo<- sample(-100:-112, 1)
    team2bo<- sample(100:112, 1)
  }
  if (team1mult >=.55 && team1mult<.6){
    team1bo<- sample(-112:-124, 1)
    team2bo<- sample(112:124, 1)
  }
  if (team1mult >=.60 && team1mult<.65){
    team1bo<- sample(-112:-124, 1)
    team2bo<- sample(112:124, 1)
  }
  if (team1mult >=.65){
    team1bo<- sample(-124:-140, 1)
    team2bo<- sample(124:140, 1)
  }
  bo_vec<-c()
  bo_vec<-c(bo_vec, team1bo)
  bo_vec<-c(bo_vec, team2bo)
  
  nba_bo_df<-data.frame(vec_teamname(team_num1, team_num2),
                        bo_vec)
  colnames(nba_bo_df) <- c("Team_Name"," Betting_Odds")
  return(nba_bo_df)
}



server <- function(input, output) {
  output$avg <- renderTable({
    create_df(get_team_id(input$team1),get_team_id(input$team2))
  })
  output$predictortext <- renderUI({
    tags$h4("The strong statistically significant predictors for winning for this team is a high", tags$strong( "Field Goal Percentage, Free Throw Percentage, 3 Point Percentage and Rebounding Percentage.", style = " text-decoration: underline;"),
            "In fact rebounding and field goal percentage is the ", tags$strong("strongest statistical predictor", style="text-decoration: underline;"), " for winning games.
            3 Point Percentage and Free Throw Percentage are semi strong predictors. Lastly Asists and Points Per Game are weak predictors of winning.
            Centers are the most statistically important position in basketball.")
    
  })
 output$returnbestplayer <- renderUI({
   tags$h3(tags$hr(), tags$hr(), "The statistically most valuable player on the...", input$teamchooser1,"... is...", get_best_player(get_team_id(input$teamchooser1)))
 })
 output$img <- renderUI({
   tags$img(src = get_img(get_team_id(input$teamchooser1)))
 })
  
  output$piechart <- renderPlot({
    get_winpiechart(get_team_id(input$teamchoose1),get_team_id(input$teamchoose2))
  })
  
  output$bochart<- renderTable({
    get_betodds(get_team_id(input$teamchoose1),get_team_id(input$teamchoose2))
  })
  output$histplot <- renderPlot({
    if(input$datachoosing == "Points Per Game"){
      addPTSdensity(get_team_id(input$team1),get_team_id(input$team2))
    }
    if(input$datachoosing == "Field Goal Percentage"){
      addFGdensity(get_team_id(input$team1),get_team_id(input$team2))
    }
    if(input$datachoosing == "Free Throw Percentage"){
      addFTdensity(get_team_id(input$team1),get_team_id(input$team2))
    }
    if(input$datachoosing == "Three Point Percentage"){
      addFG3density(get_team_id(input$team1),get_team_id(input$team2))
    }
    if(input$datachoosing == "Assists Per Game"){
      addASTdensity(get_team_id(input$team1),get_team_id(input$team2))
    }
    if(input$datachoosing == "Rebounds Per Game"){
      addREBdensity(get_team_id(input$team1),get_team_id(input$team2))
    }
  })
 
  
}


shinyApp(server = server, ui = ui)