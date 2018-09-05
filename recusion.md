Recursion


Write a recursive gate that will compute the factorial of a number.

Recursion is a common patern for solving a certain set of problems
in many programming languages and Hoon is no exception. One of the
classicly recursive problems is that of factorial. The factorial of
N is the product of all positive intigers less than or equal to N.
Thus the factorial of 5, denoted as 5!, would be
```
5 * 4 * 3 * 2 * 1 = 120
```
Lets take a look at one function that solves this problem in Hoon.

```
=<  (fact 5)
^=  fact
|=  n=@ud
?:  =(n 1)
  1
(mul n $(n (dec n)))
```

The first rune we use is `=<` which is the inverted form of `=>`.
The `=>` rune is used to compose two hoons which is to say, two
expressions in Hoon. The first expression in computed and then
the second is computed against the result of the first. In the
case of `=<` the argument order is reversed.

Why did we use `=<` over `=>`? In Hoon the idiom is to put the
"heavier" expressions on the bottom, that is larger blocks of
code to the bottom of the expression. The two expressions being
evaluated are

```
(fact 5)
```
call the function `fact` with an argument of 5 and

```
^=  fact
|=  n=@ud
?:  =(n 1)
  1
(mul n $(n (dec n)))
```
the gate that we have named `fact`

The second expression contains more code and thus is "heavier." We
could have used `=>` and the code would still run, but it would
not be idiomatic.

`^=` recall is the rune for putting a face on a noun and in this
case the noun we want to put a face on is the gate created by
`|=`.

Our `fact` gate takes one argument `n` that must nest inside `@ud`
which is to say, be an unsigned integer.

Next we check to see if `n` is `1` if so, the result is just `1` as

`1 * 1 = 1`

If, however, `n` is not `1` then we move on to the rest of the problem.
This we are able to break down as `n` times the factorial of `n - 1` or

```
(mul n $(n (dec n)))
```


Aside
------
Remember that `$` is in this case a reference to the `fact` gate that we
are inside of. A gate is in actuality just a core with one arm named `$`.
The subject is searched in a depth-first, head before tail skipping faces
and importantly, stopping on the first result. What this means is the
first result found in the head will be the returned. If in this core we had
used any other rune that produced a core with an arm named `$` that is the
arm that would be refereed to instead. If you wished to refer to the outer
`$` in this context the idiomatic way would be to use `^$` which is to skip
the first match on a name. (link to documentation of ^)

------

We are going to run this gate again, but with `n` being the decrement of
`n` or `(dec n)` or `n - 1` which matches our original definition of factorial.

At this point we could move on, but it's instructive to consider how we might
actually improve this gate. This discussion will take us a bit out into the 
weeds of computing but it will shed light on an important part of creating 
recursive algorithms. 

Consider how recursion is implemented in a naive way in terms of the CPU. Inside 
the CPU is a special register called the instruction pointer (IP). This is a 
memory address of the next instruction that the CPU should perform. (The exact 
implementation of this is actually different in modern computers but that is 
besides the point.) Whenever a function gets called, the CPU pushes the current 
value of the IP onto a memory structure called the stack. The IP is then 
changed to the new location of the function. When execution of that function 
is complete, the original value of the IP is popped off of the stack and restored.
 
What would happen in the case of our recursive definition of factorial? Each 
time we need to recurse, we push another instruction pointer onto the stack, and 
when we return the computation, we pop it off again. A problem arises when we 
try to recurse more times that we have space on the stack. This will result in 
our computation failing and producing a stack overflow.

However, you may have observed that if we are calling the same function over 
and over again we essentially are pushing the same value onto the stack over 
and over again as its address in memory would not change. 

Now we come to Tail Recursion.

A function is called tail recursive when its final executable statement is a 
recursive function call, that is to say when the last thing we ask the function 
to do is to call itself. If this is the case, we only ever need to return to 
the original place it was called as there is no more computation to be done.
A clever compiler is able to recognize this pattern and avoid pushing multiple
copies of the same address onto the stack, allowing us to recurse as much
as we would like without fear of stack overflows.

Our current implementation of factorial is not tail recursive. The last thing 
we actually do is multiply the result of computing the factorial of `n - 1` 
by `n`. But with a bit of refactoring we can actually write a version that is 
in fact tail recursive and can take advantage of this feature.

```
=<  (fact 5)
^=  fact
|=  n=@ud
=/  t=@ud  1
|-
?:  =(n 1)  
    t  
$(n (dec n), t (mul t n))
```

We are still building a gate that takes one argument `n`. This time however 
we are also putting a face on a `@ud` and setting it's initial value to 1.
`|-` here is used to create a new gate with one arm `$` and immediately call
it.

We then evaluate `n` to see if it is 1. If it is we return the value of `t`
In the case that `n` is anything other than 1, 

```
$(n (dec n), t (mul t n))
```

All we are doing here is recursing our new gate and changing the values of
`n` and `t`. We simply decrement `n` and multiply `t` and `n` together to
form the new value of `t`. Essentially we are creating a running total for
the factorial computation. Since this call is the last thing that will be
run in the default case and since we are doing all computation before the
call, this version is properly tail recursive.

Exercises
==========
1. Write a recursive gate to produce the first n [Fibonacci numbers](https://en.wikipedia.org/wiki/Fibonacci_number)

2. Write a recursive gate that produces a list of moves to solve the [Tower of Hanoi problem](https://en.wikipedia.org/wiki/Tower_of_Hanoi)
