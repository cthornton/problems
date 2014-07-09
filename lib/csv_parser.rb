require 'stringio'

class ParseError < StandardError; end

# @example
#   CSVParser.new(some_csv_string).to_a
class CSVParser < StringIO
  QUOTE   = '"'
  D_QUOTE = QUOTE + QUOTE
  NEWLINE = "\n"
  COMMA   = ','

  attr_reader :delimiter
  attr_reader :line

  def to_a(delimiter: COMMA)
    @delimiter = delimiter
    @line      = 0
    rows = []
    while !eof?
      rows << parse_line
    end
    rows
  end

  def parse_line
    fields = []
    while !parse(NEWLINE)
      @line += 1
      fields << (parse_quoted_field || parse_field)
      at?(NEWLINE) || parse!(delimiter)
    end
    return fields
  end

  def parse_field
    token = ""
    while !at?(delimiter) && !at?(NEWLINE)
      token << getc
    end
    return token
  end

  def parse_quoted_field
    return nil unless parse(QUOTE)
    token = ""
    while !at?(NEWLINE)
      if parse(D_QUOTE)
        token << QUOTE
      elsif parse(QUOTE)
        return token
      else
        token << getc
      end
    end
    raise ParseError, "Unexpected newline encountered"
  end

  # Peeks ahead for the next n bytes and sets pos back to it's original position
  def peek(bytes = 1)
    start = pos
    str =  ""
    0.upto(bytes - 1) { str << "#{getc}" }
    seek(start, IO::SEEK_SET)
    return str
  end

  # Attempts to parse the expected string. If the string is parsed successfully,
  # increment the current position. Otherwise, raise an exception.
  def parse!(expected)
    if at?(expected)
      seek(expected.length, IO::SEEK_CUR)
      return true
    else
      raise ParseError, "Did not find expected string '#{expected}' on line #{line}, pos: #{pos}"
    end
  end

  def parse(expected)
    return parse!(expected)
  rescue ParseError
    return false
  end

  # check to see if the given string consists of the next few bytes
  def at?(string)
    return peek(string.length) == string
  end
end
