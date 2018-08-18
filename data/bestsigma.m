%THIS IS A FUNCTION TO FIND THE BEST SIGMA FOR ANY GIVEN IMAGE
function sigma=bestsigma(data)
function X=Chi(s)
[a,cov_a,X]=image_model(data,s);
end
sigma = fminbnd(@Chi,2,5);
end