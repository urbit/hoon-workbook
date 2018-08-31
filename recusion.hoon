=<  (fact 10)
^=  fact
|=  n=@ud
?:  =(n 1)
  1
(add n $(n (dec n)))

=<  (fact 10)
^=  fact
|=  n=@ud
=/  t=@ud  1
|-
?+  n  $(n (dec n), t (add t n))
  %0  1
  %1  t
==

