function [x] = iter_recon(tk,t,b,k,delta,w,L)
    
   dt = t(2) - t(1) ;
   
   R_x = zeros(size(t)) ;
   
   x = zeros(L,numel(t)) ;
   
   g = zeros(numel(tk)-1,numel(t)) ;
   
   for K = 1:(numel(tk)-1)
    
       sk = ( tk(K) + tk(K+1) )/2 ;
       
       g(K,:) = sin(w*(t-sk))./(pi*(t-sk)) ;
       
       if sum( t == sk ) == 1
       
           g(K,t==sk) = w/pi ;
       
       end
   
   end
   
   
   for K = 1:(numel(tk)-1)
    
        R_x = R_x + ( 2*k*delta - b*(tk(K+1)-tk(K)) ).*g(K,:) ;
    
   end
   
   x(1,:) = R_x ;
   
   for l = 2:L
       
       R_xl = zeros(size(t)) ;
       
       for K = 1:(numel(tk)-1)
           
           temp = 0 ;
           
           ind = 1 ;
           
           while t(ind) <= tk(K+1)
           
              if t(ind) >= tk(K)
                  
                  temp = temp + x(l-1,ind)*dt ;
                  
              end
            
              ind = ind + 1 ;
              
           end
         
           R_xl = R_xl + temp.*g(K,:) ;
       end 
       
       x(l,:) = x(l-1,:) + R_x - R_xl ;
   
       l
   end
   
end