# Simple Linear Regression & Multiple Linear Regression

## Overview
This project focuses on forecasting hockey player salaries by utilizing statistical analysis and machine learning methods. By analyzing player performance metrics, historical salary information, and other relevant factors, the project aims to deliver precise salary predictions. 
This work is part of an assignment for the AD699 Data Mining course.
## Dataset Description
| Column       | Description                                                                                                                                                                                                 |
|--------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| name         | The player’s name                                                                                                                                                                                           |
| Team         | The player’s team                                                                                                                                                                                           |
| Position     | The player’s position. The players in this dataset are either C (Center), W (Wing), or D (Defenseman)                                                                                                        |
| HANDED       | This indicates whether the player is left-handed or right-handed                                                                                                                                            |
| GP           | The number of games played by the player in the season for which the data is captured                                                                                                                       |
| G            | The number of goals scored by the player in the season for which the data is captured                                                                                                                       |
| A            | The number of assists credited to the player in the season for which the data is captured. A goal can have either 0, 1, or 2 assists. Assists are credited to the teammate(s) whose stick touched the puck prior to the stick of the person who scored the goal. |
| P            | Points. In hockey, a player is credited with one point for every goal that he scores, as well as one point for every assist that he is credited for.                                                        |
| Sh           | Total shots on goal taken by the player                                                                                                                                                                     |
| Sh_perc      | Shot percentage. Of all the shots that this player has taken, how many have gone in the net (how many were goals?)                                                                                           |
| SALARY       | Total annual salary earned by the player, in dollars                                                                                                                                                        |
| PIM          | Penalties in Minutes. More serious penalties in hockey require a player to spend more time in the “penalty box,” which gives the opposing team an advantage (since they have an extra skater)                |
| Giveaways    | Number of times that the player lost the puck to an opponent                                                                                                                                                 |
| Takeaways    | Number of times that the player took the puck away from an opponent                                                                                                                                          |
| Hits         | In hockey, a hit is defined as a body check that physically separates an opponent from the puck or significantly disrupts their play. Each number in the dataset represents a time when this player “hit” an opponent. |
| Hits.Taken   | Each number in the dataset represents a time when this player was “hit” by an opponent                                                                                                                       |
| blocked_shots| These players are not goaltenders - but they can be credited for stopping a shot with their body, stick, or skates.                                                                                          |
| PlusMinus    | A player earns a +1 when their team scores a goal while they are on the ice and a -1 when the opposing team scores.                                                                                          |

## Tools & Technologies
- R (tidyverse, dplyr, ggplot2, forecast, gplots, visualize)
- R Notebook
