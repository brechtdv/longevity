### LONGEVITY
### 25/09/2021

## required packages
library(ggplot2)

## import data

## .. oldest woman
dfw <- read.csv2("oldest-woman.csv")
dfw$DOB <- as.Date(dfw$DOB, format = "%d/%m/%Y")
dfw$DOD <- as.Date(dfw$DOD, format = "%d/%m/%Y")

## .. oldest man
dfm <- read.csv2("oldest-man.csv")
dfm$DOB <- as.Date(dfm$DOB, format = "%d/%m/%Y")
dfm$DOD <- as.Date(dfm$DOD, format = "%d/%m/%Y")

## .. merge dataset
df <-
rbind(
  data.frame(SEX = "Oldest woman",
             DATE = head(dfw$DOD, -1),
             AGE = head((dfw$DOD - dfw$DOB) / 365, -1)),
  data.frame(SEX = "Oldest woman",
             DATE = head(dfw$DOD, -1),
             AGE = (head(dfw$DOD, -1) - tail(dfw$DOB, -1)) / 365),
  data.frame(SEX = "Oldest woman",
             DATE = Sys.Date(),
             AGE =  (Sys.Date() - tail(dfw$DOB, 1)) / 365),
  data.frame(SEX = "Oldest man",
             DATE = head(dfm$DOD, -1),
             AGE = head((dfm$DOD - dfm$DOB) / 365, -1)),
  data.frame(SEX = "Oldest man",
             DATE = head(dfm$DOD, -1),
             AGE = (head(dfm$DOD, -1) - tail(dfm$DOB, -1)) / 365),
  data.frame(SEX = "Oldest man",
             DATE = Sys.Date(),
             AGE =  (Sys.Date() - tail(dfm$DOB, 1)) / 365))

## plot
tiff("oldest-belgian.tiff", 10, 6, units = "in", res = 300, compress = "lzw")
ggplot(df, aes(x = DATE, y = as.numeric(AGE), group = SEX)) +
  geom_point(aes(col = SEX)) +
  geom_line(aes(col = SEX)) +
  labs(x = NULL, y = "Age of oldest person alive", col = NULL) +
  theme_bw() +
  theme(legend.position = "top")
dev.off()
