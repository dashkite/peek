# Peek

*Stack-based programming language*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

Peek is a simple stack-based programming language. Here’s an example of a simple Peek program:

```peek
3 5 +    ;  8
```

Internally, literals, like `3` and `5` are pushed onto the stack. Operators like `+` are aliases for named operators, in this case `math.add`.

## Syntax

Like most [concatenative](https://concatenative.org/wiki/view/Concatenative%20language) languages, the syntax for Peek is simple: it’s list a list of operators—where literals are implicit operators—separated by whitespace. Comments are delimited by semi-colons.

That’s it.

## Standard Operators

Peek’s standard (built-in) operators are still a work in progress. Basic stack and math operations are available. Please see [the documentation](docs/standard.md) for more information.

## Extending Peek

You can add operators to Peek by simply registering a function that takes a stack. Stacks are JavaScript arrays, where the top of the stack is the end of the array.

For example, to add a `greeting` operator, we can write:

```coffeescript
import { Operators } from "@dashkite/peek"
import { push } from "@dashkite/katana"

Operators.set "greeting", ( stack ) ->
  push (( name ) -> "Hello #{ name }!"), stack
```

## Motivation

Why not use an existing stack-based language like Push, Joy, or Factor? The simple answer is that we want to be able to extend it—add operators—via JavaScript. More generally, we want to be able to integrate easily with JavaScript-based environments, like browsers or Node.

In addition, we can leverage the JavaScript runtime to handle things like garbage collection. In turn, we can keep the implementation simple and flexible, while still making it useful for a broad array of tasks.

[Factor](https://factorcode.org/) is among the more practical implementations of a stack-based language, but it lives in its own universe. It’s implemented in C++ and programs are stored as images. These aren’t necessarily prohibitive but they do make it more difficult to integrate with JavaScript-based environments.

Peek promises to combine the practical approach of languages like Factor with the ubiquity of JavaScript. To realize that promise, Peek will need to borrow heavily from languages like Factor. Or, perhaps, one will eventually run seamlessly in JavaScript environments, thanks to advances like Web Assembly.

For now, Peek is the simplest approach to delivering best of both worlds.

## Status

Peek is essentially an experimental language at this point and should not be used in production.

## Roadmap

- [ ] Support scanner and parser transforms
- [ ] Expand support for literals:
  - [ ] Floating point numbers
  - [ ] Numeric encodings (hex, octal, scientific, …)
  - [ ] Strings
  - [ ] Lists
  - [ ] Hashes (objects)
  - [ ] RegExp
  - [ ] Date
  
- [ ] Expand standard library
  - [x] Basic math operators
  - [ ] I/O operators
  - [ ] Regular expressions
  - [ ] Dates

- [ ] A command-line interface
  - [ ] Comping and running programs from files
