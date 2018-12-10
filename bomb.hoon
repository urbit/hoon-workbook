!:
:-  %say
|=  [* [cuts=(list tape) ~] ~]
:-  %noun
=<
(defuse cuts)
|%
++  defuse
  |=  cuts=(list tape)
    =|  bad=(list tape)
    |-
    ?~  cuts
      "bomb defused"
    =/  cut  i.cuts
    ?~  bad
      $(bad (~(got by rules) cut), cuts t.cuts)
    ?~  (find [cut ~] bad)
      $(bad (~(got by rules) cut), cuts t.cuts)
    "boom"
++  rules
  %-  ~(gas by *(map tape (list tape)))
  :~  :-  "white"
      :~  "white"
          "black"
      ==
      :-  "red"
      :~  "white"
          "red"
          "black"
          "orange"
          "purple"
      ==
      :-  "black"
      :~  "white"
          "green"
          "orange"
      ==
      :-  "orange"
      :~  "white"
          "orange"
          "green"
          "purple"
      ==
      :-  "green"
      :~  "red"
          "black"
          "green"
          "purple"
      ==
      :-  "purple"
      :~  "purple"
          "green"
          "orange"
          "white"
      ==
  ==
--