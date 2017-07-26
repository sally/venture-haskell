{-
Haskell has a static type system - the type of every expression is known at compile time.
Haskell (unlike Java/Pascal) has type inference. If we write a number, we don't have to tell Haskell that it's a number, since it acn infer that on its own

Def. A type is a kind of label that every expression has. It tells us in which category of things that expression fits.
e.g. The expression True is a boolean.
e.g. "hello" is a string.

In GHCI, you can examine the types of some expressions by doing the :t command followed by any valid expression.
-}
:t 'a' -- returns 'a' :: Char
:t True -- returns True :: Bool
:t "HELLO!" -- returns "HELLO!" :: [Char]
:t (True, 'a') -- returns (True, 'a') :: (Bool, Char)
:t 4==5 -- returns 4==5 :: Bool

{-
:: is read 'has type of'

N.B. That 'a' has type of Char but "HELLO!" has type of [Char], where the square brackets denote a list.
N.B. Unlike lists, each tuple length has its own t ype, so the expression of (True, 'a') has a type of (Bool, Char) whereas an expression such as ('a', 'b', 'c') would have type of (Char, Char, Char).

Functions also have types. When writing our own functions, we can choose to give them an explicit type declaration (generally considered to be good practice except when writing very short functions).
-}

--example: the list comprehension function we made previously that filters a string so that only uppercased letters remain:
removeNonUppercase :: [Char] -> [Char] -- equivalent to writing removeNonUppercase :: String -> String, since [Char] type is synonymous with String
removeNonUppercase st = [c | c <- st, c `elem` ['A'..'Z']]

{-
We didn't have to give this function a type declaration because the compiler can infer by itself that it's a function from a string to a string, but we did anway.
How do we write out the type of a function that takes several parameters?
-}

--example: A function that takes three integers and adds them together:
addThree :: Int -> Int -> Int -> Int
-- the parameters are separated with -> and there's no special distinction between the parameters and the return type
-- the return type is the last item in the declaration and the parameters are the first three
addThree x y z = x + y + z

{-
N.B. Can always call :t on functions (since they are expressions, too)
-}

{-
SOME COMMON TYPES:
* Int (stands for integer, bounded above and below)
* Integer (stands for integer, but not bounded like Int)
* Float (real floating point with single precision)
* Double (real floating point with double the precision)
* Bool (only two values, True or False)
* Char (represents a character, denoted by single quotes)
* String (a list of characters)
N.B. Tuples are types but they are dependent on their lengths as well as the types of their components, so there is theoretically an infinite number of tuple types
N.B. The empty tuple is a type, which can only have a single value: ()
-}

{-
TYPE VARIABLES:
If we ask the type of the head function, then we get:
-}
:t head -- returns head :: [a] -> a
{-
What is a? Is it a type? Since types are written in capital case, it can't possibly be a type. This is what is called a 'type variable', meaning that a can be of any type.
This is very poweful in Haskell because it allows us to easily write very general functions if they don't use any specific behavior of the types in them.
Functions that have type variables are called polymorphic functions .The type declaration of head states that it takes a list of any type and returns one element of that type.
N.B. Although type variables can have names longer than one character, we usually give them names of a,b,c,d...
-}
:t fst -- returns fst :: (a,b) -> a
{-
This informs us that fst takes a tuple which contains two types and returns an element which is of the same type as the pair's first component. That's why we can use fst on a pair that contains any two types.
N.B. just because a and b are different type variables they don't have to be different types - it just means that the first component's type and the return value's type are the same
-}

{-
TYPECLASSES:
Typeclass is a sort of interface that defines some behavior. If a type is part of a typeclass, then that means that it supports and implements the behavior that the typeclass describes.
Typeclasses are a mechanism for overloading the meaning of names (values and functions) for different types. This allows us to write code that works on multiple types while using values of those types - for example, we can use the == operator to test many different types for equality.
The == function is defined as a part of the Eq typeclass, which could be written as follows:
-}
class Eq a where
  (==) :: a -> a -> Bool
-- see http://andrew.gibiansky.com/blog/haskell/haskell-typeclasses/

