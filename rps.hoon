!:
:-  %say
|=  [[* eny=@uvJ *] [player-throw=@tas ~] ~]
:-  %noun
=/  cthrow-n  (add 1 (~(rad og eny) 3))
=/  throws=(map @tas @sd)
    %-  ~(gas by *(map @tas @sd))
    :~
        [%scissors --1]
        [%paper --2]
        [%rock --3]
    ==
=/  throwsr=(map @ud @tas)
    %-  ~(gas by *(map @ud @tas))
    :~
        [1 %scissors]
        [2 %paper]
        [3 %rock]
    ==
=/  cthrow  (~(got by throwsr) cthrow-n)
=/  player-throw-n  (~(got by throws) player-throw)
=/  diff  (dif:si (sun:si cthrow-n) player-throw-n)
=/  result
  |=  [winner=tape winning-throw=@tas losing-throw=@tas]
      "{winner} wins! {<winning-throw>} beats {<losing-throw>}"
?:  |(=(diff -1) =(diff --2))
  %-  result
    :+  "Computer"
      cthrow
    player-throw
?:  |(=(diff -2) =(diff --1))
  %-  result
    :+  "Player"
      player-throw
    cthrow
"Tie!"