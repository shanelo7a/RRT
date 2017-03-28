function [x,y] = randPnt( xMin,yMin,xEnd,yEnd)

    x=round((xEnd-xMin).*rand+xMin);
    y=round((yEnd-yMin).*rand+yMin);
end



    

