function [a,cov_a,X,model]=image_model(data,sigma)
d=data;
p0=[25.3 15.7;37.5 80.3;110.5 25.4; 73.3 110.3; 60.5 57.4; 63.5 63.5]+1;%defining positions of stars
[x,y]=meshgrid(1:128,1:128);%making grid
%making the profile matrix
P=ones(128*128,7);
for k=1:6
    A=exp(-((x-p0(k,1)).^2+(y-p0(k,2)).^2)/(2*sigma^2));
    P(:,k)=reshape(A',128*128,1);
end
N=sparse(1:128*128,1:128*128,1./d);%defining the Noise matrix
%solving for 'a' the parameter vector (M*a=A)-> a=A/M
M=P'*N*P;%defining coef matrix
A=P'*N*d;%definin inhomogenous vector
a=M\A;%parameters vector
cov_a=M^-1;%calculating covarience or error matrix of parameters
X=sum((d-P*a).^2./d)/(2^14);%evaluating reduced Chi-square
model=reshape(P*a,128,128);%it gives the matrix of modeled image