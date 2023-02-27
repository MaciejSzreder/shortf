Requirements
============
The table below show which functions are required to create function in certain way.  

&nbsp;              | `debug.getmetatable` or `debug.setmetatable` | `loadstring` | `getmetatable` | `setmetatable` | `type` | `table.concat` | `select` and `unpack` 
--------------------|----------------------------------------------|--------------|----------------|----------------|--------|----------------|-------------------
usability level     | unsecure                                     | unsecure     | high           | high           | high   | implementable  | implementable     
`f'args''body'`     |                                              | !            | !              |                |        | !              |                   
constructing `it`   |                                              |              |                | !              | !      |                | `args`            
callable `it`       |                                              |              |                | !              | !      |                | `args`            
functional `it`     | !                                            |              |                | !              | !      |                | `args`            
semifunctional `it` |                                              |              |                | !              | !      |                | `args`             