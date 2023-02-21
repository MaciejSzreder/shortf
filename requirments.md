Requirements
============
The table below show whitch functions are required to create function in certain way.  

` `                 | `getmetatable` | `table.concat` | `loadstring` | `type` | `setmetatable` | `select`&`unpack` | `debug.getmetatable`\|`debug.setmetatable`
--------------------|----------------|----------------|--------------|--------|----------------|-------------------|-------------------------------------------
is implemented      | offen          | offen          | unsecure     | offen  | offen          | offen             | unsecure
`f'args''body'`     | !              | !              | !            |        |                |                   | 
constructing `it`   |                |                |              | !      | !              | `args`            | 
callable `it`       |                |                |              | !      | !              | `args`            | 
functional `it`     |                |                |              | !      | !              | `args`            | !
semifunctional `it` |                |                |              | !      | !              | `args`            | 