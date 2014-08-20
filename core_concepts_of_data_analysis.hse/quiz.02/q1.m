
q1data = load("q1.dat")

x = q1data(:, 1)
y = q1data(:, 2)

printf("Correlation coefficient equals: ")
corr(x,y)

plot(x,y,'b*')
