install.packages("kernlab")
library(kernlab)

# linear SVM

# Here we generate a toy dataset in 2D, and learn how to train and test a SVM

# Data generation
#First generate a set of positive and negative examples from 2 Gaussians.
n = 150 # number of data points
p = 2   # dimension

sigma = 1  # variance of the distribution
meanpos = 0 # centre of the distribution of positive examples
meanneg = 3 # centre of the distribution of negative examples
npos = round(n/2) # number of positive examples
nneg = n-npos # number of negative examples

# Generate the positive and negative examples
xpos = matrix(rnorm(npos*p,mean=meanpos,sd=sigma),npos,p)
xneg = matrix(rnorm(nneg*p,mean=meanneg,sd=sigma),npos,p)
x = rbind(xpos,xneg)

# Generate the labels
y = matrix(c(rep(1,npos),rep(-1,nneg)))

# Visualize the data
plot(x,col=ifelse(y>0,1,2))
legend("topleft",c('Positive','Negative'),col=seq(2),pch=1,text.col=seq(2))

## Prepare a training and a test set ##
ntrain = round(n*0.8) # number of training examples
tindex = sample(n,ntrain) # indices of training samples
xtrain = x[tindex,]
xtest = x[-tindex,]
ytrain = y[tindex]
ytest = y[-tindex]
istrain=rep(0,n)
istrain[tindex]=1

# Visualize
plot(x,col=ifelse(y>0,1,2),pch=ifelse(istrain==1,1,2))
legend("topleft",c('Positive Train','Positive Test','Negative Train','Negative Test'),
       col=c(1,1,2,2),pch=c(1,2,1,2),text.col=c(1,1,2,2))

# Training SVM
# load the kernlab package
library(kernlab)

# train the SVM
svp = ksvm(xtrain,ytrain,type="C-svc",kernel='vanilladot',C=100,scaled=c())
# General summary
svp
# Attributes that you can access
attributes(svp)


# For example, the support vectors
alpha(svp)
alphaindex(svp)
b(svp)

# Use the built-in function to pretty-plot the classifier
plot(svp,data=xtrain)

# Predict labels on test
ypred = predict(svp,xtest)
table(ytest,ypred)

# Compute accuracy
sum(ypred==ytest)/length(ytest)

# Compute at the prediction scores
ypredscore = predict(svp,xtest,type="decision")

# Check that the predicted labels are the signs of the scores
table(ypredscore > 0,ypred)


# Package to compute ROC curve, precision-recall etc...
library(ROCR)

pred = prediction(ypredscore,ytest)

# Plot ROC curve
perf = performance(pred, measure = "tpr", x.measure = "fpr")
plot(perf)


# Plot precision/recall curve
perf = performance(pred, measure = "prec", x.measure = "rec")
plot(perf)

# Plot accuracy as function of threshold
perf = performance(pred, measure = "acc")
plot(perf)


cv.folds = function(n,folds=3)
  ## randomly split the n samples into folds
{
  split(sample(n),rep(1:folds,length=length(y)))
}

svp = ksvm(x,y,type="C-svc",kernel='vanilladot',C=1,scaled=c(),cross=5)
print(cross(svp))


# non linear SVM


# Train a nonlinear SVM
svp = ksvm(x,y,type="C-svc",kernel='rbf',kpar=list(sigma=1),C=1)


# Visualize it
plot(svp,data=x)

# Train a nonlinear SVM with automatic selection of sigma by heuristic
svp = ksvm(x,y,type="C-svc",kernel='rbf',C=1)
# Visualize it
plot(svp,data=x)

