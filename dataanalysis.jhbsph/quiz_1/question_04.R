# Run a command to generate 100 Cauchy random variables with default parameters and assign them to a vector cauchyValues immediately after running the command

set.seed(41)

cauchyValues = rcauchy(100)

# Then run a command to sample 10 values with replacement from cauchyValues immediately after running the command 
set.seed(415)

res = sample(cauchyValues, 10, replace=TRUE)

print(res)

