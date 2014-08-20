probs = [
		2.380, 2.786, 0.994, 2.093, 2.093, 2.380, 0.994, 2.786, 0.994, 3.074;
		2.254, 1.966, 2.254, 2.813, 2.813, 1.966, 2.254, 2.659, 1.561, 1.561;
		1.585, 0.892, 2.838, 2.278, 2.278, 2.971, 2.683, 0.892, 2.838, 0.892
]

X = [1,1,2,1,1,0,0,1,0,0]

for k=1:3;
  probs(k,:) .* X # important! probs(k,:); is you ised probs(k) you get shit
  probs_x_given_class(k) = sum(probs(k,:) .* X);
end

# this given results different from what is on the slide 31
probs_x_given_class

# this gives results as on the slide 31
probs * X'

