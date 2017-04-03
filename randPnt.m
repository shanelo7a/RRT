function [x,y] = randPnt(res,xGoal,yGoal)
rand_vals = rand(1,2);
x = round(100*rand_vals(1));
y = round(100*rand_vals(2));
% disp(['++++++++ Random Points ' num2str(x) ', ' num2str(y) ' +++++++++++']);
end
%     min = 10000;
%     x = 0;
%     y = 0;
%
%     for z = 1:res
%         rand_vals = rand(1,2);
%         x_new = round(100*rand_vals(1));
%         y_new = round(100*rand_vals(2));
%         dist = euclidean(x_new,y_new,xGoal,yGoal);
%         if dist < min
%             min = dist;
%             x = x_new;
%             y = y_new;
%         end
%     end

%     for z = 1:20
%         d(z).x=round(100*rand());
%         d(z).y=round(100*rand());
%         d(z).val = euclidean(d(z).x,d(z).y,xGoal,yGoal);
%     end
%     vals = struct2cell(d);
%     vals = cell2mat(vals);
%     vals = vals(3,1,:);
%     [~,ind] = min(vals);
%     x=d(ind).x;
%     y=d(ind).y;