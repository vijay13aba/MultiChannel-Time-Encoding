function [x] = multi_iter_recon(tk,t,b,k,delta,w,L,M)

    dt = t(2) - t(1) ;
    
    R_x = zeros(1,numel(t)) ;
    
    x = zeros(L,numel(t)) ;
    
    %gt = sin(w*t)/(pi*t) ;
   
    %gt(t==0) = w/pi ;
   
    G = zeros(numel(tk)-M,numel(t)) ;
   
    for K = 1:(numel(tk)-M)
      
       %rect = ( (t >= tk(K) & t < tk(K+M)) ) ;
       
       %z = conv(gt,rect) ;
       
       %G(K,:) = z(1:numel(t))/(tk(K+M)-tk(K)) ;
       sk = ( tk(K) + tk(K+M) )/2 ;
       
       G(K,:) = sin(w*(t-sk))./(pi*(t-sk)) ;
       
       if sum( t == sk ) == 1
       
           G(K,t==sk) = w/pi ;
       
       end       
        
    end    

    
    for K = 1:(numel(tk)-M)
           
        R_x = R_x + ( 2*k*delta - b*(tk(K+M) - tk(K)) ).*G(K,:) ;
            
    end
           
    x(1,:) = R_x/M ;
    
    for l = 2:L
       
        R_xl = zeros(size(t)) ;
        
        for K = 1:(numel(tk)-M)
           
           temp = 0 ;
           
           ind = 1 ;
           
           while t(ind) <= tk(K+M)
           
              if t(ind) >= tk(K)
                  
                  temp = temp + x(l-1,ind)*dt ;
                  
              end
            
              ind = ind + 1 ;
              
           end            
           
           R_xl = R_xl + temp.*G(K,:) ;
        
        end
        
        x(l,:) = x(l-1,:) + x(1,:) - R_xl/M ;
        
        l
        
    end
    
end