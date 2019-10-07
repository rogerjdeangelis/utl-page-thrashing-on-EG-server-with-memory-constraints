Page thrashing on EG server with memory constraints                                       
                                                                                          
Problem                                                                                   
                                                                                          
   Page thrashing on EG server for count distinct                                         
   (see below)                                                                            
                                                                                          
                                                                                          
Solution                                                                                  
                                                                                          
   proc sort data=sashelp.class(keep=age) out=_null_ nodupkey;                            
     by age;                                                                              
   run;quit;                                                                              
                                                                                          
   OTE: There were 19 observations read from the data set SASHELP.CLASS.                  
   OTE: 13 observations with duplicate key values were deleted.                           
                                                                                          
   Uniques = 19-13 = 6                                                                    
*                _     _                                                                  
 _ __  _ __ ___ | |__ | | ___ _ __ ___                                                    
| '_ \| '__/ _ \| '_ \| |/ _ \ '_ ` _ \                                                   
| |_) | | | (_) | |_) | |  __/ | | | | |                                                  
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|                                                  
|_|                                                                                       
;                                                                                         
                                                                                          
The is often an issue with EG on a server.                                                
                                                                                          
The problem is constrained memory.                                                        
                                                                                          
Two gb of VM virtual ram,sometimes over provisioned, is all that may be available         
                                                                                          
This mean that only about 128,000,000 16 byte strings can be held in memory.              
Less if you have additional variables.                                                    
                                                                                          
proc sql;                                                                                 
  count(distinct string) as cntStr  from kave                                             
;quit;                                                                                    
                                                                                          
Will go into page thrashing mode if you have over 128,000,000 16 byte strings.            
It may take many hours to complete.                                                       
                                                                                          
                                                                                          
