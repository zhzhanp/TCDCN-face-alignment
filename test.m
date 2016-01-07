
clear all;
fid = fopen('yang_output.txt','rt');
IMDIR = '';
dis = zeros(5,68);
lefteyePt = [37:42];
righteyePt = [43:48];

ptsAllgt = load('G:\big\pre2\300wtestingPts.mat','ptsAll');
ptsAllgt = ptsAllgt.ptsAll;
ptsAllgt2 = ptsAllgt(:,:,[1:330,466:689,331:465]);
ptsAllgt = ptsAllgt2;
ptsAllgt(:,:,649) = ptsAllgt2(:,:,650);
ptsAllgt(:,:,650) = ptsAllgt2(:,:,649);

for i = 1:689
    filename = fgetl(fid);
    fpts = fscanf(fid,'%f',136);
    fgetl(fid);
    fpts = reshape(fpts,[2 68]);
    fpts = fpts';
    
    gtptx = ptsAllgt(:,1,i)';
    gtpty = ptsAllgt(:,2,i)';  
    gtpts = (([gtpty,gtptx]));
    gtpts = reshape(gtpts,[2 68]);
    gtpts = gtpts';
    
%     img = imread([IMDIR filename]);
%     imshow(img);
%     hold on;
%     plot(fpts(:,1),fpts(:,2),'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','green');
%     plot(gtptx,gtpty,'o','MarkerEdgeColor', 'k', 'MarkerFaceColor','red');
%     hold off;
%     pause;
    
    dis(i,:) = (gtptx-fpts(:,1)').^2+(gtpty-fpts(:,2)').^2;

    leftx = mean(gtptx(lefteyePt));
    lefty = mean(gtpty(lefteyePt));
    rightx = mean(gtptx(righteyePt));
    righty = mean(gtpty(righteyePt));
    norm = (sqrt((leftx-rightx).*(leftx-rightx)+...
              (lefty-righty).*(lefty-righty)));
          
    dis(i,:) = (sqrt(dis(i,:)))./norm;
end
mean(dis(:))
