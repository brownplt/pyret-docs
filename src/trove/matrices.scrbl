#lang scribble/base
@(require "../../scribble-api.rkt"
          "../Pyret-Tutorial/math-utilities.rkt"
          (except-in "../abbrevs.rkt" L-of))
@(require (only-in scribble/core delayed-block)
          (only-in scribble/manual math)
          (only-in racket flatten))


@(define (matrix-method name #:args (args #f) #:return (return #f) #:contract (contract #f))
   (method-doc "Matrix" #f name #:alt-docstrings "" #:args args #:return return #:contract contract))
@(define (vector-method name #:args (args #f) #:return (return #f) #:contract (contract #f))
   (method-doc "Vector" #f name #:alt-docstrings "" #:args args #:return return #:contract contract))

@(define mtx-type (a-id "Matrix" (xref "matrices" "Matrix")))
@(define vec-type (a-id "Vector" (xref "matrices" "Vector")))
@(define vec3d-type (a-id "Vector3D" (xref "matrices" "Vector3D")))
@(define Nat (a-id "Nat" (xref "matrices" "Nat")))
@(define NonZeroNat (a-id "NonZeroNat" (xref "matrices" "NonZeroNat")))
@(define (L-of typ) `(a-app (a-id "List" (xref "lists" "List")) ,typ))

@; Creates a LaTeX inline environment
@(define (math-in-env name . strs)
  @(apply math-in (flatten (list "\\begin{" name "}") strs (string-append "\\end{" name "}"))))

@; Creates a LaTeX environment
@(define (math-disp-env name . strs)
  @(apply math-disp (flatten (list "\\begin{" name "}") strs (string-append "\\end{" name "}"))))

@; Creates a Displayed Matrix
@(define (math-mtx . strs)
@(apply math-disp-env (cons "bmatrix" strs)))

@; Creates an Inlined Matrix
@(define (math-imtx . strs)
  @(apply math-in (flatten (list "\\left[\\begin{smallmatrix}" strs "\\end{smallmatrix}\\right]"))))

@(append-gen-docs
  `(module "matrices"
    (path "src/arr/trove/matrices.arr")
    (fun-spec
      (name "is-matrix")
      (args ("val"))
      (arity 1)
      (return ,B)
      (contract (a-arrow ,A ,B)))
    (fun-spec
      (name "vector")
      (arity 1)
      (args ("elts"))
      (return ,vec-type)
      (contract (a-arrow (a-id "Number..." (xref "<globals>" "Number")) ,vec-type)))
    (fun-spec
      (name "vector3d")
      (arity 3)
      (args ("elts"))
      (return ,vec-type)
      (contract (a-arrow ,N ,N ,N ,vec-type)))
    (fun-spec
      (name "vec-magnitude")
      (arity 1)
      (args ("vec"))
      (return ,N)
      (contract (a-arrow ,vec-type ,N)))
    (fun-spec
      (name "vec-normalize")
      (arity 1)
      (args ("vec"))
      (return ,vec-type)
      (contract (a-arrow ,vec-type ,vec-type)))
    (fun-spec
      (name "vec-scale")
      (arity 2)
      (args ("vec" "factor"))
      (return ,vec-type)
      (contract (a-arrow ,vec-type ,N ,vec-type)))
    (fun-spec
      (name "is-row-matrix")
      (arity 1)
      (args ("mtx"))
      (return ,B)
      (contract (a-arrow ,mtx-type ,B)))
    (fun-spec
      (name "is-col-matrix")
      (arity 1)
      (args ("mtx"))
      (return ,B)
      (contract (a-arrow ,mtx-type ,B)))
    (fun-spec
      (name "is-square-matrix")
      (arity 1)
      (args ("mtx"))
      (return ,B)
      (contract (a-arrow ,mtx-type ,B)))
    (fun-spec
      (name "identity-matrix")
      (arity 1)
      (args ("n"))
      (return ,mtx-type)
      (contract (a-arrow ,NonZeroNat ,mtx-type)))
    (fun-spec
      (name "make-matrix")
      (arity 3)
      (args ("rows" "cols" "elt"))
      (return ,mtx-type)
      (contract (a-arrow ,NonZeroNat ,NonZeroNat ,N ,mtx-type)))
    (fun-spec
      (name "zero-matrix")
      (arity 3)
      (args ("rows" "cols" "elt"))
      (return ,mtx-type)
      (contract (a-arrow ,NonZeroNat ,NonZeroNat ,mtx-type)))
    (fun-spec
      (name "zero-matrix")
      (arity 2)
      (args ("rows" "cols"))
      (return ,mtx-type)
      (contract (a-arrow ,NonZeroNat ,NonZeroNat ,mtx-type)))
    (fun-spec
      (name "build-matrix")
      (arity 3)
      (args ("rows" "cols" "proc"))
      (return ,mtx-type)
      (contract (a-arrow ,NonZeroNat ,NonZeroNat (a-arrow ,N ,N ,N) ,mtx-type)))
    (fun-spec
      (name "vector-to-matrix")
      (arity 1)
      (args ("v"))
      (return ,mtx-type)
      (contract (a-arrow ,vec-type ,mtx-type)))
    (fun-spec
      (name "list-to-matrix")
      (arity 3)
      (args ("rows" "cols" "lst"))
      (return ,mtx-type)
      (contract (a-arrow ,NonZeroNat ,NonZeroNat (a-app (a-id "List" (xref "lists" "List")) ,N) ,mtx-type)))
    (fun-spec
      (name "list-to-row-matrix")
      (arity 1)
      (args ("lst"))
      (return ,mtx-type)
      (contract (a-arrow (a-app (a-id "List" (xref "lists" "List")) ,N) ,mtx-type)))
    (fun-spec
      (name "list-to-col-matrix")
      (arity 1)
      (args ("lst"))
      (return ,mtx-type)
      (contract (a-arrow (a-app (a-id "List" (xref "lists" "List")) ,N) ,mtx-type)))
    (fun-spec
      (name "lists-to-matrix")
      (arity 1)
      (args ("lst"))
      (return ,mtx-type)
      (contract (a-arrow (a-app (a-id "List" (xref "lists" "List")) ,N) ,mtx-type)))
    (fun-spec
      (name "vectors-to-matrix")
      (arity 1)
      (args ("lst"))
      (return ,mtx-type)
      (contract (a-arrow (a-app (a-id "List" (xref "lists" "List")) ,vec-type) ,mtx-type)))
    (fun-spec
      (name "matrix-within")
      (arity 1)
      (args ("delta"))
      (return (a-arrow ,mtx-type ,mtx-type ,B))
      (contract (a-arrow ,N (a-arrow ,mtx-type ,mtx-type ,B))))
    (fun-spec
     (name "vec-get")
     (arity 2)
     (args ("v" "index"))
     (return ,N)
     (contract (a-arrow ,vec-type ,Nat ,N)))
    (fun-spec
     (name "vec-dot")
     (arity 2)
     (args ("v1" "v2"))
     (return ,N)
     (contract (a-arrow ,vec-type ,vec-type ,N)))
    (fun-spec
     (name "vec-cross")
     (arity 2)
     (args ("v1" "v2"))
     (return ,vec3d-type)
     (contract (a-arrow ,vec3d-type ,vec3d-type ,vec3d-type)))
    (fun-spec
     (name "vec-normalize")
     (arity 1)
     (args ("v"))
     (return ,vec-type)
     (contract (a-arrow ,vec-type ,vec-type)))
    (fun-spec
     (name "vec-scale")
     (arity 2)
     (args ("v" "scalar"))
     (return ,vec-type)
     (contract (a-arrow ,vec-type ,N ,vec-type)))
    (fun-spec
     (name "vec-add")
     (arity 2)
     (args ("v1" "v2"))
     (return ,vec-type)
     (contract (a-arrow ,vec-type ,vec-type ,vec-type)))
    (fun-spec
     (name "vec-sub")
     (arity 2)
     (args ("v1" "v2"))
     (return ,vec-type)
     (contract (a-arrow ,vec-type ,vec-type ,vec-type)))
    (fun-spec
     (name "vec-length")
     (arity 1)
     (args ("v"))
     (return ,N)
     (contract (a-arrow ,vec-type ,N)))
    (fun-spec 
     (name "mtx-get")
     (arity 3)
     (args ("m" "i" "j"))
     (return ,N)
     (contract (a-arrow ,mtx-type ,Nat ,Nat ,N)))
    (fun-spec 
     (name "mtx-to-list")
     (arity 1)
     (args ("m"))
     (return ,(L-of N))
     (contract (a-arrow ,mtx-type ,(L-of N))))
    (fun-spec 
     (name "mtx-to-vector")
     (arity 1)
     (args ("m"))
     (return ,vec-type)
     (contract (a-arrow ,mtx-type ,vec-type)))
    (fun-spec 
     (name "mtx-to-lists")
     (arity 1)
     (args ("m"))
     (return ,(L-of (L-of N)))
     (contract (a-arrow ,mtx-type ,(L-of (L-of N)))))
    (fun-spec 
     (name "mtx-to-vectors")
     (arity 1)
     (args ("m"))
     (return ,(L-of vec-type))
     (contract (a-arrow ,mtx-type ,(L-of vec-type))))
    (fun-spec 
     (name "mtx-row")
     (arity 2)
     (args ("m" "i"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,Nat ,mtx-type)))
    (fun-spec 
     (name "mtx-col")
     (arity 2)
     (args ("m" "j"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,Nat ,mtx-type)))
    (fun-spec 
     (name "mtx-submatrix")
     (arity 3)
     (args ("m" "loi" "loj"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,(L-of Nat) ,(L-of Nat) ,mtx-type)))
    (fun-spec 
     (name "mtx-transpose")
     (arity 1)
     (args ("m"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-hermitian")
     (arity 1)
     (args ("m"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-diagonal")
     (arity 1)
     (args ("m"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-upper-triangle")
     (arity 1)
     (args ("m"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-lower-triangle")
     (arity 1)
     (args ("m"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-row-list")
     (arity 1)
     (args ("m"))
     (return ,(L-of mtx-type))
     (contract (a-arrow ,mtx-type ,(L-of mtx-type))))
    (fun-spec 
     (name "mtx-col-list")
     (arity 1)
     (args ("m"))
     (return ,(L-of mtx-type))
     (contract (a-arrow ,mtx-type ,(L-of mtx-type))))
    (fun-spec 
     (name "mtx-map")
     (arity 2)
     (args ("func" "m"))
     (return ,mtx-type)
     (contract (a-arrow (a-arrow ,N ,N) ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-map2")
     (arity 3)
     (args ("func" "m" "n"))
     (return ,mtx-type)
     (contract (a-arrow (a-arrow ,N ,N ,N) ,mtx-type ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-row-map")
     (arity 2)
     (args ("func" "m"))
     (return ,mtx-type)
     (contract (a-arrow (a-arrow ,mtx-type ,mtx-type) ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-col-map")
     (arity 2)
     (args ("func" "m"))
     (return ,mtx-type)
     (contract (a-arrow (a-arrow ,mtx-type ,mtx-type) ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-augment")
     (arity 2)
     (args ("m1" "m2"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-stack")
     (arity 2)
     (args ("m1" "m2"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-trace")
     (arity 1)
     (args ("m"))
     (return ,N)
     (contract (a-arrow ,mtx-type ,N)))
    (fun-spec 
     (name "mtx-scale")
     (arity 2)
     (args ("m" "factor"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,N ,mtx-type)))
    (fun-spec 
     (name "mtx-dot")
     (arity 2)
     (args ("m1" "m2"))
     (return ,N)
     (contract (a-arrow ,mtx-type ,mtx-type ,N)))
    (fun-spec 
     (name "mtx-add")
     (arity 2)
     (args ("m1" "m2"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-sub")
     (arity 2)
     (args ("m1" "m2"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-mult")
     (arity 2)
     (args ("m1" "m2"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-expt")
     (arity 2)
     (args ("m" "power"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,Nat ,mtx-type)))
    (fun-spec 
     (name "mtx-determinant")
     (arity 1)
     (args ("m"))
     (return ,N)
     (contract (a-arrow ,mtx-type ,N)))
    (fun-spec 
     (name "mtx-is-invertible")
     (arity 1)
     (args ("m"))
     (return ,B)
     (contract (a-arrow ,mtx-type ,B)))
    (fun-spec 
     (name "mtx-is-orthonormal")
     (arity 1)
     (args ("m"))
     (return ,B)
     (contract (a-arrow ,mtx-type ,B)))
    (fun-spec 
     (name "mtx-rref")
     (arity 1)
     (args ("m"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-inverse")
     (arity 1)
     (args ("m"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-solve")
     (arity 2)
     (args ("m1" "m2"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-least-squares-solve")
     (arity 2)
     (args ("m1" "m2"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,mtx-type ,mtx-type)))
    (fun-spec 
     (name "mtx-lp-norm")
     (arity 2)
     (args ("m" "power"))
     (return ,N)
     (contract (a-arrow ,mtx-type ,N ,mtx-type)))
    (fun-spec 
     (name "mtx-l1-norm")
     (arity 1)
     (args ("m"))
     (return ,N)
     (contract (a-arrow ,mtx-type ,N)))
    (fun-spec 
     (name "mtx-l2-norm")
     (arity 1)
     (args ("m"))
     (return ,N)
     (contract (a-arrow ,mtx-type ,N)))
    (fun-spec 
     (name "mtx-l-inf-norm")
     (arity 1)
     (args ("m"))
     (return ,N)
     (contract (a-arrow ,mtx-type ,N)))
    (fun-spec 
     (name "mtx-qr-decomposition")
     (arity 1)
     (args ("m"))
     (return ,(a-record (a-field "Q" mtx-type)
                        (a-field "R" mtx-type)))
     (contract (a-arrow ,mtx-type ,(a-record (a-field "Q" mtx-type)
                                             (a-field "R" mtx-type)))))
    (fun-spec 
     (name "mtx-gram-schmidt")
     (arity 1)
     (args ("m"))
     (return ,mtx-type)
     (contract (a-arrow ,mtx-type ,mtx-type)))
    (data-spec (name "Vector3D"))
    (data-spec (name "Nat"))
    (data-spec (name "NonZeroNat"))
    (unknown-item
      (name "matrix")
      ;; maker of matrices
      )
    (unknown-item
      (name "row-matrix")
      ;; maker of 1-row matrices
      )
    (unknown-item
      (name "col-matrix")
      ;; maker of 1-col matrices
      )
    (data-spec
      (name "Vector")
      (shared (
        (method-spec
          (name "get")
          (arity 2)
          (args ("self" "index"))
          (return ,N)
          (contract (a-arrow ,vec-type ,Nat ,N)))
        (method-spec
          (name "dot")
          (arity 2)
          (args ("self" "other"))
          (return ,N)
          (contract (a-arrow ,vec-type ,vec-type ,N)))
        (method-spec
          (name "magnitude")
          (arity 1)
          (args ("self"))
          (return ,N)
          (contract (a-arrow ,vec-type ,N)))
        (method-spec
          (name "cross")
          (arity 2)
          (args ("self" "other"))
          (return ,vec3d-type)
          (contract (a-arrow ,vec3d-type ,vec3d-type)))
        (method-spec
          (name "normalize")
          (arity 1)
          (args ("self"))
          (return ,vec-type)
          (contract (a-arrow ,vec-type ,vec-type)))
        (method-spec
          (name "scale")
          (arity 2)
          (args ("self" "scalar"))
          (return ,vec-type)
          (contract (a-arrow ,vec-type ,N ,vec-type)))
        @; (method-spec
        @;   (name "_plus")
        @;   (arity 2)
        @;   (args ("self" "other"))
        @;   (return ,vec-type)
        @;   (contract (a-arrow ,vec-type ,vec-type ,vec-type)))
        @; (method-spec
        @;   (name "_minus")
        @;   (arity 2)
        @;   (args ("self" "other"))
        @;   (return ,vec-type)
        @;   (contract (a-arrow ,vec-type ,vec-type ,vec-type)))
        (method-spec
          (name "length")
          (arity 1)
          (args ("self"))
          (return ,N)
          (contract (a-arrow ,vec-type ,N)))
        (method-spec
          (name "to-row-matrix")
          (arity 1)
          (args ("self"))
          (return ,mtx-type)
          (contract (a-arrow ,mtx-type)))
        (method-spec
          (name "to-col-matrix")
          (arity 1)
          (args ("self"))
          (return ,mtx-type)
          (contract (a-arrow ,mtx-type))))))
    (data-spec
      (name "Matrix")
      (variants ("matrix"))
      (shared (
          (method-spec 
            (name "get")
            (arity 3)
            (args ("self" "i" "j"))
            (return ,N)
            (contract (a-arrow ,mtx-type ,Nat ,Nat ,N)))
          (method-spec 
            (name "to-list")
            (arity 1)
            (args ("self"))
            (return ,(L-of N))
            (contract (a-arrow ,mtx-type ,(L-of N))))
          (method-spec 
            (name "to-vector")
            (arity 1)
            (args ("self"))
            (return ,vec-type)
            (contract (a-arrow ,mtx-type ,vec-type)))
          (method-spec 
            (name "to-lists")
            (arity 1)
            (args ("self"))
            (return ,(L-of (L-of N)))
            (contract (a-arrow ,mtx-type ,(L-of (L-of N)))))
          (method-spec 
            (name "to-vectors")
            (arity 1)
            (args ("self"))
            (return ,(L-of vec-type))
            (contract (a-arrow ,mtx-type ,(L-of vec-type))))
          (method-spec 
            (name "row")
            (arity 2)
            (args ("self" "i"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,Nat ,mtx-type)))
          (method-spec 
            (name "col")
            (arity 2)
            (args ("self" "j"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,Nat ,mtx-type)))
          (method-spec 
            (name "submatrix")
            (arity 3)
            (args ("self" "loi" "loj"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,(L-of Nat) ,(L-of Nat) ,mtx-type)))
          (method-spec 
            (name "transpose")
            (arity 1)
            (args ("self"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,mtx-type)))
          (method-spec 
            (name "hermitian")
            (arity 1)
            (args ("self"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,mtx-type)))
          (method-spec 
            (name "diagonal")
            (arity 1)
            (args ("self"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,mtx-type)))
          (method-spec 
            (name "upper-triangle")
            (arity 1)
            (args ("self"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,mtx-type)))
          (method-spec 
            (name "lower-triangle")
            (arity 1)
            (args ("self"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,mtx-type)))
          (method-spec 
            (name "row-list")
            (arity 1)
            (args ("self"))
            (return ,(L-of mtx-type))
            (contract (a-arrow ,mtx-type ,(L-of mtx-type))))
          (method-spec 
            (name "col-list")
            (arity 1)
            (args ("self"))
            (return ,(L-of mtx-type))
            (contract (a-arrow ,mtx-type ,(L-of mtx-type))))
          (method-spec 
            (name "map")
            (arity 2)
            (args ("self" "func"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type (a-arrow ,N ,N) ,mtx-type)))
          (method-spec 
            (name "map2")
            (arity 3)
            (args ("self" "other" "func"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,mtx-type (a-arrow ,N ,N ,N) ,mtx-type)))
          (method-spec 
            (name "row-map")
            (arity 2)
            (args ("self" "func"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type (a-arrow ,mtx-type ,mtx-type) ,mtx-type)))
          (method-spec 
            (name "col-map")
            (arity 2)
            (args ("self" "func"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type (a-arrow ,mtx-type ,mtx-type) ,mtx-type)))
          (method-spec 
            (name "augment")
            (arity 2)
            (args ("self" "other"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,mtx-type ,mtx-type)))
          (method-spec 
            (name "stack")
            (arity 2)
            (args ("self" "other"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,mtx-type ,mtx-type)))
          (method-spec 
            (name "trace")
            (arity 1)
            (args ("self"))
            (return ,N)
            (contract (a-arrow ,mtx-type ,N)))
          (method-spec 
            (name "scale")
            (arity 2)
            (args ("self" "factor"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,N ,mtx-type)))
          (method-spec 
            (name "dot")
            (arity 2)
            (args ("self" "other"))
            (return ,N)
            (contract (a-arrow ,mtx-type ,mtx-type ,N)))
          @; (method-spec 
          @;   (name "_plus")
          @;   (arity 2)
          @;   (args ("self" "other"))
          @;   (return ,mtx-type)
          @;   (contract (a-arrow ,mtx-type ,mtx-type ,mtx-type)))
          @; (method-spec 
          @;   (name "_minus")
          @;   (arity 2)
          @;   (args ("self" "other"))
          @;   (return ,mtx-type)
          @;   (contract (a-arrow ,mtx-type ,mtx-type ,mtx-type)))
          (method-spec 
            (name "_times")
            (arity 2)
            (args ("self" "other"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,mtx-type ,mtx-type)))
          (method-spec 
            (name "expt")
            (arity 2)
            (args ("self" "power"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,N ,mtx-type)))
          (method-spec 
            (name "determinant")
            (arity 1)
            (args ("self"))
            (return ,N)
            (contract (a-arrow ,mtx-type ,N)))
          (method-spec 
            (name "is-invertible")
            (arity 1)
            (args ("self"))
            (return ,B)
            (contract (a-arrow ,mtx-type ,B)))
          (method-spec 
            (name "is-orthonormal")
            (arity 1)
            (args ("self"))
            (return ,B)
            (contract (a-arrow ,mtx-type ,B)))
          (method-spec 
            (name "rref")
            (arity 1)
            (args ("self"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,mtx-type)))
          (method-spec 
            (name "inverse")
            (arity 1)
            (args ("self"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,mtx-type)))
          (method-spec 
            (name "solve")
            (arity 2)
            (args ("self" "other"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,mtx-type ,mtx-type)))
          (method-spec 
            (name "least-squares-solve")
            (arity 2)
            (args ("self" "other"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,mtx-type ,mtx-type)))
          (method-spec 
            (name "lp-norm")
            (arity 2)
            (args ("self" "power"))
            (return ,N)
            (contract (a-arrow ,mtx-type ,N ,mtx-type)))
          (method-spec 
            (name "l1-norm")
            (arity 1)
            (args ("self"))
            (return ,N)
            (contract (a-arrow ,mtx-type ,N)))
          (method-spec 
            (name "l2-norm")
            (arity 1)
            (args ("self"))
            (return ,N)
            (contract (a-arrow ,mtx-type ,N)))
          (method-spec 
            (name "l-inf-norm")
            (arity 1)
            (args ("self"))
            (return ,N)
            (contract (a-arrow ,mtx-type ,N)))
          (method-spec 
            (name "qr-decomposition")
            (arity 1)
            (args ("self"))
            (return ,(a-record (a-field "Q" mtx-type)
                               (a-field "R" mtx-type)))
            (contract (a-arrow ,mtx-type ,(a-record (a-field "Q" mtx-type)
                                                    (a-field "R" mtx-type)))))
          (method-spec 
            (name "lu-decomposition")
            (arity 1)
            (args ("self"))
            (return ,(a-record (a-field "L" mtx-type)
                               (a-field "U" mtx-type)))
            (contract (a-arrow ,mtx-type ,(a-record (a-field "L" mtx-type)
                                                    (a-field "U" mtx-type)))))
          (method-spec 
            (name "gram-schmidt")
            (arity 1)
            (args ("self"))
            (return ,mtx-type)
            (contract (a-arrow ,mtx-type ,mtx-type)))
          (method-spec 
            (name "_torepr")
            (arity 1)
            (args ("self"))
            (return ,S)
            (contract (a-arrow ,mtx-type ,S)))
          (method-spec 
            (name "_equals")
            (arity 2)
            (args ("self" "other"))
            (return ,B)
            (contract (a-arrow ,mtx-type ,mtx-type ,B)))
          )))))

@docmodule["matrices"]{
@hyperlink["https://en.wikipedia.org/wiki/Matrix_(mathematics)"]{@emph{Matrices}}
are rectangular grids of numbers, which define many useful mathematical
operations.  Matrices can manipulate each other, and are also used to
manipulate
@hyperlink["https://en.wikipedia.org/wiki/Vector_(mathematics_and_physics)"]{@emph{vectors}},
which are lists of numbers that likewise define many useful mathematical
operations.

This library defines both the @pyret-id["Vector"] datatype and the
@pyret-id["Matrix"] datatype.  All functionality in this library is defined
both as methods on the data values and as analogous functions.

@section{The Vector Datatype}

@type-spec["Vector" '()]{

The @pyret{Vector} type represents mathematical vectors.

}

@type-spec["Vector3D" '()]{

Like @pyret{Vector}, but only allows 3-dimensional vectors.

}

@type-spec["Nat" '()]{The type of natural numbers, i.e. non-negative integers.}
@type-spec["NonZeroNat" '()]{The type of positive integers.}

@collection-doc["vector" #:contract `(a-arrow ("elt" ,N) ,vec-type)]

Vector constructor which creates a vector instance with the given elements.

@collection-doc["vector3d" #:contract `(a-arrow ("elt1" ,N) ("elt2" ,N) ("elt3" ,N) ,vec-type) #:show-ellipses #f]

Vector constructor which only creates three-dimensional vector instances.


Vectors are defined to permit using addition and subtraction operators on them,
whenever the lengths of the vectors are the same:

@examples{
check:
  [vector: 1, 2, 3] + [vector: 4, 5, 6] is [vector: 5, 7, 9]
  [vector: 1] + [vector: 1, 2] raises "vectors of different lengths"
  [vector: 1, 2, 3] - [vector: 4, 5, 6] is [vector: -3, -3, -3]
  [vector: 1] - [vector: 1, 2] raises "vectors of different lengths"
end
}

See also @pyret-id{vec-add} and @pyret-id{vec-sub}.

Two vectors are considered equal when their lengths are the same and their
corresponding elements are equal, and obeys the same restrictions on comparing
exact and rough numbers for equality:

@examples{
check:
  ([vector: 1] == [vector: 1, 2]) is false
  ([vector: 1, 2] == [vector: 1, 2]) is true
  ([vector: ~1, ~2] == [vector: 1, 2]) raises "not allowed"
  roughly-equal([vector: ~1, ~2], [vector: 1, 2]) is true
end
}

@section{Vector Methods}

@vector-method["get"]

Returns the item at the given index in this vector.

@examples{
check:
  [vector: 3, 5].get(1) is 5
end
}

@vector-method["length"]

Returns the length of this vector.

@examples{
check:
  [vector: 1, 2, 3, 4].length() is 4
end
}

@vector-method["dot"]

Returns the dot product of this vector with the given vector.

@examples{
check:
  [vector: 1, 2, 3].dot([vector: 3, 2, 1]) is 10
end
}

@vector-method["magnitude"]

Returns the magnitude of this vector.

@examples{
  check:
    [vector: 3, 4].magnitude() is 5
    [vector: 4, 0].magnitude() is 4
  end
  }

@vector-method["cross"]

Returns the cross product of this 3D vector and the given 3D vector.
(Raises an error if either this or that vector are not 3-dimensional)

@examples{
check:
  [vector: 2, -3, 1].cross([vector: -2, 1, 1]) is [vector: -4, -4, -4]
end
}

@vector-method["normalize"]

Normalizes this vector into a unit vector.

@examples{
check:
  [vector: 1, 2, 3].normalize()
    is [vector: (1 / num-sqrt(14)), (2 / num-sqrt(14)), (3 / num-sqrt(14))]
end
}


@vector-method["scale"]

Scales this vector by the given constant.

@examples{
check:
  [vector: 1, 2, 3].scale(2) is [vector: 2, 4, 6]
end
}

@vector-method["to-row-matrix"]

Converts this vector to a one-row matrix.

@examples{
check:
  [vector: 4, 5, 6].to-row-matrix() is [matrix(1, 3): 4, 5, 6]
end
}

@vector-method["to-col-matrix"]

Converts this vector to a one-column matrix.

@examples{
check:
  [vector: 4, 5, 6].to-row-matrix() is [matrix(3, 1): 4, 5, 6]
end
}

@section{Vector Functions}

@function["vec-get"]

Returns the item at the given index in the given vector.

@examples{
check:
  vec-get([vector: 3, 5], 1) is 5
end
}

See @pyret-method["Vector" "get"].

@function["vec-length"]

Returns the length of the given vector.

@examples{
check:
  vec-length([vector: 1, 2, 3, 4]) is 4
end
}

See @pyret-method["Vector" "length"].

@function["vec-dot"]

Returns the dot product of the first vector with the second vector.

@examples{
check:
  vec-dot[vector: 1, 2, 3], ([vector: 3, 2, 1]) is 10
end
}

See @pyret-method["Vector" "dot"].

@function["vec-magnitude"]

Returns the magnitude of the given vector.

@examples{
  check:
    vec-magnitude([vector: 3, 4]) is 5
    vec-magnitude([vector: 4, 0]) is 4
  end
}

See @pyret-method["Vector" "magnitude"].

@function["vec-cross"]

Returns the cross product of the two given 3D vectors.
(Raises an error if either vector is not 3-dimensional)

@examples{
check:
  vec-cross([vector: 2, -3, 1], [vector: -2, 1, 1]) is [vector: -4, -4, -4]
end
}

See @pyret-method["Vector" "cross"].

@function["vec-normalize"]

Normalizes the given vector into a unit vector.

@examples{
check:
  vec-normalize([vector: 1, 2, 3])
    is [vector: (1 / num-sqrt(14)), (2 / num-sqrt(14)), (3 / num-sqrt(14))]
end
}


See @pyret-method["Vector" "normalize"].

@function["vec-scale"]

Scales the given vector by the given constant.

@examples{
check:
  vec-scale([vector: 1, 2, 3], 2) is [vector: 2, 4, 6]
end
}

See @pyret-method["Vector" "scale"].


@function["vec-add"]

Adds the second vector to first one.

@examples{
check:
  vec-add([vector: 1, 2, 3], [vector: 4, 5, 6]) is [vector: 5, 7, 9]
  vec-add([vector: 1], [vector: 1, 2]) raises "vectors of different lengths"
end
}


@function["vec-sub"]

Subtracts the second vector from first one.

@examples{
check:
  vec-sub([vector: 1, 2, 3], [vector: 4, 5, 6]) is [vector: -3, -3, -3]
  vec-sub([vector: 1], [vector: 1, 2]) raises "vectors of different lengths"
end
}

@section{The Matrix Datatype}
@type-spec["Matrix" '()]

The @pyret{Matrix} type represents mathematical matrices.

@nested[#:style 'inset]{

@function["is-matrix" #:alt-docstrings ""]

}

Every matrix has a @pyret{rows} field and a @pyret{cols} field, which are the
dimensions of the matrix.

@examples{
check:
  [matrix(2, 3): 10, 20, 30, 40, 50, 60].rows is 2
  [matrix(2, 3): 10, 20, 30, 40, 50, 60].cols is 3
end
}

@section{Matrix Constructors}

@collection-doc["matrix" #:contract `(a-arrow ("rows" ,NonZeroNat) ("cols" ,NonZeroNat)
                                              (a-arrow ("elt" ,N) ,mtx-type))]

Publicly exposed constructor which constructs a matrix of size 
@pyret{rows} by @pyret{cols} with the given elements, entered row by row.

The following example represents the matrix @math-imtx{1 & 2 & 3 \\ 4 & 5 & 6}:

@examples{
[matrix(2,3): 1, 2, 3, 4, 5, 6]
}

Supplying an inconsistent quantity of elements for a given matrix dimension
will produce an error:

@examples{
check:
  [matrix(4, 2): 100] raises "Invalid 1x2 Matrix"
end
}

@collection-doc["row-matrix" #:contract `(a-arrow ("elt" ,N) ,mtx-type)]

Constructor which returns a one-row matrix containing the given entries.

The following will construct the matrix @math-imtx{1 & 2 & 3}:

@examples{
check:
  [row-matrix: 1, 2, 3] is [matrix(1,3): 1, 2, 3]
end
}

@collection-doc["col-matrix" #:contract `(a-arrow ("elt" ,N) ,mtx-type)]

Constructor which returns a one-column matrix containing the given entries.

The following will construct the matrix @math-imtx{1 \\ 2 \\ 3}:

@examples{
check:
  [col-matrix: 1, 2, 3] is [matrix(3,1): 1, 2, 3]
end
}

@function["identity-matrix"]

Constructs an @math-in{n \times n} identity matrix.

@examples{
check:
  identity-matrix(2) is [matrix(2,2): 1, 0,
                                      0, 1]
  identity-matrix(3) is [matrix(3,3): 1, 0, 0,
                                      0, 1, 0,
                                      0, 0, 1]
end
}

@function["make-matrix"]

Constructs a matrix of the given size using only the given element.

@examples{
check:
  make-matrix(2, 3, 1) is [matrix(2,3): 1, 1, 1,
                                        1, 1, 1]
  make-matrix(3, 2, 5) is [matrix(3,2): 5, 5,
                                        5, 5,
                                        5, 5]
end
}

@function["zero-matrix"]

Constructs a matrix of the given size containing only zeroes.

@examples{
check:
  zero-matrix(2, 3) is [matrix(2,3): 0, 0, 0,
                                     0, 0, 0]
end
}


@function["build-matrix"]

Constructs a matrix of the given size, where entry @math{(i,j)} is the result of @pyret{proc(i,j)}.

@examples{
check:
  build-matrix(2, 3, lam(i,j): i + j end) is [matrix(3,2): 0, 1, 1, 2, 2, 3]
end
}

@section{Matrix Methods}

These methods are available on all matrices.

@matrix-method["get"]

Returns the matrix's entry in the @math{i^th} row and the @math{j^th} column.

@examples{
check:
  [matrix(3,2): 1, 2, 3, 4, 5, 6].get(1,1) is 4
  [matrix(3,2): 1, 2, 3, 4, 5, 6].get(2,0) is 5
  [matrix(1,1): 1].get(2, 0) raises "Index out of bounds for matrix dimensions"
end
}

@matrix-method["to-list"]

Returns the matrix as a list of numbers in row-major order.

For example, given the matrix @math-imtx{2 & 4 & 6 \\ 8 & 10 & 12 \\ 14 & 16 & 18}:

@examples{
check:
  [matrix(3,3): 2, 4, 6,
                8, 10, 12,
                14, 16, 18].to-list()
    is [list: 2, 4, 6, 8, 10, 12, 14, 16, 18]
end
}

@matrix-method["to-vector"]

Returns a one-row/one-column matrix as a vector.

@examples{
check:
  [matrix(2,1): 4, 5].to-vector() is [vector: 4, 5]
  [matrix(1,2): 4, 5].to-vector() is [matrix(2,1): 4, 5].to-vector()
  [matrix(2,2): 1, 2, 3, 4].to-vector()
    raises "Cannot convert non-vector matrix to vector"
end
}

@matrix-method["to-lists"]

Returns the matrix as a list of lists of numbers, with each list
corresponding to one row.

@examples{
check:
  [matrix(2,3): 1, 2, 3, 4, 5, 6].to-lists()
    is [list: [list: 1, 2, 3],
              [list: 4, 5, 6]]
end
}

@matrix-method["to-vectors"]

Returns the matrix as a list of lists of numbers (i.e. a list of
@pyret-id["Vector" "matrices"]s), 
with each list corresponding to one column.

For example, the matrix @math-imtx{1 & 2 & 3 \\ 4 & 5 & 6} corresponds to the
vectors @math-imtx{1 \\ 4}, @math-imtx{2 \\ 5}, and @math-imtx{3 \\ 6}: 

@examples{
check:
  [matrix(2,3): 1, 2, 3, 4, 5, 6].to-vectors()
    is [list: [vector: 1, 4],
              [vector: 2, 5],
              [vector: 3, 6]]
end
}

@matrix-method["row"]

Returns a one-row matrix with the matrix's given row.

@examples{
check:
  [matrix(2,3): 1, 2, 3, 4, 5, 6].row(2)
    is [matrix(1,3): 4, 5, 6]

  [matrix(3,3): 1, 2, 3, 4, 5, 6, 7, 8, 9].row(3)
    is [matrix(1,3): 7, 8, 9]
end
}

@matrix-method["col"]

Returns a one-column matrix with the matrix's given column.

@examples{
check:
  [matrix(2,3): 1, 2, 3, 4, 5, 6].col(2)
    is [matrix(2,1): 2, 5]

  [matrix(3,3): 1, 2, 3, 4, 5, 6, 7, 8, 9].col(3)
    is [matrix(3,1): 3, 6, 9]
end
}

@matrix-method["submatrix"]

Returns the submatrix of the matrix comprised of the intersection
of the given list of rows and the given list of columns.

For example, if our list of rows is @math-in{\{1, 2\}} and our
list of columns is @math-in{\{2, 3\}}, then the positions in the
resulting submatrix will be the elements with @math-in{(row,col)} positions
@math-in{\{(1, 2), (1, 3), (2, 2), (2, 3)\}}.

@math-in{
\left[\begin{matrix} 
            a_{11} & a_{12} & a_{13} \\
            a_{21} & a_{22} & a_{23} \\
            a_{31} & a_{32} & a_{33}
            \end{matrix}\right]}@pyret{.submatrix([list: 1, 2], [list: 2, 3])}
                                     @math-in{=
\left[\begin{matrix}
a_{12} & a_{13} \\
a_{22} & a_{23}\end{matrix}\right]}

This is shown in the below example:

@examples{
check:
  [matrix(3,3): 1, 2, 3, 4, 5, 6, 7, 8, 9].submatrix([list: 1, 2], [list: 2, 3])
    is [matrix(2,2): 2, 3, 4, 5]
end
}

@matrix-method["transpose"]

Returns the transposition of the matrix. For example,
@math-disp{\begin{bmatrix}1 & 2 & 3 \\ 4 & 5 & 6\end{bmatrix}
                 \overrightarrow{Transpose}
                 \begin{bmatrix}1 & 4 \\ 2 & 5 \\ 3 & 6\end{bmatrix}}

@examples{
check:
  [matrix(2,3): 1, 2, 3, 4, 5, 6].transpose()
    is [matrix(3,2): 1, 4, 2, 5, 3, 6]
end
}

@matrix-method["hermitian"]

Computes the conjugate-transpose of this matrix.  Since Pyret does not have
complex numbers, this is synonymous with @pyret-method["Matrix" "transpose"].

@matrix-method["diagonal"]

Returns a one-row matrix containing the matrix's diagonal entries.

@examples{
check:
  [matrix(3,3): 1, 2, 3, 4, 5, 6, 7, 8, 9].diagonal()
    is [matrix(1,3): 1, 5, 9]

  [matrix(3,2): 1, 2, 3, 4, 5, 6].diagonal()
    is [matrix(1,2): 1, 5]
end
}

@matrix-method["upper-triangle"]

Returns the @emph{upper triangle} of the matrix, if the matrix is square.  This
consists of all the values on or above the main diagonal, and zeroes below it.
For example, the upper triangle of @math-imtx{1 & 2 & 3\\ 4 & 5 & 6\\ 7 & 8 & 9}
would be @math-imtx{1 & 2 & 3\\ 0 & 5 & 6 \\ 0 & 0 & 9}.

@examples{
check:
  [matrix(2,2): 1, 2,
                3, 4].upper-triangle()
    is [matrix(2,2): 1, 2,
                     0, 4]

  [matrix(3,3): 1, 2, 3,
                4, 5, 6,
                7, 8, 9].upper-triangle()
    is [matrix(3,3): 1, 2, 3,
                     0, 5, 6,
                     0, 0, 9]
end
}

@matrix-method["lower-triangle"]

Returns the @emph{lower triangle} of the matrix, if the matrix is square.  This
consists of all the values on or below the main diagonal, and zeroes above it.
For example, the upper triangle of @math-imtx{1 & 2 & 3\\ 4 & 5 & 6\\ 7 & 8 & 9}
would be @math-imtx{1 & 0 & 0\\ 4 & 5 & 0\\ 7 & 8 & 9}.

@examples{
check:
  [matrix(2,2): 1, 2,
                3, 4].lower-triangle()
    is [matrix(2,2): 1, 0,
                     3, 4]

  [matrix(3,3): 1, 2, 3,
                4, 5, 6,
                7, 8, 9].lower-triangle()
    is [matrix(3,3): 1, 0, 0,
                     4, 5, 0,
                     7, 8, 9]
end
}

@matrix-method["row-list"]

Returns the matrix as a list of one-row matrices.
(Very similar to @pyret-method["Matrix" "to-lists"], except this method
returns a list of matrices instead.)

@examples{
check:
  [matrix(2,3): 1, 2, 3, 4, 5, 6].row-list()
    is [list: [matrix(1,3): 1, 2, 3],
              [matrix(1,3): 4, 5, 6]]
end
}

@matrix-method["col-list"]

Returns the matrix as a list of one-column matrices.
(Very similar to @pyret-method["Matrix" "to-vectors"], except this method
returns a list of matrices instead.)

@examples{
check:
  [matrix(2,3): 1, 2, 3, 4, 5, 6].col-list()
    is [list: [matrix(2,1): 1, 4],
              [matrix(2,1): 2, 5],
              [matrix(2,1): 3, 6]]
end
}

@matrix-method["map"]

Maps the given function entrywise over the matrix.

@examples{
check:
  multTwo = lam(x): x * 2 end
  [matrix(2,2): 1, 2, 3, 4].map(multTwo)
    is [matrix(2,2): 2, 4, 6, 8]
end
}

@matrix-method["map2"]
Maps the given function entrywise over corresponding elements of this and the
given matrix.

@examples{
check:
  m1 = [matrix(2,2): 10, 20, 30, 40]
  m2 = [matrix(2,2): 4, 3, 2, 1]
  m1.map2(m2, num-expt)
    is [matrix(2,2): num-expt(10, 4), num-expt(20, 3),
                     num-expt(30, 2), num-expt(40, 1)]
end
}

@matrix-method["row-map"]

Maps the given function over each row in the matrix.

@examples{
check:
  # sumRow :: 1*n matrix
  # Computes the total sum of all entries in the given row
  sumRow = lam(row): [matrix(1,1): row.to-vector().foldr(_ + _)] end
  [matrix(2,3): 1, 2, 3, 4, 5, 6].row-map(sumRow) is [matrix(2,1): 6, 15]
end
}

@matrix-method["col-map"]

Maps the given function over each column in the matrix.

@examples{
check:
  # sumCol :: m*1 matrix
  # Computes the total sum of all entries in the given column
  sumCol = lam(col): [matrix(1,1): col.to-vector().foldr(_ + _)] end
  [matrix(2,3): 1, 2, 3, 4, 5, 6].col-map(sumCol) is [matrix(1,3): 5, 7, 9]
end
}

@matrix-method["augment"]

Returns the matrix augmented with the given matrix. For
example, augmenting the matrix @math-imtx{1 & 2\\4 & 5} with
the matrix @math-imtx{3\\ 6} yields the matrix
@math-imtx{1 & 2 & 3\\ 4 & 5 & 6}.

@examples{
check:
  [matrix(2,2): 1, 2,
                4, 5].augment([matrix(2,1): 3,
                                            6])
    is [matrix(2,3): 1, 2, 3,
                     4, 5, 6]
end
}

@matrix-method["stack"]

Returns the matrix stacked on top of the given matrix. For
example, stacking the matrix @math-imtx{1 & 2 & 3} on top of
the matrix @math-imtx{4 & 5 & 6} gives the matrix
@math-imtx{1 & 2 & 3\\ 4 & 5 & 6}.

@examples{
check:
  [matrix(1,3): 1, 2, 3].stack([matrix(1,3): 4, 5, 6])
    is [matrix(2,3): 1, 2, 3,
                     4, 5, 6]
end
}

@matrix-method["trace"]

Returns the trace of the matrix (i.e. the sum of its diagonal values).

@examples{
check:
  [matrix(3,3): 1, 2, 3,
                4, 5, 6,
                7, 8, 9].trace() is (1 + 5 + 9)
  [matrix(2,2): 2, 4,
                6, 8].trace() is (2 + 8)
end
}

@matrix-method["scale"]

Multiplies each entry in the matrix by the given value.

@examples{
check:
  [matrix(2,2): 1, 2, 3, 4].scale(2) is [matrix(2,2): 2, 4, 6, 8]

  [matrix(2,2): 2, 4, 6, 8].scale(1/2) is [matrix(2,2): 1, 2, 3, 4]
end
}

@matrix-method["dot"]

Returns the Frobenius Product of the matrix with the given matrix (for
1-dimensional matrices, this is simply the dot product). This is done by
multiplying the matrix with the transposition of @pyret{other} and taking
the trace of the result. An example of this calculation (@math-in{\ast} 
denotes matrix multiplication):

@math-in{\left(\left[\begin{smallmatrix}1 & 2 & 3\end{smallmatrix}\right]
\ast\left[\begin{smallmatrix}4\\ 2\\ ^4/_3 \end{smallmatrix}\right]\right)}@pyret{.trace()}
@math-in{=
\underbrace{\left[\begin{smallmatrix}(1\cdot 4)+(2\cdot 2)+(3\cdot \frac{4}{3})\end{smallmatrix}\right]}_{
1\times 1 \text{ matrix}}}@pyret{.trace()}@math-in{=12}

@examples{
check:
  [matrix(1,3): 1, 2, 3].dot([matrix(1,3): 4, 2, 4/3]) is 12
  [matrix(1,3): 1, 2, 3].dot([matrix(1,3): 1, 1, 1]) is 6
end
}

@matrix-method["expt"]

Multiplies the matrix by itself the given number of times.

@examples{
check:
  a = [matrix(2,2): 1, 2, 3, 4]
  a.expt(1) is a
  a.expt(2) is a * a
  a.expt(3) is a * a * a
end
}

@matrix-method["determinant"]

Returns the determinant of the matrix, calculated via a recursive
implementation of Laplace expansion.

@examples{
check:
  [matrix(5,5): 1, 2, 1, 2, 3,
                2, 3, 1, 0, 1,
                2, 2, 1, 0, 0,
                1, 1, 1, 1, 1,
                0,-2, 0,-2,-2].determinant() is -2
end
}

@matrix-method["is-invertible"]

Returns true if the matrix is invertible, that is, it has a nonzero determinant.

@matrix-method["is-orthonormal"] Returns true if the matrix is
@hyperlink["https://en.wikipedia.org/wiki/Orthogonal_matrix"]{orthonormal},
meaning that all rows (when treated as vectors) each have
@pyret-method["Vector" "magnitude"] 1, are all distinct, and distinct rows
@pyret-method["Vector" "dot"] of zero.  Mathematically, this computes whether
@math-in{self * self^T} is the identity matrix.  Since numerical inaccuracy is
quite likely, this check is performed using @pyret-id["roughly-equal"
"equality"].

@matrix-method["rref"]

Returns the Reduced Row Echelon Form of the matrix. For example:
@math-disp{\begin{bmatrix}1 & 2 & 3 \\ 4 & 5 & 6\end{bmatrix}
                 \overrightarrow{RREF}
                 \begin{bmatrix}1 & 0 & -1\\ 0 & 1 & 2\end{bmatrix}}

@examples{
check:
  [matrix(2,3): 1, 2, 3, 4, 5, 6].rref() is [matrix(2,3): 1, 0,-1, 0, 1, 2]
end
}

@matrix-method["inverse"]

Returns the inverse of the matrix, if it is invertible (found
by augmenting the matrix with itself and finding the reduced-row
echelon form). For example:
@math-disp{\begin{bmatrix}1 & 0 & 4\\ 1 & 1 & 6\\ -3 & 0 & -10\end{bmatrix}^{-1}
                 = \begin{bmatrix}-5 & 0 & -2\\ -4 & 1 & -1\\ ^3/_2 & 0 & ^1/_2\end{bmatrix}}

@examples{
check:
  [matrix(3,3): 1, 0, 4, 1, 1, 6, -3, 0, -10].inverse()
    is [matrix(3,3): -5, 0, -2, -4, 1, -1, 3/2, 0, 1/2]
end
}

@matrix-method["solve"]

Returns the matrix which, when multiplied on the right of this matrix, results in the given matrix.
In other words, this returns the solution to the system of equations represented by this and the given matrix.
This method only works on invertible matrices (Calculated by inverting itself and multiplying the given
matrix on the right side of this inverse).

@matrix-method["least-squares-solve"]

Returns the least squares solution for this and the given matrix, calculated
using QR decomposition.

@matrix-method["lu-decomposition"] Computes the
@hyperlink["https://en.wikipedia.org/wiki/LU_decomposition"]{LU decomposition}
of this matrix, if possible.  This returns a pair of matrices, @pyret{L} and
@pyret{U}, that are respectively @seclink[(pyret-method-ref "Matrix"
"upper-triangle")]{lower-triangular} and @seclink[(pyret-method-ref "Matrix"
"upper-triangle")]{upper-triangular}, and whose product is this matrix:

@math-disp{
  \begin{bmatrix}
    a_{11} & a_{12} & a_{13} \\
    a_{21} & a_{22} & a_{23} \\
    a_{31} & a_{32} & a_{33}
  \end{bmatrix} =
  \begin{bmatrix}
    \ell_{11} &         0 & 0         \\
    \ell_{21} & \ell_{22} & 0         \\
    \ell_{31} & \ell_{32} & \ell_{33}
  \end{bmatrix}
  \begin{bmatrix}
    u_{11} & u_{12} & u_{13} \\
         0 & u_{22} & u_{23} \\
         0 &      0 & u_{33}
  \end{bmatrix}
}

@matrix-method["lp-norm"]

Computes the @math{L^p} norm of the matrix using the given number.

@matrix-method["l1-norm"]
@matrix-method["l2-norm"]
@matrix-method["l-inf-norm"]

Computes the @math{L^1}, @math{L^2}, and @math{L}@superscript{∞} norms of the matrix, respectively.

@examples{
check:
  a = [matrix(3,1): 1, 2, 3]
  b = [matrix(3,3): 1, 0, 0, 2, 0, 0, 3, 0, 0]

  a.lp-norm(3) is-roughly num-expt(35, 1/3)
  b.lp-norm(3) is-roughly (b * a).lp-norm(3)

  a.l1-norm()  is-roughly 6
  a.l2-norm()  is-roughly num-sqrt(14)
  a.l-inf-norm() is 3
end
}

@matrix-method["qr-decomposition"]

Returns the @hyperlink["https://en.wikipedia.org/wiki/QR_decomposition"]{QR
decomposition} of this matrix, if possible.  This returns a pair of matrices,
@pyret{Q} and @pyret{R}, where @pyret{Q} is @seclink[(pyret-method-ref "Matrix"
"is-orthonormal")]{orthogonal} and @pyret{R} is @seclink[(pyret-method-ref
"Matrix" "upper-triangle")]{upper-triangular}, whose product is this matrix.

@matrix-method["gram-schmidt"]

Returns an orthogonal matrix whose image is the same as the span of the matrix's columns.
(The same as the first result of @pyret-method["Matrix" "qr-decomposition"])

@section[#:tag "s:matrix-binary-ops"]{@pyret{Matrix} Binary Operations}

Matrices are defined to permit using addition, subtraction, and multiplication
operators on them, whenever the dimensions are compatible:

@examples{
check:
  [matrix(2,2): 1, 2, 3, 4] + [matrix(2,2): 1, 2, 3, 4]
    is [matrix(2,2): 2, 4, 6, 8]

  [matrix(2,2): 1, 2, 3, 4] + [matrix(4, 1): 1, 2, 3, 4]
    raises "different sized matrices"
end
}

@examples{
check:
  [matrix(2,2): 1, 2, 3, 4] - [matrix(2,2): 0, 2, 3, 3]
    is [matrix(2,2): 1, 0, 0, 1]

  [matrix(2,2): 1, 2, 3, 4] - [matrix(4, 1): 1, 2, 3, 4]
    raises "different sized matrices"
end
}

@examples{
check:
  [matrix(2,2): 1, 2, 3, 4] * [matrix(2,2): 3, 0, 0, 3]
    is [matrix(2,2): 3, 6, 9, 12]
end
}

@section{Matrix Functions}

The following functions are available to be performed on matrices.

@function["mtx-get"]

Returns the matrix's entry in the @math{i^th} row and the @math{j^th} column.
See @pyret-method["Matrix" "get"].

@function["mtx-to-list"]

Returns the matrix as a list of numbers in row-major order.  See
@pyret-method["Matrix" "to-list"].

@function["mtx-to-vector"]

Returns a one-row/one-column matrix as a vector.  See @pyret-method["Matrix" "to-vector"].

@function["mtx-to-lists"]

Returns the matrix as a list of lists of numbers, with each list
corresponding to one row.  See @pyret-method["Matrix" "to-lists"].

@function["mtx-to-vectors"]

Returns the matrix as a list of lists of numbers (i.e. a list of
@pyret-id["Vector" "matrices"]s), 
with each list corresponding to one column.  See @pyret-method["Matrix" "to-vectors"].

@function["mtx-row"]

Returns a one-row matrix with the matrix's given row.  See
@pyret-method["Matrix" "row"].

@function["mtx-col"]

Returns a one-column matrix with the matrix's given column.  See
@pyret-method["Matrix" "col"].

@function["mtx-submatrix"]

Returns the submatrix of the matrix comprised of the intersection
of the given list of rows and the given list of columns.  See
@pyret-method["Matrix" "submatrix"].

@function["mtx-transpose"]

See @pyret-method["Matrix" "transpose"].

@function["mtx-hermitian"]

See @pyret-method["Matrix" "hermitian"].

@function["mtx-diagonal"]

Returns a one-row matrix containing the matrix's diagonal entries.  See
@pyret-method["Matrix" "diagonal"].

@function["mtx-upper-triangle"]

Returns the @emph{upper triangle} of the matrix, if the matrix is square.  See
@pyret-method["Matrix" "upper-triangle"].

@function["mtx-lower-triangle"]

Returns the @emph{lower triangle} of the matrix, if the matrix is square.  See
@pyret-method["Matrix" "lower-triangle"].

@function["mtx-row-list"]

Returns the matrix as a list of one-row matrices.  See @pyret-method["Matrix" "row-list"].

@function["mtx-col-list"]

Returns the matrix as a list of one-column matrices.  See
@pyret-method["Matrix" "col-list"].

@function["mtx-map"]

Maps the given function entrywise over the matrix.  See @pyret-method["Matrix" "map"].

@function["mtx-map2"]

Maps the given function over the corresponding entries of the two given
matrices.  See @pyret-method["Matrix" "map2"].

@function["mtx-row-map"]

Maps the given function over each row in the matrix.  See
@pyret-method["Matrix" "row-map"].

@function["mtx-col-map"]

Maps the given function over each column in the matrix.  See
@pyret-method["Matrix" "col-map"].

@function["mtx-augment"]

Returns the first matrix augmented with the second matrix. See
@pyret-method["Matrix" "augment"].

@function["mtx-stack"]

Returns the first matrix stacked on top of the second matrix. See
@pyret-method["Matrix" "stack"].

@function["mtx-trace"]

Returns the trace of the matrix (i.e. the sum of its diagonal values).  See
@pyret-method["Matrix" "trace"].

@function["mtx-scale"]

Multiplies each entry in the matrix by the given value.  See
@pyret-method["Matrix" "scale"].

@function["mtx-dot"]

Returns the Frobenius Product of the two matrices.  See @pyret-method["Matrix"
"dot"].

@function["mtx-expt"]

Multiplies the matrix by itself the given number of times.  See
@pyret-method["Matrix" "expt"].

@function["mtx-determinant"]

Returns the determinant of the matrix.  See @pyret-method["Matrix"
"determinant"].

@function["mtx-is-invertible"]

Returns true if the matrix is invertible.  See @pyret-method["Matrix" "is-invertible"].

@function["mtx-is-orthonormal"]

Returns true if the matrix is orthonormal.  See @pyret-method["Matrix" "is-orthonormal"]. 

@function["mtx-rref"]

Returns the Reduced Row Echelon Form of the matrix. See @pyret-method["Matrix"
"rref"].

@function["mtx-inverse"]

Returns the inverse of the matrix, if it is invertible.  See
@pyret-method["Matrix" "inverse"].

@function["mtx-solve"]

Returns the matrix which, when multiplied on the right of the first matrix,
results in the second matrix.  See @pyret-method["Matrix" "solve"].

@function["mtx-least-squares-solve"]

Returns the least squares solution for the first and the second matrix, calculated
using QR decomposition.  See @pyret-method["Matrix" "least-squares-solve"].

@function["mtx-lp-norm"]

Computes the @math{L^p} norm of the matrix using the given number.  See
@pyret-method["Matrix" "lp-norm"].

@function["mtx-l1-norm"]
@function["mtx-l2-norm"]
@function["mtx-l-inf-norm"]

Computes the @math{L^1}, @math{L^2}, and @math{L}@superscript{∞} norms of the
matrix, respectively.  See @pyret-method["Matrix" "l1-norm"].

@function["mtx-qr-decomposition"]

See @pyret-method["Matrix" "qr-decomposition"].

@function["mtx-gram-schmidt"]

See @pyret-method["Matrix" "gram-schmidt"].

@function["mtx-add"]
@function["mtx-sub"]
@function["mtx-mult"]

Adds, subtracts, or multiplies the two matrices.  See @secref{s:matrix-binary-ops}.

@section{Matrix Conversion Functions}

@function["is-row-matrix"]
Returns whether the matrix has exactly one row:
@examples{
check:
  is-row-matrix([matrix(1, 3): 10, 20, 10]) is true
  is-row-matrix([matrix(3, 1): 10, 20, 10]) is false
end
}


@function["is-col-matrix"]
Returns whether the matrix has exactly one column:
@examples{
check:
  is-row-matrix([matrix(1, 3): 10, 20, 10]) is false
  is-row-matrix([matrix(3, 1): 10, 20, 10]) is true
end
}
@function["is-square-matrix"]{Returns true if the given matrix has the same number of rows and columns.}
@examples{
check:
  is-square-matrix([matrix(2, 2): 10, 20, 30, 40]) is true
  is-square-matrix([matrix(4, 1): 10, 20, 30, 40]) is false
end
}


@function[
  "vector-to-matrix"
  #:examples
  '@{
  check:
    vector-to-matrix([vector: 1, 2, 3]) is [matrix(1,3): 1, 2, 3]
  end
  }
]{Converts the given vector into a one-row matrix.}

@function[
  "list-to-matrix"
  #:examples
  '@{
  check:
    list-to-matrix(2, 2, [list: 1, 2, 3, 4])
      is [matrix(2,2): 1, 2, 3, 4]
    
    list-to-matrix(2, 3, [list: 1, 2, 3, 4, 5, 6])
      is [matrix(2,3): 1, 2, 3, 4, 5, 6]
  end
  }
]{Converts the given list of numbers into a matrix of the given size.}

@function[
  "list-to-row-matrix"
  #:examples
  '@{
  check:
    list-to-row-matrix([list: 1, 2, 3, 4]) is [matrix(1,4): 1, 2, 3, 4]
  end
  }
]{Converts the given list of numbers into a one-row matrix.}

@function[
  "list-to-col-matrix"
  #:examples
  '@{
  check:
    list-to-col-matrix([list: 1, 2, 3, 4]) is [matrix(4,1): 1, 2, 3, 4]
  end
  }
]{Converts the given list of numbers into a one-column matrix.}

@function[
  "lists-to-matrix"
  #:examples
  '@{
  check:
    lists-to-matrix([list: [list: 1, 2, 3, 4]]) is [matrix(1,4): 1, 2, 3, 4]
    lists-to-matrix([list: [list: 1, 2, 3],
                           [list: 4, 5, 6]]) is [matrix(2,3): 1, 2, 3, 4, 5, 6]
  end
  }
]{Converts the given list of lists into a matrix, with each list as a row.}

@function[
  "vectors-to-matrix"
  #:examples
  '@{
  check:
    vectors-to-matrix([list: [vector: 1, 2, 3]]) is [matrix(3,1): 1, 2, 3]
    vectors-to-matrix([list: [vector: 1, 3, 5], [vector: 2, 4, 6]])
      is [matrix(3,2): 1, 2, 3, 4, 5, 6]
  end
  }
]{Converts the given list of vectors into a matrix, with each vector as a column.}

@function["matrix-within"]{Returns a comparison predicate which returns true if each entry in both matrices is within @pyret{delta} of each other.}
  
}
