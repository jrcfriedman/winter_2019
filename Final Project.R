# Jack Friedman 
# Final Project

rm(list=ls())

library(dplyr)

# Reading in df
vdem.full <- read.csv("~/Desktop/PSYC798W/Data/V-Dem-CY-Core-v8.csv")

# Subsetting
vdem <- subset(vdem.full, year > 1959 & year < 2000, 
               select = c(country_name, country_text_id, country_id, year, v2x_polyarchy))

# Or can read in this already subsetted csv
# vdem <- read.csv("~/Desktop/PSYC798W/Homework/vdem.csv")



#################   
#  Step 1
################# 

# Creating new column (diff) that calculates the change in v2x_polyarchy from one year to the next
vdem <- vdem %>% 
  group_by(country_id) %>%
  mutate(diff = v2x_polyarchy - lag(v2x_polyarchy))

# Creating new column coded as follows: 1 = decline greater/equal to .01, 2 = incline greater/equal to .02, 0 = all else
vdem <- vdem %>% 
  group_by(country_id) %>%
  mutate(decline = case_when(diff <= -0.01 ~ 1,
                             diff >= 0.02 ~ 2,
                             TRUE ~ 0))



#################   
#  Step 2
#################  

# Loop for creating episodes
vdem$episode <- vdem$decline
for (i in 2:nrow(vdem)) {
  next.three <- vdem$decline[i:(i + 3)]
  if (vdem$episode[i] == 0) {
    if (vdem$episode[i - 1] == 1 & any(next.three == 1)) {
      vdem$episode[i] <- 1
      if ((vdem$decline[i] == 0) & (((vdem$decline[i + 1] == 2 | vdem$decline[i + 2] == 2) & (vdem$decline[i + 1] != 1) ) ) ) {
        vdem$episode[i] <- 0
      }
    }
  }
}

# Replacing 1's with random number (99) for first year per country
# Doing this because a few countries had 1's at the start of the time span
# Using 99 instead of 0 so as not to confuse no decline with the start of country df
vdem$episode[is.na(vdem$diff)] <- 99

# Replace 2's with 0's (because 2's are no-decline observations, essentially)
vdem$episode[vdem$episode == 2] <- 0




#################   
#  Step 3
################# 

## Calculating magnitude of episode decline (difference between v2x_polyarchy at the start and end of backsliding episode)


## Episode difference lag 1
vdem$ep.diff <- 0
for (i in 2:nrow(vdem)) {
  if (vdem$episode[i] == 1 & vdem$episode[i - 1] == 0 & vdem$episode[i + 1] != 1)  {
    dd <- vdem$v2x_polyarchy[i] - vdem$v2x_polyarchy[i - 1]
    vdem$ep.diff[i] <- dd
  }
}

## Episode difference lag 2
for (i in 2:nrow(vdem)) {
  if (vdem$episode[i] == 1 & vdem$episode[i - 1] == 1 & vdem$episode[i + 1] != 1)  {
    dd <- vdem$v2x_polyarchy[i] - vdem$v2x_polyarchy[i - 2]
    vdem$ep.diff[i] <- dd
  }
}

## Episode difference lag 3
for (i in 2:nrow(vdem)) {
  if (vdem$episode[i] == 1 & vdem$episode[i - 1] == 1 && vdem$episode[i - 2] == 1 & vdem$episode[i + 1] != 1)  {
    dd <- vdem$v2x_polyarchy[i] - vdem$v2x_polyarchy[i - 3]
    vdem$ep.diff[i] <- dd
  }
}

## Episode difference lag 4
for (i in 2:nrow(vdem)) {
  if (vdem$episode[i] == 1 & vdem$episode[i - 1] == 1 && vdem$episode[i - 2] == 1 && vdem$episode[i - 3] == 1 & vdem$episode[i + 1] != 1)  {
    dd <- vdem$v2x_polyarchy[i] - vdem$v2x_polyarchy[i - 4]
    vdem$ep.diff[i] <- dd
  }
}

## Episode difference lag 5
for (i in 2:nrow(vdem)) {
  if (vdem$episode[i] == 1 & vdem$episode[i - 1] == 1 && vdem$episode[i - 2] == 1 && vdem$episode[i - 3] == 1 && vdem$episode[i - 4] == 1 & vdem$episode[i + 1] != 1)  {
    dd <- vdem$v2x_polyarchy[i] - vdem$v2x_polyarchy[i - 5]
    vdem$ep.diff[i] <- dd
  }
}

