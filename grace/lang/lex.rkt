#lang racket
(require parser-tools/lex
         (prefix-in : parser-tools/lex-sre))
(provide value-tokens op-tokens lex-this simple-grace-lexer)

;value-tokens are tokens that contain a value.
;op-tokens are names of all other tokens (including all keywords
(define-tokens value-tokens (NUM STRING IDENTIFIER))
(define-empty-tokens op-tokens (EOF 
                                + - * / % ^ ++ ! && OR == < > <= >=
                                = := : DOT \;
                                //
                                LBRACE RBRACE 
                                LPAREN RPAREN 
                                LBRACKET RBRACKET
                                COMMA
                                ARROW
                                SEMICOLON
                                NEWLINE
                                OBJECT METHOD VAR TYPE IMPORT CLASS
                                RETURN DEF INHERITS IS DIALECT IF THEN
                                UNARY METHODCALL
                                ))

(define-lex-abbrevs
  (CR #\015)
  (LF #\012)
  (FF #\014)
  (TAB #\011)
  (my-whitespace (:or #\space TAB FF))
  (my-newline (:or (:: CR) (:: LF) (:seq CR LF)))
  (letter (:or (:/ "a" "z") (:/ #\A #\Z) ))
  (digit (:/ #\0 #\9))
  (number (:+ digit))
  (string (:: "\"" (:* (:or letter digit "\\\"" (intersection punctuation (complement (char-set "\""))) whitespace)) "\""))
  (comment (:: "//" (:* (:or letter digit punctuation my-whitespace))))
  (identifier (:: letter (:* (:or letter digit #\_ #\?))))
  (keyword (:or "object" "method" "var" "type" "import" "class"
                "return" "def" "inherits" "is" "dialect" "if" "then")))

(define simple-grace-lexer
  (lexer-src-pos
   ((eof) (token-EOF))
   (my-whitespace (return-without-pos (simple-grace-lexer input-port)))
   (my-newline (token-NEWLINE))
   (comment (return-without-pos (simple-grace-lexer input-port)))
   ("-" (token--))
   ("+" (token-+))
   ("*" (token-*))
   ("/" (token-/))
   ("%" (token-%))
   ("^" (token-^))
   ("!" (token-!))
   ("&&" (token-&&))
   ("||" (token-OR))
   ("==" (token-==))
   ("<" (token-<))
   (">" (token->))
   ("<=" (token-<=))
   (">=" (token->=))
   ("=" (token-=))
   (":=" (token-:=))
   ("{" (token-LBRACE))
   ("}" (token-RBRACE))
   ("(" (token-LPAREN))
   (")" (token-RPAREN))
   ("[" (token-LBRACKET))
   ("]" (token-RBRACKET))
   ("," (token-COMMA))
   (":" (token-:))
   ("." (token-DOT))
   ("->" (token-ARROW))
   (";" (token-SEMICOLON))
   (keyword (string->symbol (string-upcase lexeme)))
   ; The call to call-with-input-string interprets the quoted string literally.
   ; Otherwise, the string is represented in racket as "\"theString\""
   (string (token-STRING (call-with-input-string lexeme read))) 
   (identifier (token-IDENTIFIER (string->symbol lexeme)))
   (number (token-NUM (string->number lexeme)))))

(define (lex-this lexer input) (lambda () (lexer input)))