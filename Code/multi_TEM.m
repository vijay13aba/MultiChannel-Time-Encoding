function [tk_f,tk,int_out,x_enc] = multi_TEM(t,xt,b,int_con,delta,M,y_start) 

        xt = xt + b ;

        int_out = zeros(M,numel(t)) ;
        
        tk_f = [] ;
        
        tk = zeros(M,numel(t)) ;
        
        x_enc = zeros(size(t)) ;
        
        dt = t(2) - t(1) ;
        
        int_out_temp = y_start ;
        
        for l = 1:numel(t)
            
            for z = 1:M
            
                if int_out_temp(z) > delta
                
                    tk_f = [ tk_f t(l) ] ;
                    
                    tk(z,l) = 1 ;
                    
                    int_out_temp(z) = -delta ;
                
                end
            
                x_enc(l) = x_enc(l) + tk(z,l) ;
                
            end
            
            int_out(:,l) = int_out_temp ;
            
            int_out_temp = int_out_temp + (xt(l)*dt)/int_con ;
            
        end
        
end