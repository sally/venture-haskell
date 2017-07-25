{-
 Chapter 2.1 "Ready, set, go!"
-}

-- simple arithmetic:
2 + 15
49 * 100
1892 - 1472
5 / 2 -- returns 2.5
(50 * 100) - 4999 -- parentheses can make order of operations precedence explicit
50 * 100 - 4999
50 * (100 - 4999) -- parentheses can change precendence
5 * (-3) -- 5 * -3 will throw an error
-- 5 + "llama" -- throws an error, basically says "llama" is not a number so it doesn't know how to add it to 5
5 + 4.0 -- returns 9.0!

{-
Integers can act like 'floating-point' numbers (though not vice versa)
-}

-- boolean algebra:
True && False -- returns False
True && True -- returns True
False || True -- returns True
not False -- returns True
not (True && True) -- returns False

-- testing for equality:
5 == 5 -- True
1 == 0 -- False
5 /= 5  -- False
5 /= 4 -- True
"hello" == "hello" -- True
-- 5 == True -- throws an error, basically says types don't match

{-
== works on any two things that can be compared, but they must be the same type of thing
-}

-- prefix functions (vs infix functions, which are like aFb instead of F(a,b))
-- example: succ
succ 7 -- returns 8
-- example: min
min 9 10 --returns 9
-- min 7 8 9 -- throws an error, min only takes 2 args (same with max)

{-
function application (calling a function by putting a space after it and typing out the parameters) has the highest precedence of them all, e.g. the two statements are equivalent:
-}
succ 9 + max 5 4 + 1 -- returns 16
(succ 9) + (max 5 4) + 1 -- returns 16
{-
this means that if we wanted the successor of the product of 9 and 10, then we would have to type succ (9 * 10) instead of succ 9 * 10
-}

{-
if a function takes two parameters, we can also call it as an infix function by surrounding it with backticks
-}
-- example: max
9 `max` 10 -- returns 10
-- example: div
div 92 10 -- returns 9
92 `div` 10 -- returns 9

{-
function definition examples
-}
doubleMe x = x + x
doubleUs x y = x*2 + y*2
-- can redefine doubleUs by using doubleMe
doubleUs x y = doubleMe x + doubleMe y
{-
common pattern seen within Haskell: make basic functions that are obviously correct, and then combine them into more complex functions to avoid repetition
-}
{-
functions in Haskell don't have to be in any particular order, so it doesn't matter if you define doubleMe first and then doubleUs, or vice versa
-}

{-
function that uses conditional
-}
doubleSmallNumber x = if x > 100
                        then x
                        else x*2
{-
difference between Haskell's if statement and if statements in imperative languages is that the else part is mandatory in Haskell.
in Haskell, EVERY EXPRESSION AND FUNCTION MUST RETURN SOMETHING.
we could also have written this statement in one line, but spacing makes it more readable
-}
{-
an 'if' statement in Haskell is an EXPRESSION, basically a piece of code that returns a value.
  since the "else" is mandatory, an 'if' statement will always return something - hence why it is an expression
e.g. 5 is an expression b/c it returns 5
e.g. 4+8 is an expression b/c it returns 12
e.g. x+y is an expression because it returns the sum of x+y
-}
{-
if we want to add one to every number produced in our previous function, then we could have written its body like the following:
-}
doubleSmallNumber' x = (if x > 100 then x else x*2) + 1
{-
with the parenthesis omitted, then it only adds one if x is greater than 100
-}
{-
note that ' prime symbol at the end of the functio name. Since the apostrophe doesn't have any special meaning in Haskell syntax, it is a valid character to use in a function name.
We usually use the 'prime' symbol to denote one of three things:
(1) foo' is either a helper definition made for the purpose of defining foo
(2) foo' is a modified version of foo
(3) foo' is a strict version of foo
see: https://stackoverflow.com/questions/10363206/what-does-apostrophe-means-in-haskell?rq=1
-}

{-
a function without any parameters are usually referred to as 'definitions'
since we can't change what names (and functions) mean once we've defined them, conanO'Brien and the string it's defined as can be used interchangeably
-}
conanO'Brien = "It's a-me, Conan O'Brien!"

