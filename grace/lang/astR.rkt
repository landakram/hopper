#lang typed/racket

;;; TODO: Account for empty list '() that is inserted in the parser, either by
;;;   adding them to the acceptable types below or changing the use of empty.

(struct: MethodType
  ([name : String]
   [signature : (Listof String)]
   [rtype : String])
  #:prefab)

(define-type IdentifierType
  (Syntaxof grace:identifier))

(define-type TypeType
  ;(U IdentifierType #f))
  ;IdentifierType)
  ;(Syntaxof String))
  (Syntaxof grace:type-annot))

(struct: grace:type-annot
  ([value : String]))

(struct: grace:number
  ([value : (Syntaxof Number)])
  #:prefab)

(struct: grace:str
  ([value : (Syntaxof String)])
  #:prefab)

(struct: grace:identifier
  ([value : String]
   [type  : TypeType])
  #:prefab)

(struct: grace:method-def
  ([name      : IdentifierType]
   [signature : (Syntaxof (Listof IdentifierType))]
   ;[signature : (Listof IdentifierType)]
   ;[rtype     : IdentifierType])
   [rtype : TypeType])
  #:prefab)

(struct: grace:type-def
  ([name    : IdentifierType]
   [methods : (Syntaxof (Listof (Syntaxof grace:method-def)))])
   ;[methods : (Listof (Syntaxof grace:method-def))])
  #:prefab)

(struct: grace:var-decl
  ([name  : IdentifierType]
   [type  : TypeType]
   [value : Any])
  #:prefab)

(struct: grace:def-decl
  ([name  : IdentifierType]
   [type  : TypeType]
   ;; TODO: possibly fix type of value
   [value : Any])
  #:prefab)

(struct: grace:bind
  ([name  : IdentifierType]
   ;; TODO: possibly fix type of value
   [value : Any])
  #:prefab)

(struct: grace:expression
  ([op  : Symbol]
   ;; TODO: Fix type of operands
   [lhs : Any]
   [rhs : Any])
  #:prefab)

(struct: grace:method-call
  ([name : (U IdentifierType (Syntaxof grace:member))]
   ;; TODO: Fix type of args
   [args : (Listof Any)])
  #:prefab)

(struct: grace:object
  ([body : (Listof (Syntaxof Any))])
  #:prefab)

(struct: grace:method
  ([name      : IdentifierType]
   [signature : (Listof IdentifierType)]
   ;; TODO: Fix type of body
   [body : (Listof (Syntaxof Any))]
   [type : TypeType])
  #:prefab)

(struct: grace:member
  ([parent : (U IdentifierType (Syntaxof grace:member))]
   [name   : IdentifierType])
  #:prefab)

(struct: grace:return
  ;; TODO: Fix type of value, maybe grace:expression or identifier.
  ([value : Any])
  #:prefab)

(struct: grace:if-then-else
  ;; TODO: Type of check definitely needs fixing.
  ([check : (U IdentifierType (Syntaxof grace:expression) (Syntaxof grace:member) (Syntaxof grace:method-call))]
   [tbody : (Listof (Syntaxof Any))]
   [ebody : (Listof (Syntaxof Any))])
  #:prefab)

(struct: grace:class-decl
  ([name       : IdentifierType]
   [param-name : IdentifierType]
   ;; TODO: Fix, maybe grace:identifier?
   [signature  : (Listof Any)]
   [body       : (Listof Any)])
  #:prefab)

;(struct: grace:code-seq
;  ([code : Any]))
(struct: grace:code-seq
  ([code : (Syntaxof (Listof (Syntaxof Any)))])
  #:prefab)

(struct: grace:newline
  ()
  #:prefab)

(provide (all-defined-out))