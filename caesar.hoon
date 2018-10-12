!:
:-  %say
=+  ^=  caesar
    |%
    ++  alpha  "abcdefghijklmnopqrstuvwxyz"
    ++  shift
      |=  [message=tape key=@ud]
      (operate message key (encoder key))
    ++  unshift
      |=  [message=tape key=@ud]
      (operate message key (decoder key))
    ++  operate
      |=  [message=tape key=@ud encoder=(map @t @t)]
      ^-  tape
      %+  turn  message
      |=  a=@t
      (~(got by encoder) a)
    ++  encoder
      |=  [key=@ud]
      =/  keytape=tape  (rott alpha key)
      (coder alpha keytape)
    ++  decoder
      |=  [key=@ud]
      =/  keytape=tape  (rott alpha key)
      (coder keytape alpha)
    ++  coder
      |=  [a=tape b=tape]
      (~(put by (zipper a b)) ' ' ' ')
    ++  zipper
      |=  [a=tape b=tape]
      ^-  (map @t @t)
      =|  chart=(map @t @t)
      ?.  =((lent a) (lent b))
        ~|  %uneven-lengths  !!
      |-
      ?:  |(?=(~ a) ?=(~ b))
          chart
      $(chart (~(put by chart) i.a i.b), a t.a, b t.b)
    ++  rott
      |=  [m=tape n=@ud]
      =/  length=@ud  (lent m)
      =+  s=(trim (mod n length) m)
      (weld q.s p.s)
    --
|=  [* [msg=tape key=@ud ~] ~]
:-  %noun
=.  msg  (cass msg)
:-  (shift.caesar msg key)
(unshift.caesar msg key)
