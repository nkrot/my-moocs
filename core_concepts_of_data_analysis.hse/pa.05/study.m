#
# study example at slide 53
#

clear;

data = [
		41 66 90;
		57 56 60;
		61 72 79;
		69 73 72;
		63 52 88;
		62 83 80
]

# data scatter - sum of all elements squared
data_scatter = sum(sum(data .* data)) #=> 86092

[Z,Mu,C] = svd(data);

#Z
#Mu
C

Z  = Z(:,1:3)
Mu = Mu(1:3,:)

# best mu
mu1 = Mu(1,1) #=> 291.39

# mu^2/ds, often computed in percent
contribution = (100 * mu1*mu1 / data_scatter) #=> 98.626




