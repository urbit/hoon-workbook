State machines

Create a state machine in hoon that models the basic functionality of a traffic light.

```
=+  |%                                   
    ++  state  ?(%red %yellow %green)
    --
=/  current-state=state  %red
=+  ^=  traffic-light
    |%
    ++  look  current-state
    ++  set
      |=  s=state
      +>.$(current-state s)
    --
=+  a=traffic-light
=+  b=traffic-light
=.  a  (set.a %yellow)
[current-state.a current-state.b]
```

Breakdown

```
=+  |%                                   
    ++  state  ?(%red %yellow %green)
    --
```

Produce a core and put it onto the subject. This core in particular is used to
store types. This is a common idiom in hoon programs that need to introduce new
types that allows the compiler to do constant folding, which is to say it
improves performance. In this case, the type being created is `state` which can
be ond of three values `%red`, `%yellow` or `%green` corresponding to the three
light colors of a standard traffic light.

```
=/  current-state=state  %red
```

The line here is to create a noun of type `state` and give it a default value.
Because we are putting this into subject it will be available for use in our core
and any copies that are created will have their own versions of this and anything
else in the subject.


```
=+  ^=  traffic-light
```

The use of =+ here over =/ is because type is difficult to refer to and unnecessary
in this case. It is easier to allow the compiler to infer the type since we will
not need to explicitly refer to it again.

The core we are about to produce is also more useful to us if we give it a name
which is the function of ^=

```
    |%
    ++  look  current-state
    ++  set
      |=  s=state
      +>.$(current-state s)
    --
```

This is finally the meat of the program. This core we have named `traffic-light`
has two arms, `look` which gives us the current state and `set` which gives us a
simple way to modify the value of `current-state`.

The gate we are producing with |= may look a bit strange but let's break it down.

```
      |=  s=state
      +>.$(current-state s)
```

We first produce with one arm named `$`. That `$` arm will produce a new core with
`current-state` changed to match the `s` provided when it was called. How does this 
work?

First remember that `.` is [wing syntax](link to wing syntax primer) while `$` is the
arm of the core. Then using `+>`, we traverse the subject of the core to latch onto it's
parent core, where we defined the arms `look`  and `set`. The parens then list changes
to the core we would like to make as we produce a new one. You will see `+>.$` commonly
used this way so it would be a good idea to remember it.

```
=+  a=traffic-light
=+  b=traffic-light
```

Now we have the last parts of our program. Remember that `=+` allows us to create a noun
with a face and a type. In this case we are creating two nouns, one with the face `a`
and a second with the face `b`. These two nouns both have the type of `traffic-light`
which esentially makes them two new `traffic-lights` with all the bits we previously
created.

```
=.  a  (set.a %yellow)
```

Here we pull the `set` arm on `a` and give it the argument of `%yellow`. Remember that
we are actually producing a new core in set, so we have to then assign that back to the
face `a`

```
[current-state.a current-state.b]
```

Here we simply are creating a new cell that has the `current-state` from `a` as it's head
and the `current-state` from `b` as it's tail. This should produce for us

```
[%yellow %red]
```

Exercise 1) Modify the above program to include a way to cycle the light without
explicitly having to select the next color. That is, if the light is currently
`%green` then the next color would be `%yellow`. If `%yellow` then the next color
should be `%red`

Exercise 2) Using what you have learned about creating state machines in Hoon,
produce a state machine that can act as a vending machine emulator. It should
keep track of the amount of items it has, as well as the amount of money that
an item costs. To keep it simple, assume this vending machine only has one item
for sale.

Exercise 3) Modify your vending machine to support holding multiple items with
different prices.
