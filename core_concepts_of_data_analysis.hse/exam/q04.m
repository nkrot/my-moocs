# Of a 1000 patients of which 100 are a specific cancer sufferers a scanning device identified
# that there are 99 cancer sufferers, of which 19 have got an erroneous diagnosis.
# Can you tell the values of accuracy, precision and recall in this case?

clear;

#     | Cancer | Not-Cancer |
# Yes |  _80   |    19      | 99
#  No |  _20   |   881      |
# -------------------------------
#     |  100   |   900      | 1000

tp = 80
fp = 19
fn = 20
tn = 881

accuracy  = (tp+tn) / (tp+tn+fp+fn)
precision = tp / (tp + fp)
recall    = tp / (tp + fn)



