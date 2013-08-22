# Usage: ruby vbox-scancode.rb <arg>
#   <arg> text to convert to hex-encoded keyboard scancodes

k = {

  "1" => "02 82",
  "2" => "03 83",
  "3" => "04 84",
  "4" => "05 85",
  "5" => "06 86",
  "6" => "07 87",
  "7" => "08 88",
  "8" => "09 89",
  "9" => "0a 8a",
  "0" => "0b 8b",

# TODO `
# TODO ~

  "!" => "2a 02 aa 82",
  "@" => "2a 03 aa 83",
  "#" => "2a 04 aa 84",
  "$" => "2a 05 aa 85",
  "%" => "2a 06 aa 86",
  "^" => "2a 07 aa 87",
  "&" => "2a 08 aa 88",
  "*" => "2a 09 aa 89",
  "(" => "2a 0a aa 8a",
  ")" => "2a 0b aa 8b",

  "-" => "0c 8c",
  "_" => "2a 0c aa 8c",

  "=" => "0d 8d",
  "+" => "2a 0d aa 8d",

  "q" => "10 90",
  "w" => "11 91",
  "e" => "12 92",
  "r" => "13 93",
  "t" => "14 94",
  "y" => "15 95",
  "u" => "16 96",
  "i" => "17 97",
  "o" => "18 98",
  "p" => "19 99",

  "Q" => "2a 10 aa",
  "W" => "2a 11 aa",
  "E" => "2a 12 aa",
  "R" => "2a 13 aa",
  "T" => "2a 14 aa",
  "Y" => "2a 15 aa",
  "U" => "2a 16 aa",
  "I" => "2a 17 aa",
  "O" => "2a 18 aa",
  "P" => "2a 19 aa",

  "[" => "1a 9a",
  "{" => "2a 1a aa 9a",
  "]" => "1b 9b",
  "}" => "2a 1b aa 9b",

  "\\" => "2b ab",
  "|" => "2a 2b aa 8b",

  "a" => "1e 9e",
  "s" => "1f 9f",
  "d" => "20 a0",
  "f" => "21 a1",
  "g" => "22 a2",
  "h" => "23 a3",
  "j" => "24 a4",
  "k" => "25 a5",
  "l" => "26 a6",

  "A" => "2a 1e aa 9e",
  "S" => "2a 1f aa 9f",
  "D" => "2a 20 aa a0",
  "F" => "2a 21 aa a1",
  "G" => "2a 22 aa a2",
  "H" => "2a 23 aa a3",
  "J" => "2a 24 aa a4",
  "K" => "2a 25 aa a5",
  "L" => "2a 26 aa a6",

  ";" => "27 a7",
  ":" => "2a 27 aa a7",

  "TODO: single-quote" => "28 a8",
  "\"" => "2a 28 aa a8",

  "z" => "2c ac",
  "x" => "2d ad",
  "c" => "2e ae",
  "v" => "2f af",
  "b" => "30 b0",
  "n" => "31 b1",
  "m" => "32 b2",

  "Z" => "2a 2c aa ac",
  "X" => "2a 2d aa ad",
  "C" => "2a 2e aa ae",
  "V" => "2a 2f aa af",
  "B" => "2a 30 aa b0",
  "N" => "2a 31 aa b1",
  "M" => "2a 32 aa b2",

  "," => "33 b3",
  "<" => "2a 33 aa b3",

  "." => "34 b4",
  ">" => "2a 34 aa b4",

  "/" => "35 b5",
  "?" => "2a 35 aa b5",

}

special = {

  "<F1>" => "3b",
  "<F2>" => "3c",
  "<F3>" => "3d",
  "<F4>" => "3e",
  "<F5>" => "3f",
  "<F6>" => "40",
  "<F7>" => "41",
  "<F8>" => "42",
  "<F9>" => "43",
  "<F10>" => "44",

  "<Esc>" => "01 81",
  "<Backspace>" => "0e 8e",
  "<Tab>" => "0f 8f",
  "<Enter>" => "1c 9c",
  "<Return>" => "1c 9c",
  "<KillX>" => "1d 38 0e",
  "<Spacebar>" => "39 b9",
  "<Up>" => "48 c8",
  "<PageUp>" => "49 c9",
  "<Home>" => "47 c7",
  "<Left>" => "4b cb",
  "<Right>" => "4d cd",
  "<End>" => "4f cf",
  "<Down>" => "50 d0",
  "<PageDown>" => "51 d1",
  "<Insert>" => "52 d2",
  "<Delete>" => "53 d3",
  "<Wait>" => "wait",

}

argv0 = ARGV[0].gsub(/ /, "<Spacebar>")

until 0 == argv0.length
  if argv0 =~ /^(<[^>]+>)/ && special[$1]
    puts special[$1]
    argv0 = argv0[$1.length..-1]
  else
    puts k[argv0.slice(0, 1)]
    argv0 = argv0[1..-1]
  end
end
