import peggy from "peggy"

parser = peggy.generate """

  start = expression|.., "|"|

  expression = operator operands

  operator = symbol

  operands = operand *

  operand = literal / symbol

  literal = numeric / text

  numeric = [0-9]+

  text "text"
    = quotation_mark chars:char* quotation_mark { return chars.join(""); }

  char
    = unescaped
    / escape
      sequence:(
          '"'
        / "\\\\"
        / "/"
        / "b" { return "\\b"; }
        / "f" { return "\\f"; }
        / "n" { return "\\n"; }
        / "r" { return "\\r"; }
        / "t" { return "\\t"; }
        / "u" digits:$(HEXDIG HEXDIG HEXDIG HEXDIG) {
            return String.fromCharCode(parseInt(digits, 16));
          }
      )
      { return sequence; }

  escape
    = "\\\\"

  quotation_mark
    = '"'

  unescaped
    = [^\\0-\\x1F\\x22\\x5C]

  // See RFC 4234, Appendix B (http://tools.ietf.org/html/rfc4234).
  DIGIT  = [0-9]
  HEXDIG = [0-9a-f]i

  letter = [a-zA-Z]
  number = [0-9]
  hyphen = "-"
  period = "."
  symbol = ( letter / number / hyphen / period ) +

  """

parse = ( text ) ->
  parser.parse text

export { parse }