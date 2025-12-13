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

scanner = make "start",

  start: [

    [
      "|"
      pipe [
        advance
        append
        tag "operator"
        save "result"
        clear
      ]
    ]

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
      /^\d+/
      pipe [
        advance
        append
        map ( text ) ->
          Number.parseInt text
        tag "number"
        save "result"
        clear
      ]

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


scan = ( text ) ->
  { result } = scanner text
  result

export { scan }