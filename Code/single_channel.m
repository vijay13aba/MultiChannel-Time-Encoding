t = 0:0.01:40 ;

w = 2*pi ;

delta = 1.5 ;

T = (2*pi)/w ;

xt = ( mod(t,T) > (T/2) ).*( ones(size(t)) - mod(t,T) ) + ( mod(t,T) <= (T/2) ).*( mod(t,T) ) ;

c = max(abs(xt)) ;

k = 1 ;

b = c + 2*k*delta*w/pi + 1 ;

[y,tk,x_enc] = TEM(t,xt,b,k,delta) ;

[xt_recon] = iter_recon(tk,t,b,k,delta,w,1000) ;

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
plot(t,xt_recon(1000,:)) ;
legend('','l = 1','l = 10','l = 1000') ;
title("reconstucted signal") ;
subplot(4,1,4) ;
plot(t,xt_recon(1,:)-xt) ;
hold on ;
plot(t,xt_recon(10,:)-xt) ;
hold on ;
plot(t,xt_recon(100,:)-xt) ;
legend('l = 1','l = 10','l = 100') ;
title("reconstruction error") ;