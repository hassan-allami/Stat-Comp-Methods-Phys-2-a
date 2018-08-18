%GRAPHICAL COMPARISION FOR IMAGE000

%in this code I just draw image000 and my fitting model side by side plus
%residual image of them.
%to do this I'm using my modeling finction "image_model" with sigma =
%2.5457 which is found by a quaaderatic approximation to find the minimum 
% Chi-Square as a function of sigma
sigma = 2.5457;
data=textread(['datafile000.txt'],'%f');
image=reshape(data,128,128);
[a,cov_a,X,model]=image_model(data,sigma);
%drawing side-by-side comarison
subplot(1,2,1);imagesc(model);colorbar;axis square;title('THE MODELED IMAGE')
subplot(1,2,2);imagesc(image);colorbar;axis square;title('THE ORIGINAL IMAGE000')
%drawing residual image
figure
imagesc(image-model);colorbar;axis square;title('THE RESIDUAL IMAGE')