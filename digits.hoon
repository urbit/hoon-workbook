!:
:-  %say
|=  [* [n=@ud ~] ~]
:-  %noun
=|  lis=(list @ud)
|-  ^+  lis
?:  (lte n 0)
  lis
%=  $
  n    (div n 10)
  lis  (mod n 10)^lis
==
