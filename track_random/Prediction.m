%预测目标位置的函数
function [H] = Prediction(t,h1,h2,h3,h4,h5)


    i=(t-5):(t-1)
        T=[i(1)^2 i(1) 1;i(2)^2 i(2) 1;i(3)^2 i(3) 1;i(4)^2 i(4) 1;i(5)^2 i(5) 1]
        a=[2,1,0]
        b=[2,1,0]
        A=a'
        B=b'
        xx=[h1(1),h2(1),h3(1),h4(1),h5(1)]
        yy=[h1(2),h2(2),h3(2),h4(2),h5(2)]
        X=xx'
        Y=yy'
        W=T'*T
        mo=norm(W)
        A=inv(W)*T'*X
        B=inv(W)*T'*Y
        aa=A'
        bb=B'
        temp=T*A
        zhiT=rank(T)
        ZHIX=[T X]
        ZHIY=[T Y]
        zhix=rank(ZHIX)
        zhiy=rank(ZHIY)

    H(1)=aa(3)+aa(2)*t+aa(1)*t^2
    H(2)=bb(3)+bb(2)*t+bb(1)*t^2