{-
LISTS IN HASKELL ARE HOMOGENOUS DATA STRUCTURES -- stores elements of the SAME TYPE
  i.e. we can have a list of integers and a list of characters but can't have a list that has a hybrid of data types
-}
{-
in GHCI, we can use "let" to define a name
let a = 1 inside of GHCI is the equivalent of writing a = 1 in a script and then loading it
-}
let lostNumbers = [4,8,15,16,23,42]
-- [1,2,'a',3,'b','c',4] throws an error, Haskell would complain that characters are not numbers
{-
STRINGS ARE JUST LISTS OF CHARACTERS. "hello" is just syntactic sugar for ['h','e','l','l','o']
because strings are lists, we can use list functions on them, which are handy
-}

-- putting two lists together - use ++
[1,2,3,4] ++ [9,10,11,12] -- returns [1,2,3,4,9,10,11,12]
"hello" ++ " " ++ "world" -- returns "hello world"
{-
N.B. watch out when repeatedly using ++ operator on long strings. when putting together two lists (even if you append a singleton list to a list, e.g. [1,2,3] ++ [4]), Haskell must walk through the whole list on the left side of ++
-}
-- putting something at the beginning of the list using the : operator (also called cons operator) is instantaneous
'A':" SMALL CAT" -- returns "A SMALL CAT"
1:[2,3,4] -- returns [1,2,3,4]
{-
[1,2,3] is just syntactic sugar for 1:2:3:[], where [] is an empty list.
-}

-- getting an element out of a list by index - use !!
"Steve Buscemi" !! 6 -- returns 'B'
-- [1,2,3] !! 3 -- throws an error, because it's out of range

-- comparing lists (in lexicographical order) -- use <, <=, >, >=, ==
-- first the heads are compared, then if they are equal the second elements are compared, etc.
[3,2,1] > [2,1,0] -- returns True
[3,2,1] > [2,10,100] -- returns True
[3,4,2] > [3,4] -- returns True
[3,4,2] > [3,4,5] -- returns False
[3,4] == [3,4] -- returns True

-- getting the certain elements out of a list
head [4,3,2] -- returns 4. -- first element
tail [4,3,2] -- returns [3,2] -- chops off a list's head
last [4,3,2] -- returns 2 -- last element
init [4,3,2] -- returns [4,3] -- chops off a list's last
-- head [] -- throws an error, because there is no such thing. same for tail, init, last

-- getting certain properties of a list
length [4,3,2] -- returns 3
null [1,2,3] -- returns False
null [] -- returns True

-- more list operations
reverse [1,2,3] -- returns [3,2,1]
take 3 [5,4,3,2,1] -- returns [5,4,3]
take 1 [3,9,3] -- returns [3]
take 5 [5,4] -- returns [5,4]
take 0 [1,1,1] -- returns []
{-
N.B. if we try to take more elements than there are in a list, then it just returns the list.
N.B. if we try to take 0 elements, we get an empty list
-}
drop 3 [8,4,2,1,5,6] -- returns [1,5,6]
drop 0 [1,2,3,4] -- returns [1,2,3,4]
drop 100 [1,2,3,4] -- returns []
maximum [8,4,2,1,5,6] -- returns 8
minimum [8,4,2,1,5,6] -- returns 1
sum [5,2,1,6,3,2,5,7] -- returns 31
product [6,2,1,2] -- returns 24

-- elem takes a thing and a list of things and tells us if the thing is an element of the list
-- usually called as in infix function instead of prefix for readability
4 `elem` [3,4,5,6] -- returns True
10 `elem` [3,4,5,6] -- returns False

-- ranges
[1..10] -- equivalent to [1,2,3,4,5,6,7,8,9,10]
['a'..'z'] -- equivalent to "abcdefghijklmnopqrstuvwxyz"
['K'..'Z'] -- equivalent to "KLMNOPQRSTUVWXYZ"
-- ranges with step sizes
[2,4..10] -- equivalent to [2,4,6,8,10]
[3,6..20] -- equivalent to [3,6,9,12,15,18]
{-
N.B. to make a list with all the numbers from 20 to 1, you can't just do [20..1], you must do [20,19..1]
-}
-- infinite ranges
[13,26..] -- will get you all the multiples of 13 (an infinite list)
-- hence, if you wanted to get the first 24 multiples of 13 you can do
take 24 [13,26..]
{-
N.B. since Haskell is lazy, it won't try to evaluate the infinite list immediately because it would never finish
it will wait to see what you want to get out of that infinite list, and here it will see that you just want the first 24 elements
-}

