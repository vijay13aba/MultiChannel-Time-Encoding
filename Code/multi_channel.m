t = 0:0.01:10 ;

xt = cos(4*t) + sin(t/2);

c = max(abs(xt)) ;

b = c + 2*k*delta*w/pi + 1 ;

M = 2 ;

k = 1 ;

delta = 1.5 ;

alpha = (2*delta)/M ;

y_start = zeros(1,M) ;
y_start(1) = -0.4 ;

for z = 2:M
   
    y_start(z) = mod(( y_start(z-1) + alpha ),2*delta) ;
    
end


[tk_f,tk,int_out,x_enc] = multi_TEM(t,xt,b,k,delta,M,y_start) ;

xt_recon = multi_iter_recon(tk_f,t,b,k,delta,w,100,M) ;

figure ;
subplot(4,1,1) ;
plot(t,xt) ;
title("original signal") ;
subplot(4,1,2) ;
stem(t,x_enc) ;
title("encoded signal") ;
subplot(4,1,3) ;
plot(t,xt) ;
hold on ;
plot(t,xt_recon(1,:)) ;
hold on ;
plot(t,xt_recon(10,:)) ;
hold on ;
plot(t,xt_recon(100,:)) ;
legend('l = 1','l = 10','l = 100') ;
title("reconstucted signal") ;
subplot(4,1,4) ;
plot(t,xt_recon(1,:)-xt) ;
hold on ;
plot(t,xt_recon(10,:)-xt) ;
hold on ;
plot(t,xt_recon(100,:)-xt) ;
legend('l = 1','l = 10','l = 100') ;
title("reconstruction error") ;