:t (==) -- returns (==) :: (Eq a) => a -> a -> Bool
{-
Everything before the => symbol is called a class constraint. We can read the previous type declaration like this:
The equality function takes ayn two values that are of the same type and returns a Bool.
The type of those two values must be a member of the Eq class (this was the class constraint).

The Eq typeclass provides an interface for testing for equality. Any type where it makes sense to test for equality between two values of that type should be a member of the Eq class. All standard Haskell types except for IO (the type for dealing with input/output) and functions are part of the Eq typeclass.

e.g. The elem function has a type of (Eq a) => a -> [a] -> Bool because it uses == over a list to check whether some value we're looking for is in it.

SOME BASIC TYPECLASSES:
Eq is used for types that support equality testing.
  The functions its members implement are == and /=
  If there's an Eq class constraint for a type variable in a function, it uses == or /= somewhere inside its definition

Ord is for types that have an ordering
-}
:t (>) -- returns (>) :: (Ord a) => a -> a -> Bool
{-
  Covers all the standard comparing functions such as >, <, >=, <=
-}
:t compare -- returns compare :: Ord a => a -> a -> Ordering
{-
  compare function takes two Ord members of the same type and returns an ordering
  Ordering is a type that can be GT, LT, or EQ

N.B. To be a member of Ord, a type must fisrt have membership in the Eq typeclass
-}
"Abrakadabra" < "Zebra" -- returns True
"Abrakadabra" `compare` "Zebra" -- returns LT
5 >= 2 -- returns True
5 `compare` 3 -- returns GT
{-
Show has members which can be presented as strings
  all types covered so far except for functions are a part of Show
  the most used function that deals with the Show typeclass is show
    it takes a value whose type is a member of Show and presents it to us as a string
-}
:t show -- returns show :: Show a => a -> String
show 3 -- returns "3"
show 5.334 -- returns "5.334"
show True -- returns "True"
show [1,2,3] -- returns "[1,2,3]"
show ("James", "Bond", 007) -- returns "(\"James\",\"Bond\",7)"
{-
Read (sort of the opposite typeclass of Show)
  the read function takes a string and returns a type which is a member of Read
-}
read "True" || False -- returns True
read "8.2" + 3.8 -- returns 12.0
read "5" - 2 -- returns 3
read "[1,2,3,4]" ++ [3] -- returns [1,2,3,4,3]
{-
N.B. if we just do read '4', then an error is thrown:
  Ambiguous type variable `a' in the constraint ...

  What GHCI is telling us is that it doesn't know what we want in return, because in the previous uses of read we did something with the result afterwards - that way, GHCI could infer what kind of result we wanted out of our read

If we look at the :t of read:
-}
:t read -- returns read :: Read a => String -> a
{-
It returns something of type Read, but if we don't try to use it in some way later, it has no way of knowing what type.
This is why we can use explicit TYPE ANNOTATIONS
  type annotations are a way of explicitly saying what the type of an expression should be
  we do this by adding a :: at the end of an expression and then specifying a type
-}
read "5" :: Int -- returns 5
read "5" :: Float -- returns 5.0
read "[1,2,3]" :: [Int] -- returns [1,2,3]
read "(3, 'a')" :: (Int, Char) -- returns (3, 'a')
{-
Enum members are sequentially ordered types - they can be enumerated
  advantage of being a member of this typeclass is that we can use its type in list ranges
  they have defined successors and predecessors, which you can get with succ and pred functions
  types in this class:
    ()
    Bool
    Char
    Ordering
    Int
    Integer
    Float
    Double
-}
['a'..'e'] -- returns "abcde"
[LT .. GT] -- returns [LT,EQ,GT]
[3 .. 5] -- returns [3,4,5]
succ 'B' -- returns 'C'
{-
Bounded members have an upper and lower bound
-}
minBound :: Int -- returns -2147483648
maxBound :: Char -- returns '\1114111'
maxBound :: Bool -- returns True
minBound :: Bool -- returns False
{-
N.B. minBound and maxBound are interesting because they have a type of (Bounded a) => a. In a sense, they are polymorphic constants

All tuples are a part of Bounded if the components are also in it
-}
maxBound :: (Bool, Int, Char)
(True,2147483647,'\1114111')
{-
Num is a numeric typeclass
  its members have the property of being able to act like numbers
-}
:t 20 -- returns 20 :: (Num t) => t
{-
then whole numbers are also polymorphic constants. They can act like any type that's a member of the Num typeclass
-}
20 :: Int -- returns 20
20 :: Integer -- returns 20
20 :: Float -- returns 20.0
20 :: Double -- returns 20.0
{-
Int, Integer, Float, and Double are types that are in the Num typeclass

If we examine the type of *, we'll see that it accepts all numbers
-}
:t (*) -- returns (*) :: (Num a) => a -> a -> a
{-
It takes two numbers OF THE SAME TYPE and returns a number of that type. This is why
  (5 :: Int) * (6 :: Integer)
throws an error - but
  5 * (6 :: Integer)
will work and produce an Integer, because 5 can act like an Integer or an Int

N.B. To join Num, a type must be already part of Show and Eq
-}
{-
Integral is also a numeric typeclass
  while Num includes all numbers, including real numbers and integral numbers, Integral includes only integral (whole) numbers
  includes the Int and Integer types
Floating includes only floating point numbers, so Float and Double
-}
{-
An example of a function dealing with numbers that has several class constraints in its signature: fromIntegral
  - has a type declaration of
-}
:t fromIntegral -- returns fromIntegral :: (Num b, Integral a) => a -> b
{-
  - from its signature, we see that it takes an integral number and turns it into a more general number
  - useful when you want integral and floating point types to work together nicely
  - for instance, we we look at the type declaration of length:
-}
:t length -- returns length :: Foldable t => t a -> Int
{-
    note that this is not as general as (Num b) => length :: [a] -> b
  hence, if we try to get a length of a list and add it to 3.2, we get an error (b/c we tried to add Int and floating point number)
  therefore, we do fromIntegral (length[1,2,3,4]) + 3.2 and it's all good
N.B. that by example, then, fromIntegral has several class constraints in its type signature and the class constraints are separated by commas inside the parentheses
-}
