# lets create a data frame of X, bad and good and plot it
x = seq(1:12)^2
x
good =seq(from = -1,to = 10, by =1)
good
bad = seq(from = 3,to = 14, by = 1)
bad

as.data.frame(cbind(x,good,bad))
plot(x = x, y = good, col = "blue", pch = 19, xlim = c(0,160), ylim = c(0,16)) 
points(x = x, y = bad, col = "red", pch = 19)
legend("topleft",c('Good','Bad'),col=c("Blue", "Red"),pch=19,text.col=seq(2))


# now if instead of taking x, we take square root of x
x = sqrt(x)
good =seq(from = -1,to = 10, by =1)
bad = seq(from = 3,to = 14, by = 1)

# Plot it again
as.data.frame(cbind(x,good,bad))
plot(x = x, y = good, col = "blue", pch = 19, xlim = c(0,15), ylim = c(0,16)) 
points(x = x, y = bad, col = "red", pch = 19)
lines(x=x, y=bad, type="o", pch=22, col="red")
lines(x=x, y=good, type="o", pch=22, col="blue")
lines(x, col="magenta" )
segments(x0=6, y0=4, x1 = 6, y1 = 8,
         col = par("fg"), lty = par("lty"), lwd = par("lwd"))
text(x=6.8, y = 8, labels = "margin", srt= 25)
text(x=10, y = 13, labels = "support vector 1", srt= 20)
text(x=10, y = 7, labels = "support vector 2", srt= 20)
text(x=13.3, y = 13, labels = "hyperplane", srt= 20)
legend("topleft",c('Good','Bad'),col=c("Blue", "Red"),pch=19,text.col=seq(2))

# we can see that it is linearly separable now

#margin should be high when we choose a hyperplane so that we get minimum classfication errors.


# lets create a non linear function

x1 = runif(200,-10,10)
good = 2*x1 +1*(x1-2)^2 -200+ rnorm(200)

x2 = x1*2
bad =  2*x1 +1.2*(x1-1)^2 -100 + rnorm(200)
as.data.frame(cbind(x1,x2,good,bad))

plot(x = x1, y = good, col = "blue", pch = 19,xlim = c(-20,20), ylim=c(-200,50)) 
points(x = x1, y = bad, col = "red", pch = 19) 
legend("topleft",c('Good','Bad'),col=c("Blue", "Red"),pch=19,text.col=seq(2))

# so this pace is not linearly separable
# but if we transform 
z1 = x1^2 + x2^2
plot(x = z1, y = good, col = "blue", pch = 19,xlim = c(0,500), ylim = c(-200,100)) 
points(x = z1, y = bad, col = "red", pch = 19) 
legend("topleft",c('Good','Bad'),col=c("Blue", "Red"),pch=19,text.col=seq(2))


