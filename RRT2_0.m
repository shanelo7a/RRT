clear all;
close all;

x=0; y=0;                           %map origin
X=100; Y=100;                       %map max

xStart=65 ; yStart=45;               %start V
xGoal=100; yGoal=0;rGoal=10;        %goal V
EPS=20;                              %epsilon
k=100000;                           %iteration limit
currIdx=1;                          %iteration
prevIdx=1;
res=100;
biasing = 0.2;                       % goal biasing threshold
OBS = csvread('obstacles.txt');

tree.V(1).x = xStart;
tree.V(1).y = yStart;
tree.V(1).xPrev = 0;
tree.V(1).yPrev = 0;
tree.V(1).flag=1;
last_idx =  max(size(tree.V));


for i = 1:k 
    disp(['Iteration ' num2str(i)]);
    %kill when find goal 
    if euclidean(tree.V(last_idx).x,tree.V(last_idx).y,xGoal,yGoal) ~= rGoal
    [x,y]=randPnt(X-x,Y-y); %Create Random Point
    disp('Random Point generated');
    else 
      disp('Goal Found'); 
      break
    end
    % Check if point inside obstacle
    if chkIns(x,y,OBS) == true
        disp('Point Not in Obstacle');
        % Check if point satisfy epsilon condition
        if epsChk(x,y,tree.V(prevIdx).x,tree.V(prevIdx).y,EPS) == true
            disp('Point satisfies Epsilon condition');
            % add point to tree and keep flag  = 0
            tree.V(currIdx).x = x;
            tree.V(currIdx).y = y;
            tree.V(currIdx).flag = 0;
            % For new point, update the x_prev and y_prev values
            % get this value using idx from tree
            disp('Set Prev Values');
            tree.V(currIdx).xPrev = tree.V(prevIdx).x;
            tree.V(currIdx).yPrev = tree.V(prevIdx).y;
            if chkCros(tree.V(currIdx).x,tree.V(currIdx).y,tree.V(currIdx).xPrev,tree.V(currIdx).yPrev,OBS) == true
                disp('no crossing detected');
%                 insert distance to the goal chk here
                tree.V(currIdx).flag = 1;
                disp('flag set to 1**********************************')
                prevIdx = currIdx;
            else
                disp('crossing detected');
                continue;
            end
            
        else
            disp('Point did not satisfy Epsilon condition');
            continue
        end
    else
        disp('Point is inside an Obstacle');
        continue
    end
    disp('---------------------------------------');     
end
%% PLOT
pltRRT(0,0,100,100,xGoal,yGoal,rGoal,tree,OBS);