function [int_out,spike_times,x_encoded] = TEM(t,xt,b,int_con,delta) 
    
    xt = xt + b ;
    
    int_out = zeros(size(t)) ;
    
    spike_times = zeros(size(t)) ;
    
    x_encoded = zeros(size(t)) ;
    
    s = 0 ;

    int_out_temp = -delta ;
    
    dt = t(2) - t(1) ;
    
    for l = 1:numel(t)
       
        int_out(l) = int_out_temp ;
        
        if( int_out_temp >= delta )
            
            s = s + 1 ;
            
            spike_times(s) = t(l) ;
         
            x_encoded(l) = 1 ;
            
            int_out_temp = -delta ;
            
        end
        
        int_out_temp = int_out_temp  + (xt(l)*(dt))/int_con ;
        
    end

    spike_times = spike_times(1:s) ;
    
end