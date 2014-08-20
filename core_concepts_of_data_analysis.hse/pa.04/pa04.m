# Develop a nominal feature “PWc” by categorizing Petal Width (4th column of your dataset).
# The number of categories should be four and the boundary between them, (0.5, 1.5, 2), so that the right border of the interval is included.
# Build the contingency table between the taxon feature and the PWc.
#  Rows stand for the taxon feature I.setosa, I.versicolor, I.virginica.
#  The columns stand for PWc feature, that has four possible values.
# Build contingency table.
# Find the Quetelet indexes and Pearson indexes.
#
# Output Quetelet indexes and Pearson indexes row by row, start every row from new line (i.e. put end of line symbol after every raw) a and separate the numbers in rows by spaces.
# First 12 numbers should correspond to Quetelet indexes and last 12 numbers should correspond to Pearson indexes.
# Do not separate Quetelet indexes and Pearson indexes. 

#data = load("../Iris.dat");
data = load("real.dat");

pw_data = data(:,4);
#hist(pw_data)

boundaries = [0, 0.5, 1.5, 2, 100]

for k = 1:4;
  f = find(pw_data > boundaries(k) & pw_data <= boundaries(k+1));
  pwc(f) = k;
end

pwc;

# split by taxa, there are 3 taxa (see fix_names script)
for k=1:3;
  f = find(data(:,5) == k);
  taxon(f) = k;
end;

taxon;

#plot(taxon, pwc, 'b*');

# build contingency tble
for t=1:3;   # over taxa
  for c=1:4; # over pwc categories
	taxon_pwc(t,c) = length(find(pwc==c & taxon==t));
  end;
end

taxon_pwc
#        | PW1  PW2  PW3  PW4
# -----------------------------------------
# Taxon1 | 44    1    0    0   I.setosa
# Taxon2 |  0   39    3    0   I.versicolor
# Taxon3 |  0    2   33   28   I.virginica

#
# compute quetelet indices
# (seems ok)
num_of_specimen = sum(sum(taxon_pwc)) # 150

# taxon
taxon_sums = sum(taxon_pwc, 2)
taxon_probs = taxon_sums ./ num_of_specimen

# sums in each column
pwc_sums = sum(taxon_pwc)
pwc_probs = pwc_sums ./ num_of_specimen

# p(taxon|petal width category)
taxon_conditioned_by_pw = taxon_pwc ./ pwc_sums

# CORRECT
quetelets = (taxon_conditioned_by_pw - taxon_probs) ./ taxon_probs
#   1.63158  -1.00000  -1.00000  -1.00000
#  -1.00000   2.17829  -0.55556  -1.00000
#  -1.00000  -0.85465   1.70833   2.12500


#####
# Compute Pearson indices: (observed - expected)/sqrt(expected)
observed_taxon_pwc = taxon_pwc ./ num_of_specimen
expected_taxon_pwc = taxon_probs * pwc_probs

# CORRECT!
pearson_indices = (observed_taxon_pwc - expected_taxon_pwc) ./ sqrt(expected_taxon_pwc)
#   0.62000  -0.33005  -0.27568  -0.22509
#  -0.33764   0.63880  -0.13608  -0.20000
#  -0.34871  -0.25885   0.43218   0.43894

