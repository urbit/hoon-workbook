/-  sole
/+  generators
=,  generators
:-  %get
|=  [* [url=tape ~] ~]
^-  (sole-request:sole (cask json))
%+  curl  (scan url auri:de-purl:html)
|=  hit/httr:eyre
?~  r.hit  !!
=/  my-json  (de-json:html q.u.r.hit)
?~  my-json  !!
=,  dejs:format
%+  produce  %json
%.  %title
%~  got  by
%-  (om same)
u.my-json