-- some functions that product infinite lists:
-- cycle takes a list and cycles it into an infinite list
take 10 (cycle [1,2,3]) -- returns [1,2,3,1,2,3,1,2,3,1]
take 12 (cycle "LOL ") -- returns "LOL LOL LOL "
-- repeat takes an element and produces an infinite list of just that element (like cycling a list with just one element)
take 10 (repeat 5) -- returns [5,5,5,5,5,5,5,5,5,5]
{-
N.B. just use the replicate function if you want some number of the same element in a list
-}
replicate 3 10 -- returns [10,10,10]

-- list comprehensions
[x*2 | x <- [1..10]] -- returns [2,4,6,8,10,12,14,16,18,20]
[x*2 | x <- [1..10], x*2 >= 12] -- returns [12,14,16,18,20]
{-
we can see that the general structure of the comprehension goes:
the predicate (x*2 >= 12) comes after the binding parts (x <- [1..10]) and are separated from them by a comma
-}
-- multiple predicates
[ x | x <- [10..20], x /= 13, x /= 15, x /= 19] -- returns [10,11,12,14,16,17,18,20]
-- multiple bindings
[ x*y | x <- [2,5,10], y <- [8,10,11] ] -- returns [16,20,22,40,50,55,80,100,110]
{-
N.B. that the result comprehends all possible combinations between numbers in both lists
-}
-- multiple bindings with predicates
[ x*y | x <- [2,5,10], y <- [8,10,11], x*y > 50] -- returns [55,80,100,110]
-- comprehensions with predicates, defined as a function
boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]
boomBangs [7..13] -- returns ["BOOM!","BOOM!","BANG!","BANG!"]
-- use of underscore in list comprehensions - just a wildcard
length' xs = sum [1 | _ <- xs]
{-
N.B. _ means that we don't care what we'll draw from the list anyway so instead of writing a variable name that we'll never use, we just write _
-}

-- tuples
{-
Tuples are like lists. They are a way to store several values into a single value.
However, there are a few fundamental differences. A list of numbers is a list of numbers. That's its type and it doesn't matter if it has only one number in it or an infinite amount of numbers.
Tuples, however, are used when you exactly how many values you want to combine and its type depends on how many components it has and the types of components. They are denoted with parentheses and their components are separated by commas.
Also, tuples don't have to be homogenous. Unlike a list, a tuple can contain combinations of several types.
-}
-- [(1,2),(8,11,5),(4,5)] -- throws an error, because you can't put a pair and a triple in the same list
{-
- No general function to append an element to a tuple
  - you would have to write a function for appending to a pair, one function for appending to a triple, 4-tuple, etc.
- Tuples can have lists
- No such thing as a singleton tuple
- Tuples can be compared with each other if their components can be compared
- Can't compare tuples of different sizes
-}
-- operations on tuples (only pairs)
fst (8,11) -- returns 8
snd (8,11) -- returns 11
-- zip takes two lists and then zips them together into one list by joining the matching elements into pairs
zip [1,2,3,4,5] [5,5,5,5,5] -- returns [(1,5),(2,5),(3,5),(4,5),(5,5)]
-- if the lengths don't match, then the longer list simply gets cut off to match the length of the shorter one
zip [5,3,2,6,2,7,2,5,4,6,6] ["im","a","turtle"] -- returns [(5,"im"),(3,"a"),(2,"turtle")]
-- since Haskell is lazy, can zip with infinite lists
zip [1..] ["apple", "orange", "cherry", "mango"] -- returns [(1,"apple"),(2,"orange"),(3,"cherry"),(4,"mango")]

{-
PROBLEM THAT COMBINES TUPLES AND LIST COMPREHENSIONS.
  which right triangle(s) that has an integer for all sides and all sides equal to or smaller than 10 has a perimeter of 24?
-}
-- start out by generating all triangles with sides equal to or smaller than 10
let triangles = [(a,b,c) | c <- [1..10], b <- [1..10], a <- [1..10]]
-- next, if we think of c as the hypotenuse, then we specify that b cannot be larger than c, and that side a cannot be larger than side b
-- also that a^2 + b^2 = c^2
let rightTriangles = [(a,b,c) | c<-[1..10], b<-[1..c], a<-[1..b], a^2 + b^2 == c^2]
-- finally, we modify the function to say that we want the ones where the perimeter is 24
let rightTriangles' = [(a,b,c) | c<-[1..10], b<-[1..c], a<-[1..b], a^2 + b^2 == c^2, a+b+c==24]
rightTriangles' -- returns [(6,8,10)]  
