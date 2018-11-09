!:
:-  %say
|=  [[* eny=@uv *] *]
:-  %noun
=<  =>  engine
    =>  add-dark-bishop
    =>  add-light-bishop
    =>  %-  place-open  %queen
    =>  %-  place-open  %knight
    =>  %-  place-open  %knight
    =/  rest  %+  sort
                ~(tap in open.board)
              |=  [p=position q=position]
              (gth file.p file.q)
    =>  %+  add-pieces  ~[%rook %king %rook]  rest
    result
=>  |%
+$  file  ?(%a %b %c %d %e %f %g %h)
+$  rank  ?(%1 %2 %3 %4 %5 %6 %7 %8)
+$  position  [=file =rank]
+$  piece  ?(%rook %knight %bishop %queen %king)
+$  placement  [=piece =position]
+$  board
  $:  placed=(list placement)
      $=  open
      $_  %-  ~(gas in *(set position))
          ^-  (list position)
          :~  [%a %1]
              [%b %1]
              [%c %1]
              [%d %1]
              [%e %1]
              [%f %1]
              [%g %1]
              [%h %1]
          ==
    ==
--
^=  engine
|_  [=board die=_~(. og eny)]
++  add-pieces
  |=  [pieces=(list piece) positions=(list position)]
  |-  ^+  +>.^$
  ?~  pieces
    ?~  positions
      +>.^$
    !!
  ?~  positions  !!
  =-  %+  add-piece  i.pieces  i.positions  
  %=  $
    pieces     t.pieces
    positions  t.positions
  ==
++  add-piece
  |=  [=piece =position]
  %=  +>.$
    placed.board  [[piece position] placed.board]
    open.board  (~(del in open.board) position)
  ==
++  add-dark-bishop
  %+  place-randomly  %bishop
  :~  [%a %1]
      [%c %1]
      [%e %1]
      [%g %1]
  ==
++  add-light-bishop
  %+  place-randomly  %bishop
  :~  [%b %1]
      [%d %1]
      [%f %1]
      [%h %1]
  ==
++  place-open
  |=  =piece
  %+  place-randomly
    piece
  ~(tap in open.board)
++  place-randomly
  |=  [=piece positions=(list position)]
  =^  roll  die  (rads:die (lent positions))
  %+  add-piece  piece
  (snag roll positions)
++  result  board
--