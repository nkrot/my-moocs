clear; close all; clc

iris = load("iris.dat");
[f,c] = hist(iris(:,1));
bar(c,f);
# frequencies (y axis)
f
# splits? (x axis)
c

