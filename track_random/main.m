

clear all
N=5
%初始化平均误差的数组
for count0=1:40
    Ep1(count0)=0
    El1(count0)=0
end

count_fail=0

%循环10次
for time=1:10

   xt(1)=0
   yt(1)=0
   vx(1)=25
   vy(1)=20
   xl(1)=0
   yl(1)=0
   xp(1)=0
   yp(1)=0
for t=2:5
    tl=TrueRandom(t,xt(t-1),vx(t-1),yt(t-1),vy(t-1))
    xt(t)=tl(1)
    vx(t)=tl(3)
    xp(t)=xt(t)
    xl(t)=normrnd(xt(t),1.42,1,1)
    yt(t)=tl(2)
    vy(t)=tl(4)
    yp(t)=yt(t)
    yl(t)=normrnd(yt(t),1.42,1,1)
end

for t=6:40
    h1=[xl(t-5),yl(t-5)]
    h2=[xl(t-4),yl(t-4)]
    h3=[xl(t-3),yl(t-3)]
    h4=[xl(t-2),yl(t-2)]
    h5=[xl(t-1),yl(t-1)]
    %失跟率15%，11%，11%
    %h=Prediction(t,h1,h2,h3,h4,h5)
    %失跟率19%，15%，11%
    h=PredictionNew(h1,h2,h3,h4,h5)
    %失跟率28%
    %h=PredictionLinear(h1,h2,h3,h4,h5)
    xp(t)=h(1)
    yp(t)=h(2)

    %上面已经做完了位置预测，下面就要根据预测的位置，等待目标出现后计算其定位位置
    %首先对目标预测的位置进行处理，以决定唤醒哪个正方形的顶点处的传感器节点
    xp_temp1=floor(xp(t)/50)
    xp_temp2=xp_temp1*50

    yp_temp1=floor(yp(t)/50)
    yp_temp2=yp_temp1*50

    %则需唤醒的四个节点坐标分别为
    bp_node1=[xp_temp2,yp_temp2]
    bp_node2=[xp_temp2+50,yp_temp2]
    bp_node3=[xp_temp2,yp_temp2+50]
    bp_node4=[xp_temp2+50,yp_temp2+50]

    %用最大似然估计法进行定位计算，使用四个位于正方形定点的信标节点
    %需要根据目标的实际位置来计算出与新标节点的距离，再由此得出RSSI测距，然后由测距数据进行定位。
    %现在需要引入一种机制，以便随时得到目标的实际位置.
    %tl=TrueLocation(t)
    %tl=TrueLocationNew(t)
    tl=TrueRandom(t,xt(t-1),vx(t-1),yt(t-1),vy(t-1))
    xt(t)=tl(1)
    yt(t)=tl(2)
    vx(t)=tl(3)
    vy(t)=tl(4)
    %下面要判断。实际位置与预测位置是否在同一个格内。不在就意味着失跟了。
    %先求出实际位置所在的格。
    xt_temp1=floor(xt(t)/50)
    xt_temp2=xt_temp1*50

    yt_temp1=floor(yt(t)/50)
    yt_temp2=yt_temp1*50

    bt_node1=[xt_temp2,yt_temp2]
    bt_node2=[xt_temp2+50,yt_temp2]
    bt_node3=[xt_temp2,yt_temp2+50]
    bt_node4=[xt_temp2+50,yt_temp2+50]
    %判断是否失跟。
    if bp_node1~=bt_node1 | bp_node2~=bt_node2 | bp_node3~=bt_node3 | bp_node4~=bt_node4
        disp('Tracking failed')
        count_fail=count_fail+1
        break
    end
   %定位这部分功能不再加入，因为受定位算法影响，定位常常不准，导致失跟，现在探讨的是预测与拟合，
   %所以定位坐标可以由实际坐标生成，添加高斯噪声的影响即可
   xl(t)=xt(t)+normrnd(0,3^2,1,1)
   yl(t)=yt(t)+normrnd(0,2^2,1,1)

    %根据实际位置求出RSSI测距。
   % dt(1)=sqrt((xt(t)-bt_node1(1))^2+(yt(t)-bt_node1(2))^2)
   % dt(2)=sqrt((xt(t)-bt_node2(1))^2+(yt(t)-bt_node2(2))^2)
   % dt(3)=sqrt((xt(t)-bt_node3(1))^2+(yt(t)-bt_node3(2))^2)
   % dt(4)=sqrt((xt(t)-bt_node4(1))^2+(yt(t)-bt_node4(2))^2)
   % a=7
   % dRSSI(1)=Distance(dt(1),a)
   % dRSSI(2)=Distance(dt(2),a)
   % dRSSI(3)=Distance(dt(3),a)
   % dRSSI(4)=Distance(dt(4),a)
    %然后用最大似然估计法来计算目标的定位位置。
   % L=MostLH(bp_node1,bp_node2,bp_node3,bp_node4,dRSSI(1),dRSSI(2),dRSSI(3),dRSSI(4))
   % xl(t)=L(1)
   % yl(t)=L(2)

   %计算预测误差
   ep(t)=sqrt((xt(t)-xp(t))^2+(yt(t)-yp(t))^2)
   el(t)=sqrt((xt(t)-xl(t))^2+(yt(t)-yl(t))^2)
end


for count1=1:40
    if bp_node1~=bt_node1 | bp_node2~=bt_node2 | bp_node3~=bt_node3 | bp_node4~=bt_node4
        break
    end
Ep1(count1)=Ep1(count1)+ep(count1)
El1(count1)=El1(count1)+el(count1)
end


end



%统计5次的误差平均值
for count2=1:40
   Ep2(count2)=Ep1(count2)/(time-count_fail)
   El2(count2)=El1(count2)/(time-count_fail)
end
 Ep_total_aver=sum(Ep2)/(40-N)
 El_total_aver=sum(El2)/(40-N)
    %将定位位置与实际位置打印在图上，进行直观的对比。
    %subplot(121)
    %plot(xt,yt,'b-o',xp,yp,'k-^')
    %i=1:30
    %subplot(122)

    %显示5次的统计平均值
    k=1:40
    plot(k,Ep2,'r-*',k,El2,'b-o')
   %统计失跟次数
   %plot(count_fail,'b-o')
















