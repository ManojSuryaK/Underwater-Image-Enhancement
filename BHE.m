clear;
img=imread('uw1.jpeg');     %bi-histogram equalization
imshow(img);
motblurr=fspecial('motion',15,13);
blurred=imfilter(img,motblurr,'conv','circular');
imshow(blurred);
imwrite(blurred,'C:\Users\Pritesh J Shah\Downloads\dipminiproject\uw1BHE_blurred.jpeg');
img=blurred;
for i=1:3
    I=img(:,:,i); %red

    L=256;
    [m,n]=size(I);

    len=m*n;
    x=reshape(I,len,1);
    xm=round(mean(x));
    xl=x(x<=xm);
    xu=x(x>xm);

    xlpdf=hist(xl,0:xm);
    xlnpdf=xlpdf/length(xl);
    xupdf=hist(xu,xm+1:255);
    xunpdf=xupdf/length(xu);

    skl=xm*xlnpdf*triu(ones(xm+1));
    sku=(xm+1)+((L-1-(xm+1))*xunpdf*triu(ones(256-(xm+1))));
    sk=[skl,sku];

    y0=zeros(m,n);

    for k=0:L-1
            list=find(I==k);
            y0(list)=sk(k+1);
    end

    y0=uint8(y0);
    figure;
    imshow(y0);
    bhe_img(:,:,i)=y0;
end

imshow(bhe_img);
imwrite(bhe_img,'C:\Users\Pritesh J Shah\Downloads\dipminiproject\uw1BHE_final.jpeg');