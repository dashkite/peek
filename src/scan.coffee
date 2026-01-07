import { pipe } from "@dashkite/joy/function"
import {
  make
  push
  pop
  advance
  append
  map
  tag
  save
  clear
  log
} from "@dashkite/scan"

re =
  hexadecimal: /^[+-]?0x[0-9a-fA-F]+/i
  binary: /^[+-]?0b[01]+/i
  octal: /^[+-]?0o[0-7]+/i
  decimal: /^[+-]?(?:(?:(?:[\d]{1,3}(?:,\d{3})+))|(?:\d+))(?:\.\d+)?/
  scientific: /^[+-]?\d+(?:\.\d+)?(?:[eE][+-]?\d+)/

numeric = pipe [
  advance
  append
  map ( text ) ->

    # Parsing a number is surprisingly wonky The `Number`
    # construct implicitly parses numeric text, except it
    # doesn't handle signs unless its a decimal, so we
    # handle it here instead.
    #
    # In addition, we have to take `valueOf` of the result
    # because otherwise we get a Number object instead of a
    # numeric value, which is not quite the same thing.
    #
    # It might make sense to simply parse tokens (ex: sign,
    # digit, hexadecimal, ...) and handle this in the
    # parser. On the other hand, this is fairly
    # straightforward, just awkward.

    if text.startsWith "+"
      text = text[1..]
      negate = false
    else if text.startsWith "-"
      text = text[1..]
      negate = true
    text = text.replaceAll ",", ""
    result = ( new Number text ).valueOf()
    if negate then -result else result

  tag "number"
  save "result"
  clear
  pop
]

scanner = make "start",

  start: [

    [ /^[+-]?0b/i, push "binary" ]
    [ /^[+-]?0o/i, push "octal" ]
    [ /^[+-]?0x/i, push "hexadecimal" ]
    [ /^[+-]?\d/, push "decimal" ]

    [
      ";"
      pipe [
        advance
        push "comment"
      ]
    ]

    [
      /^\s+/
      advance
    ]

    [
      /^$/
      pop
    ]

    [
      /^[^\s]+/
      pipe [
        advance
        append
        tag "symbol"
        save "result"
        clear
      ]
    ]

  ]

  comment: [
    [
      /^.+/
      pipe [
        advance
        append
      ]
    ]
    [
      /^$/m
      pipe [
        advance
        tag "comment"
        save "result"
        clear
        pop
      ]
    ]

  ]

  binary: [
    [ re.binary, numeric ]
  ]

  octal: [
    [ re.octal, numeric ]
  ]

  hexadecimal: [
    [ re.hexadecimal, numeric ]
  ]

  decimal: [
    [ re.scientific, numeric ]
    [ re.decimal, numeric ]
  ]

scan = ( text ) ->
  { result } = scanner text
  result

export { scan }