# Upon considering all the bigrams in the corpus of Leo Tolstoy work including letters, one found the following contingency table for bigram "snow falling";
# the first columns corresponds to bigrams in which "snow" is the first word,
# the first row corresponds to bigrams in which "falling" is the second word. 
#
#             | W1=snow     | W1≠snow  | Total-1
# W2=falling  | 12          | 987      | 999    
# W2≠falling  | 5731        | 1123634  | 1129365
# Total-2     | 5743        | 1124621  | N = 1130364
#
# Build Quetelet index table and compute chi-squared (not multiplied by N) for this table. 

clear;

data = [
		12,   987;
		5731, 1123634
]

all = sum(sum(data))

cond_probs = data ./ sum(data)

cell_probs = data ./ all
row_probs = sum(data, 2) ./ all  # total-1
col_probs = sum(data)    ./ all  # total-2

#quetelets = (cond_probs - row_probs) ./ row_probs

pn = (row_probs * col_probs)
d = cell_probs - pn;
dd = d .* d;
chi = dd ./ pn;

chi2 = sum(sum(chi)) #=> 8.4073e-06

