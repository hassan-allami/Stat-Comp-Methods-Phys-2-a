%"TIME SERIES GENERATION"

%using my linear fittin model function, "image model", here I find the best
%parameter vector for all of images.
clear
%making a matrix out of all 399 best parameter vectors for each images
a=zeros(7,399);%it's an empty matrix for parameters
error_6=zeros(1,399);%it's an empty vector for error of the sixth star
for k=0:398
    if k<10%just a tricky way to load images as number arrays
        data=textread(['datafile00' int2str(k) '.txt'],'%f');
    else if k<100
            data=textread(['datafile0' int2str(k) '.txt'],'%f');
        else
            data=textread(['datafile' int2str(k) '.txt'],'%f');
        end
    end
    k
    sigma=bestsigma(data);%finding the best sigma
    [a(:,k+1) cov]=image_model(data,sigma);%finding parameter vector and error matrix
    error_6(k+1)=sqrt(cov(6,6));%assigning the corresponing element of cov matrix to error array of the sixth one
end
mean_a=sum(a(1:5,:));%taking average flux of first 5 stars
norm_flux_6=a(6,:)./mean_a;%renormalizing the flux of the sixth one
norm_error_6=error_6./(mean_a);%renormalizing its errors

%"BASIC VARIABILITY ANALYSIS"
%examining the time series I noticed that difference between the highest
%and the lowest normalized flux of target star is 0.0553
%and the maximum value of its normalized error is 0.0049;
%one order of manitude smaller
%so at the first pace I thoght that it's reasonable to say that it really
%has variable brightness
%But after checking the variance of normalized calculated brightness of all
%other stars, I noticed that all of them are in the same order. Actually,
%the variance of normalized_brightness of 5th star was even larger than the
%6th one (the target star).
%Therefore, I concluded that we CAN NOT say that the target star is
%variable.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%HERE I'M TRYING ANOTHER WAY TO CHECK VRIABILTY OF THETARGET STAR.
%THE LOGIC IS AS BELLOW:
%I cancel the common profile of flux change from all stars and then
%divide all profile diviation by the corresponding mean flux to find a
%dimensionless criteria. I consider the variance of these dimensionless
%deviation as the criteria of variability
time_mean=mean(a,2);%this each the time-average flux of stars
aa=a-time_mean*mean_a/mean(mean_a);%here I'm canceling the common profile
normalized_var=var(aa')./(mean(a').^2);%defining the variance criteria
%HERE IS WHAT I FOUND RESULT:
%normalized_var =
% 10^-3 * [0.0092    0.0134    0.0054    0.0244    0.0508    0.0586  219.6864]
% so in this way I can distinguish the target star from the four first one,
% but there is no considerable difference between the fifth one and the
% target star
% CONCLUSION: GAVE UP