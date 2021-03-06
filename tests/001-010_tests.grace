#lang grace

// Test 1 : OK
print("Hello, world.")


// Test 2 : OK.  
print("Hello " ++ "world.")
print("Line " ++ 2)
print(3 ++ "rd line")


// Test 3 : OK
print(2 - 1)
print(1 + 1)
print(6 / 2)
print(2 * 2)
print(15 % 10)
print(3 ^ 4)
print(4 ^ 0.5)
print(5.2)

// Test 4 : OK 
var x := "Hello"
print(x)
x := x ++ " world."
print(x)
var y := 3
print(y)
y := y + 1
print(y)

// Test 5 : OK
print(true)
print(false)
print(true || false)
print(true && false)


// Test 6 : OK
print(true.not)
var x2 := false
print(false || true)
print(x2.not.not)
x2 := x2.not
print(x2 && false.not)


// Test 7 : OK
var x3 := 4
print(x3 / 2 - 1)
print(x3 - 2 / 1)
print(2 * 1 + 4 / x3)
print((x3 * (6 - 2) - x3) /3)
print(x3 - 0 + 1)
print(x3 * 3 / 2)


// Test 8 : OK
if (true) then {
    print("OK 1 then")
} else {
    print("Fail 1 then")
}
if (false) then {
    print("Fail 2 else")
} else {
    print("OK 2 else")
}
    
    
// Test 9 : FIXME (elseif is not implemented)
//if (false) then {
//    print("Fail 1 then")
//} elseif (true) then {
//    print("OK 1 elseif")
//}
//if (true.not) then {
//    print("Fail 2 then")
//} elseif (true && false) then {
//    print("Fail 2 elseif1")
//} elseif (false || true) then {
//    print("OK 2 elseif2")
//}
//if (false && false) then {
//    print("Fail 3 then")
//} elseif (false || false) then {
//    print("Fail 3 elseif")
//} else {
//    print("OK 3 else")
//}

    
// Test 10 : OK
var x4 := 1
while {x4 < 5
         } do {
    print(x4)
    x4 := x4 + 1
}
print("Last: " ++ x4)

