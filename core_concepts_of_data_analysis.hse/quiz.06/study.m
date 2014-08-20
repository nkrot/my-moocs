# week 7 slide 5
#
#

# columns: marks at subjects
#    SE, OOP, CI
# SE - software enginnering
# OOP - object oriented programming
# CI - computer intelligence
#
data = [
		41 66 90;
		57 56 60;
		61 72 79;
		69 73 72;
		63 52 88;
		62 83 80
]

[Z, Mu, C] = svd(data);

# the first column contains the best solution
z = Z(:,1) # principal component. student talent?
c = C(:,1) # loadings

mu = Mu(1,1) # maximum singular value

ds = sum(sum(data .* data)) # data scatter

z = -z
c = -c
# c:
#   0.49480
#   0.56669
#   0.65882

# experiments
# this should be close to the original <data> ???
data2 = mu * z * c';
diff = data - data2
# diff:
#  -16.88216   -0.29211   12.93040
#    7.78403   -0.36676   -5.53063
#    0.12477    2.27995   -2.05483
#    8.16765    3.32906   -8.99774
#    4.30921  -15.21823    9.85372
#   -2.53038    9.09372   -5.92164

# experiments:
# use Mu,Z,C from the 2nd column -- very large difference!!
#data - (Mu(2,2) * Z(:,2) * C(:,2)')
# and from the 3rd column
#data - (Mu(3,3) * Z(:,3) * C(:,3)')


#
# now we want to rescale <z> (that is, PCAs) to be on the same scale (0..100) as the original marks.
# We need to find a coefficient alpha such that
#  Z = (student_marks * c) * alpha
# that is:
#  Z = (0.49480*SE + 0.56669*OOP + 0.65882*CI) * alpha
# ideally, Z is expected to be 100 (the max mark a student can have). that is, solve
#  100 = (0.49480*100 + 0.56669*100 + 0.65882*100) * alpha
#
# z = X*c*alpha
#

#alpha = 100 ./ 100*(data(1,:) * c) # CRAP!
alpha = 100 / sum(c * 100) # ok. 0.58129

# what is it?
# this is what is on the slide 8
c_rescaled = c .* alpha
# c_rescaled: -- ok
#   0.28762
#   0.32941
#   0.38297

# this is the resulting PCA vector for all 6 students
pca = data * (c * alpha)
# equals to what is on the slides: -- ok
#   68.001
#   57.819
#   71.517
#   71.467
#   68.951
#   75.811

# crap
#data3 = mu * z_rescaled * c'
#diff = data - data3
