#lang racket
(require "parse.rkt"
         parser-tools/lex)

(provide read-syntax
         read
         get-info)

;; Parses the grace syntax for a module
;; 
;; Without a backend for Grace, this function simply creates
;; a fresh racket module, requires all grace AST structures, 
;; and provides the root of the parsed AST.
(define (read-syntax src-name in)
  (let* ([p-name (object-name in)]
         (stx (parse src-name in))
         [name (if (path? p-name)
                   (let-values ([(base name dir?) (split-path p-name)])
                     (string->symbol
                      (path->string (path-replace-suffix name #""))))
                   'anonymous)])
    (display (syntax->datum stx))
    (datum->syntax #f `(module ,name racket 
                         (provide data)
                         (require grace/lang/ast)
                         (define data ,(syntax->datum stx))))))

;; In case `read' is used, instead of `read-syntax':
(define (read in)
  (syntax->datum (read-syntax (object-name in) in)))

;; To get info about the language's environment support:
(define (get-info in mod line col pos)
  (lambda (key default) default))