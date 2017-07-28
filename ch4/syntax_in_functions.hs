{-
Haskell follows some syntactic constructs, including one called 'pattern matching'
  pattern matching consists of
    - specifying patterns to which some data should conform and then
    - checking to see if it does and then
    -deconstructing the data according to those patterns
When defining patterns, you can define separate function bodies for different patterns
  - you can pattern match on any data type (numbers, characters, lists, tuples, etc.)
e.g. a function that cheks if the number we supplied it is a seven or not
-}
lucky :: (Integral a) => a -> String
  lucky 7 = "LUCKY NUMBER SEVEN!"
  lucky x = "Sorry, you're out of luck, pal!"
{-
When lucky is called, the patterns will be checked from top to bottom and when it conforms to a pattern, the corresponding function body will be used.
  - The only way a number can conform to the first pattern here is if it is 7.
  - If it's not, then it falls through to the second pattern, which matches anything and binds it to x.
  - The function could have also been implemented by using an if statement. But what if we wanted a function that says the numbers from 1 to 5 and says "Not between 1 and 5" for any other number? Without pattern matching, we'd have to make a pretty convoluted if then else tree. However, with it:
-}
sayMe :: (Integral a) => a -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5"
{-
Note that if we moved the last pattern (the catch-all one) to the top, it would always say "Not between 1 and 5", because it would catch all the numbers and they wouldn't have a chance to fall through and be checked for any other patterns.

We can rewrite the factorial function we implemented previously. We defined the factorial of a number n as product [1..n].
  We can also define factorial function recursively -
-}
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial(n-1)
{-
N.B. Pattern matching can fail. If we define a function like this:
-}
charName :: Char -> String
charName 'a' = 'Albert'
-- charName 'b' -- throws an error "Non-exhausive patterns in function charName"
{-
Hence, we should always include a catch-all pattern so that our program doesn't crash if we get some unexpected input.

Pattern matching can also be used on tuples.
example. Make a function that takes two vectors in 2D space and adds them together. To add together two vectors, you add their x components separately and then their y components separately.
  If we didn't know about pattern matching:
-}
addVectors :: (Num a) => (a,a) -> (a,a) -> (a,a)
addVectors a b = (fst a + fst b, snd a + snd b)
{-
There is a better way to do it - we can modify the function so that it uses pattern matching
-}
addVectors :: (Num a) => (a,a) -> (a,a) -> (a,a)
addVectors (x1,y1) (x2,y2) = (x1 + x2, y1 + y2)
{-
Use of underscore:
  same thing as it does in list comprehensions, it means that we really don't care what that part is, so we just write a _
-}
first :: (a,b,c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z
{-
Pattern matching in list comprehensions
-}
let xs = [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)]
[a+b | (a,b) <- xs] -- returns [4,7,6,8,11,4]
{-
List themselves can be used in pattern matching.
  You can match with
    the empty list []
    any pattern that involves : and the empty list
    e.g. a pattern like x:xs will bind x to the head of the list to x and the rest of it to xs, even if there is only one element (so that xs ends up being an empty list)
    e.g. if you want to bind say, the first three elements to variables and the rest of the list to another variable, you can use something like x:y:z:zs, it will only match against lists that have three elements or more
-}
-- example: our own implementation of the head function
head' :: [a] -> a
head' [] = error "Can't call head on empty list, dummy!"
head' (x:_) = x
{-
N.B. if you want to bind several variables (even if one of them is just _ and doesn't actually bind at all), we have to surround them in parentheses
N.B. notice the error function that we just used - it takes a string and generates a runtime error, using that string as information about what kind of error ocurred
  it causes the program to crash
-}
-- example: a trivial function that tells us some of the first elements of the list in (in)convenient English form
tell :: (Show a) => [a] -> String
tell [] = "The list is empty"
tell (x:[]) = "The list has one element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y
-- example: Implement length function not using list comprehension, but using pattern matching and some recursion:
length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs
-- example: Implementing the sum function using pattern matching and recursion:
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs
{-
AS PATTERNS:
handy way of breaking something up according to a pattern and binding it to names whilst still keeping a reference to the whole thing
  do it by putting a name and an @ in front of the pattern
for instance, the pattern xs@(x:y:ys)
  the pattern will match exactly the same thing as x:y:ys, but you can easily get the whole list via xs instead of repeating yourself by typing out x:y:ys in the function body again
-}
-- example: saying in english what the first letter of a string is
capital :: String -> String
capital "" = "Empty string, whoops!"
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]
capital "Dracula" -- returns "The first letter of Dracula is D"
{-
Normally, we use as patterns to avoid repeating ourselves when matching against a bigger pattern when we uhave to use the whole thing again in the function body.
-}
{-
GUARDS:
While patterns are a way of making sure a value conforms to some form and deconstructing it, guards are a way of testing whether some property of a value (or several of them) are true or false
-}
bmiTell :: (RealFloat a) => a -> String
bmiTell bmi
    | bmi <= 18.5 = "Your BMI is below normal (underweight)."
    | bmi <= 25.0 = "Your BMI is normal."
    | bmi <= 30.0 = "Your BMI is above normal (overweight)."
    | otherwise   = "Your BMI is way above normal (morbidly overweight)."
{-
Guards are indicated by pipes that follow a function's name and parameters, usually indented a bit to the right and lined up
Basically is a 'case' statement from Ruby

We can use guards with functions that take as many parameters as we want
-}
bmiTell :: (RealFloat a) => a -> a -> String
bmiTell weight height
    | weight / height ^ 2 <= 18.5 = "Your BMI is below normal (underweight)."
    | weight / height ^ 2 <= 25.0 = "Your BMI is normal."
    | weight / height ^ 2 <= 30.0 = "Your BMI is above normal (overweight)."
    | otherwise   = "Your BMI is way above normal (morbidly overweight)."
{-
Note that there is no = right after the function name and its parameters before the first guard.

We can be even more dry by using a 'where' statement after the guards to define several names
  this makes it so that if we want to calculate BMI a bit differently, we only have to change it once
  it improves readability
-}
bmiTell :: (RealFloat a) => a -> a -> String
bmiTell weight height
    | bmi <= skinny = "Your BMI is below normal (underweight)."
    | bmi <= normal = "Your BMI is normal."
    | bmi <= fat    = "Your BMI is above normal (overweight)."
    | otherwise     = "Your BMI is way above normal (morbidly overweight)."
    where bmi = weight / height ^ 2
          skinny = 18.5
          normal = 25.0
          fat = 30.0
{-
You can also use where bindings to pattern match
you could have written:
    ...
    where bmi = weight / height ^ 2
          (skinny, normal, fat) = (18.5, 25.0, 30.0)
-}
{-
LET:
'where' bindings are syntactic constructs that let you bind variables at the end of a function and the whole function can see them, including all the guards
'let' bindings let you bind variables anywhere and are expressions themselves, but are very local, so they don't span across guards

~JUST LIKE ANY CONSTRUCT IN HASKELL~ that is used to bind values to names, let bindings can be used for pattern matching
-}
-- example: how can we define a function that gives us a cylinder's surface area based on its height and radius:
cylinder :: (RealFloat a) => a -> a -> a
cylinder r h =
  let sidearea = 2 * pi * r * h
      topArea = pi * r^2
  in sidearea + 2 * topArea
{-
The form is let <bindings> in <expression>
  -The names that you define in the 'let' part are accessible to the expression after the in part
  -we could have also defined this with a where binding
  -the names are also aligned in a single column
N.B. that let is different from where, in that they are expressions themselves
  where bindings are just syntactic constructs
similar to 'if' statements, where we explained that an if else statement is an expression and we can cram it in almost anywhere,
-}
[if 5 > 3 then "Woo" else "Boo", if 'a' > 'b' then "Foo" else "Bar"] -- returns ["Woo", "Bar"]
4 * (if 10 > 5 then 10 else 0) + 2 -- returns 42
{-
can also do this with let bindings
-}
4 * (let a = 9 in a + 1) + 2 -- returns 42
{-
can be used to introduce functions in local scope
-}
[let square x = x * x in (square 5, square 3, square 2)] -- returns [(25,9,4)]
{-
can use semicolons to bind several variables inline
-}
(let a = 100; b = 200; c = 300 in a*b*c, let foo="Hey "; bar = "there!" in foo ++ bar) -- returns (6000000,"Hey there!")
{-
useful for quickly dismantling a tuple into components and binding to names and such
-}
(let (a,b,c) = (1,2,3) in a+b+c) * 100 -- returns 600
{-
can also put "let" bindings inside list comprehensions
-}
calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2]
{-
note that we use "let" inside list comprehension much like we would a predicate, only it doesn't filter the list - it only binds to names.

the names defined in a "let" in a list comprehension are visible to the output function (the prat before the |) and all predicates and sections that come *after* of the binding

so this would work:
-}
calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2, bmi >= 25.0]
{-
we can't use the variable 'bmi' in (w,h) <- xs part, because it's define *prior* let binding
-}

{-
for further reading on 'let' scope vs. 'where' scope,
case expressions,
see: http://learnyouahaskell.com/syntax-in-functions
-}