## Episode difference lag 6
for (i in 2:nrow(vdem)) {
  if (vdem$episode[i] == 1 & vdem$episode[i - 1] == 1 && vdem$episode[i - 2] == 1 && vdem$episode[i - 3] == 1 && vdem$episode[i - 4] == 1 && vdem$episode[i - 5] == 1 & vdem$episode[i + 1] != 1)  {
    dd <- vdem$v2x_polyarchy[i] - vdem$v2x_polyarchy[i - 6]
    vdem$ep.diff[i] <- dd
  }
}

## Episode difference lag 7
for (i in 2:nrow(vdem)) {
  if (vdem$episode[i] == 1 & vdem$episode[i - 1] == 1 && vdem$episode[i - 2] == 1 && vdem$episode[i - 3] == 1 && vdem$episode[i - 4] == 1 && vdem$episode[i - 5] == 1 && vdem$episode[i - 6] == 1 & vdem$episode[i + 1] != 1)  {
    dd <- vdem$v2x_polyarchy[i] - vdem$v2x_polyarchy[i - 7]
    vdem$ep.diff[i] <- dd
  }
}

## Episode difference lag 8
for (i in 2:nrow(vdem)) {
  if (vdem$episode[i] == 1 & vdem$episode[i - 1] == 1 && vdem$episode[i - 2] == 1 && vdem$episode[i - 3] == 1 && vdem$episode[i - 4] == 1 && vdem$episode[i - 5] == 1 && vdem$episode[i - 6] == 1 && vdem$episode[i - 7] == 1 & vdem$episode[i + 1] != 1)  {
    dd <- vdem$v2x_polyarchy[i] - vdem$v2x_polyarchy[i - 8]
    vdem$ep.diff[i] <- dd
  }
}

## Episode difference lag 9
for (i in 2:nrow(vdem)) {
  if (vdem$episode[i] == 1 & vdem$episode[i - 1] == 1 && vdem$episode[i - 2] == 1 && vdem$episode[i - 3] == 1 && vdem$episode[i - 4] == 1 && vdem$episode[i - 5] == 1 && vdem$episode[i - 6] == 1 && vdem$episode[i - 7] == 1 && vdem$episode[i - 8] == 1 & vdem$episode[i + 1] != 1)  {
    dd <- vdem$v2x_polyarchy[i] - vdem$v2x_polyarchy[i - 9]
    vdem$ep.diff[i] <- dd
  }
}

## Episode difference lag 10
for (i in 2:nrow(vdem)) {
  if (vdem$episode[i] == 1 & vdem$episode[i - 1] == 1 && vdem$episode[i - 2] == 1 && vdem$episode[i - 3] == 1 && vdem$episode[i - 4] == 1 && vdem$episode[i - 5] == 1 && vdem$episode[i - 6] == 1 && vdem$episode[i - 7] == 1 && vdem$episode[i - 8] == 1 && vdem$episode[i - 9] == 1 & vdem$episode[i + 1] != 1)  {
    dd <- vdem$v2x_polyarchy[i] - vdem$v2x_polyarchy[i - 10]
    vdem$ep.diff[i] <- dd
  }
}


### Alternatively...
#### these two loops do the same thing

# First loop calculates degree of backsliding for 1-year episodes
vdem$episode.size <- 0
for (i in 2:nrow(vdem)) {
  if (vdem$episode[i] == 1 & vdem$episode[i - 1] == 0 & vdem$episode[i + 1] != 1)  {
    vdem$episode.size[i] <- vdem$v2x_polyarchy[i] - vdem$v2x_polyarchy[i - 1]
  }
}

# This nested loop calculates degree backsliding for all episodes lasting more than 1 year
for (m in 1:100) {
  for (i in 2:nrow(vdem)) {
    leads <- vdem$episode[i:(i + m)]
    if (vdem$episode[i] == 1 & vdem$episode[i - 1] != 1 && all(leads == 1))  {
      dd <- vdem$v2x_polyarchy[i + m] - vdem$v2x_polyarchy[i - 1]
      vdem$episode.size[i + m] <- dd
    }
  }
}


