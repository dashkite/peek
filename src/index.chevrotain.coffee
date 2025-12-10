import {
  createToken as token
  Lexer
  CstParser as Parser   
} from "chevrotain"

compose = token name: "compose", pattern: /\|/
comment = token name: "comment", pattern: /;/
symbol = token name: "symbol", pattern: /[^|\s]/

literal =

  string: 
    token 
      name: "string literal"
      pattern: /"(?:[^\\"]|\\(?:[bfnrtv"\\/]|u[0-9a-fA-F]{4}))*"/
  
  numeric:
    token
      name: "numeric literal"
      pattern: /-?(0|[1-9]\d*)(\.\d+)?([eE][+-]?\d+)?/

ws = token 
  name: "whitespace"
  pattern: /\s+/
  group: Lexer.SKIPPED

tokens = [
    compose
    comment
    symbol
    literal.string
    literal.numeric
  ]

lexer = new Lexer tokens, positionTracking: "onlyStart"

class PeekParser extends Parser

  constructor: ->
    super tokens, recoveryEnabled: true

    @RULE "program", =>
      @MANY_SEP
        SEP: compose
        DEF: => @SUBRULE @expression

    @RULE "expression", =>
      @CONSUME symbol
      @SUBRULE @operands

    @RULE "operands", =>
      @MANY => @SUBRULE @operand

    @RULE "operand", =>
      @OR [
        { ALT: => @CONSUME literal.numeric }
        { ALT: => @CONSUME literal.string }
        { ALT: => @CONSUME symbol }
      ]
      
    @performSelfAnalysis()

parser = new PeekParser

parse = ( text ) ->
  tokens = lexer.tokenize text
  parser.input = tokens
  parser.program()

export { parse }