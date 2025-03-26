library(tidyverse)
library(dplyr)

spotify_2023 <- read.csv('spotify-2023.csv')
View(spotify_2023)
str(spotify_2023)

spotify <- read.csv('spotify.csv')
View(spotify)

str(spotify)
str(spotify$target)

spotify$target <- factor(spotify$target)
levels(spotify$target)

spotify %>% group_by(target) %>% 
  summarise(cnt = n())

colSums(is.na(spotify))

summary(spotify_2023)


spotify_2023$danceability_. <- spotify_2023$danceability_./100
spotify_2023$energy_. <- spotify_2023$energy_./100
spotify_2023$speechiness_. <- spotify_2023$speechiness_./100
spotify_2023$valence_. <- spotify_2023$valence_./100
spotify_2023$acousticness_. <- spotify_2023$acousticness_./100
spotify_2023$liveness_. <- spotify_2023$liveness_./100

spotify_2023 <- spotify_2023 %>% rename(danceability=danceability_., energy=energy_., speechiness=speechiness_., valence=valence_., acousticness=acousticness_., liveness=liveness_., tempo=bpm)
my_song <- spotify_2023 %>% filter(track_name == 'Money Trees')



set.seed(79)
spotify.index <- sample(c(1:nrow(spotify)), nrow(spotify)*0.6)
spotify_train.df <- spotify[spotify.index, ]
spotify_valid.df <- spotify[-spotify.index, ]

liked <- spotify_train.df %>% filter(target==1)
disliked <- spotify_train.df %>% filter(target==0)

t.test(liked$danceability, disliked$danceability)
t.test(liked$tempo, disliked$tempo)
t.test(liked$energy, disliked$energy)
t.test(liked$speechiness, disliked$speechiness)
t.test(liked$valence, disliked$valence)
t.test(liked$acousticness, disliked$acousticness)
t.test(liked$liveness, disliked$liveness)

spotify_train.df <- spotify_train.df %>% select(-tempo, -energy, -liveness)



library(caret)
spotify_train_norm.df <- spotify_train.df
spotify_valid_norm.df <- spotify_valid.df
spotify_norm.df <- spotify
my_song_norm <- my_song

norm_values <- preProcess(
  spotify_train.df[, c("acousticness", "danceability", "speechiness", "valence")], 
  method = c("center", "scale"))

spotify_train_norm.df[, c("acousticness", "danceability", "speechiness", "valence")] <- 
  predict(norm_values, spotify_train.df[, c("acousticness", "danceability", "speechiness", "valence")])
View(spotify_train_norm.df)

spotify_valid_norm.df[, c("acousticness", "danceability", "speechiness", "valence")] <- 
  predict(norm_values, spotify_valid.df[, c("acousticness", "danceability", "speechiness", "valence")])
View(spotify_valid_norm.df)

spotify_norm.df[, c("acousticness", "danceability", "speechiness", "valence")] <- 
  predict(norm_values, spotify[, c("acousticness", "danceability", "speechiness", "valence")])
View(spotify_norm.df)

my_song_norm[, c("acousticness", "danceability", "speechiness", "valence")] <- 
  predict(norm_values, my_song[, c("acousticness", "danceability", "speechiness", "valence")])
View(my_song_norm)



library(FNN)
# knn is all about numeric data, classification using numeric values
nn <- knn( train = spotify_train_norm.df[, c("acousticness", "danceability", "speechiness", "valence")],
           test = my_song_norm[, c("acousticness", "danceability", "speechiness", "valence")],
           cl = spotify_train_norm.df[,c("target")],##what we are classifying: like or dislike
           k=7)
nn
nn_indexes <- row.names(spotify_train.df)[attr(nn, "nn.index")]
spotify_train.df[nn_indexes, ] %>% select(song_title, artist, target, acousticness, danceability, speechiness, valence)

accuracy.df <- data.frame(k = seq(1,14,1), accuracy = rep(0,14))
for(i in 1:14) {
  knn.pred <- knn( train = spotify_train_norm.df[, c("acousticness", "danceability", "speechiness", "valence")],
                   test = spotify_valid_norm.df[, c("acousticness", "danceability", "speechiness", "valence")],
                   cl = spotify_train_norm.df[,c("target")],
                   k=i)
  
  accuracy.df[i, 2] <- confusionMatrix(knn.pred, spotify_valid_norm.df[ ,c("target")])$overall['Accuracy']
}
accuracy.df[order(-accuracy.df$accuracy), ]


library(ggplot2)
ggplot(accuracy.df, aes(x=k, y=accuracy)) + 
  geom_point() +
  geom_line() +
  labs(title = "Scatterplot of k values vs Accuracy",
       x = "k values",
       y = "Accuracy") +
  scale_x_continuous(breaks = seq(min(accuracy.df$k), max(accuracy.df$k), by = 3))


nn_14 <- knn( train = spotify_train_norm.df[, c("acousticness", "danceability", "speechiness", "valence")],
              test = my_song_norm[, c("acousticness", "danceability", "speechiness", "valence")],
              cl = spotify_train_norm.df[,c("target")],##what we are classifying: like or dislike
              k=14)
nn_14
nn_indexes_14 <- row.names(spotify_train.df)[attr(nn_14, "nn.index")]
spotify_train.df[nn_indexes_14, ] %>% select(song_title, artist, target, acousticness, danceability, speechiness, valence)