# However, as I'll point out below, none of the code in this section (Step 3) worked in the function below





#################   
#  Step 4
################# 


###### Creating function

# Attempt 1: includes code from Steps 1-2 above; does not calculate magnitude of backsliding episodes

# df =  data frame
# x =  democracy variable
# group_var =  variable to group by when using dplyr
# neg.threshold =  size of democratic decline that starts (and continues) a backsliding episode
# pos.threshold =  size of democratic increase that stops a backsliding episode 
# stagnation =  period of years that democracy can stagnate (not decrease below neg.threshold or increase above pos.threshold) before the backsliding episode ends

backslide <- function(df, x, group_var, neg.threshold, pos.threshold, stagnation) {
  group_var <- enquo(group_var)
  print(group_var)
  
  x <- enquo(x)
  print(x)
  
  df <- df %>%
    group_by(!!group_var) %>%
    mutate(diff = !!x - lag(!!x))
  
  df <- df %>% 
    group_by(!!group_var) %>%
    mutate(decline = case_when(diff <= -neg.threshold ~ 1,
                               diff >= pos.threshold ~ 2,
                               TRUE ~ 0))
  
  df$episode <- df$decline
  for (i in 2:nrow(df)) {
    next.three <- df$decline[i:(i + stagnation)]
    if (df$episode[i] == 0) {
      if (df$episode[i - 1] == 1 & any(next.three == 1)) {
        df$episode[i] <- 1
        if ((df$decline[i] == 0) & (((df$decline[i + 1] == 2 | df$decline[i + 2] == 2) & (df$decline[i + 1] != 1) ) ) ) {
          df$episode[i] <- 0
        }
      }
    }
  }
  
  df$episode[is.na(df$diff)] <- 99
  
  df$episode[df$episode == 2] <- 0
  
  return(df)
}

new.df <- backslide(vdem, v2x_polyarchy, country_id, 0.01, 0.02, 3)



# Attempt 2: Adding calculation of episode magnitudes  
# The code for the two loops that I added generates the following error: Error in df$episodesize[j] <- dd : replacement has length zero
# Can't figure out what's going wrong...the code works above, just not when it gets put into the function

backslide <- function(df, x, group_var, neg.threshold, pos.threshold, stagnation) {
  group_var <- enquo(group_var)
  print(group_var)
  
  xx <- enquo(x)
  print(xx)
  
  df <- df %>%
    group_by(!!group_var) %>%
    mutate(diff = !!xx - lag(!!xx))
  
  df <- df %>% 
    group_by(!!group_var) %>%
    mutate(decline = case_when(diff <= -neg.threshold ~ 1,
                               diff >= pos.threshold ~ 2,
                               TRUE ~ 0))
  
  df$episode <- df$decline
  for (i in 2:nrow(df)) {
    next.three <- df$decline[i:(i + stagnation)]
    if (df$episode[i] == 0) {
      if (df$episode[i - 1] == 1 & any(next.three == 1)) {
        df$episode[i] <- 1
        if ((df$decline[i] == 0) & (((df$decline[i + 1] == 2 | df$decline[i + 2] == 2) & (df$decline[i + 1] != 1) ) ) ) {
          df$episode[i] <- 0
        }
      }
    }
  }
  
  df$episode[is.na(df$diff)] <- 99
  
  df$episode[df$episode == 2] <- 0
  
  df$episodesize <- 0 # creating new empty column
  
  # running loop for episodes lasting 1 year (not working)
  for (j in 2:nrow(df)) {
    if (df$episode[j] == 1 & df$episode[j + 1] != 1 & df$episode[j - 1] == 0) {
      dd <- df$x[j] - df$x[j-1]
      df$episodesize[j] <- dd
    }
  }
  
  # running nested loop for all other episodes (not working)
  for (m in 1:100) {
    for (i in 2:nrow(df)) {
      leads <- df$episode[i:(i + m)]
      if (df$episode[i] == 1 & df$episode[i - 1] != 1 && all(leads == 1))  {
        dd <- df$x[i + m] - df$x[i - 1]
        df$episodesize[i + m] <- dd
      }
    }
  }
  
  return(df)
}

new.df2 <- backslide(vdem2, v2x_polyarchy, country_id, 0.01, 0.02, 3)


