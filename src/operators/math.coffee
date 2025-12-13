import { poke } from "@dashkite/katana"
import { Operators } from "./registry"

add = ( stack ) -> poke (( a, b ) -> a + b), stack

Operators.set "math.add", add
Operators.set "+", add

subtract = ( stack ) -> poke (( a, b ) -> a - b), stack

Operators.set "math.subtract", subtract
Operators.set "-", subtract

multiply = ( stack ) -> poke (( a, b ) -> a * b), stack

Operators.set "math.multiply", multiply
Operators.set "*", multiply

divide = ( stack ) -> poke (( a, b ) -> a / b), stack

Operators.set "math.divide", divide
Operators.set "/", divide

modulo = ( stack ) -> poke (( a, b ) -> a % b ), stack
Operators.set "math.modulo", modulo
Operators.set "%", modulo

Operators.set "math.power", Math.pow
Operators.set "**", Math.pow

