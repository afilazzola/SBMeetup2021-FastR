### Make climate data

## Specify randomness parameter
set.seed(11)

## Create fake climate variables
MAT <- c(rnorm(1000, mean = 18, sd=3),rnorm(1000, mean = 22, sd=3))
MAP <- c(rbinom(1000, size = 20, prob=0.05)*rnorm(1000,mean=5, sd=3), rbinom(1000, size = 20, prob=0.05)*rnorm(1000,mean=20, sd=4))
TMN <- c(rnorm(1000, mean = -8, sd=2),rnorm(1000, mean = -5, sd=4))
TMX <- c(rnorm(1000, mean = 38, sd=3),rnorm(1000, mean = 34, sd=2))

## create population change
pop1Rt <- c(rnorm(1000, mean=-0.2, sd=0.5),rnorm(1000, mean=0.2, sd=0.5))
pop2Rt <- c(rnorm(1000, mean=-0.4, sd=0.5),rnorm(1000, mean=0.4, sd=0.5))
pop3Rt <- c(rnorm(1000, mean=-0.2, sd=1),rnorm(1000, mean=0.2, sd=1))
pop4Rt <- c(rnorm(1000, mean=-0, sd=0.5),rnorm(1000, mean=0, sd=0.5))

## Make dataframe
climate <- data.frame(MAT, MAP, TMN, TMX)
population <- data.frame(Pop1 = pop1Rt, Pop2 = pop2Rt,Pop3 = pop3Rt,Pop4 = pop4Rt)



futureClimate <- data.frame(MAT = rnorm(10000, mean = 16, sd=3),
           MAP = rbinom(10000, size = 20, prob=0.05)*rnorm(2000,mean=12, sd=3),
           TMN = rnorm(10000, mean = -4, sd=3),
           TMX = rnorm(10000, mean = 35, sd=3))
           
           
MAP <- c(rbinom(1000, size = 20, prob=0.05)*rnorm(1000,mean=5, sd=3), rbinom(1000, size = 20, prob=0.05)*rnorm(1000,mean=20, sd=4))
TMN <- c(rnorm(1000, mean = -8, sd=2),rnorm(1000, mean = -5, sd=4))
TMX <- c(rnorm(1000, mean = 38, sd=3),rnorm(1000, mean = 34, sd=2))