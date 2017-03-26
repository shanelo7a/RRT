function [vert] = randPnt( xmin,ymin,xEnd,yEnd,k,eps )

vert=cell(1,4);
for i= 1:k
    x=round(100*rand);
    y=round(100*rand);
   if euclidean(x,y,xEnd,yEnd)<= eps
    vert{1,1}(i)=x;
    vert{1,2}(i)=y;
   else
       return
   end
   
end

    

