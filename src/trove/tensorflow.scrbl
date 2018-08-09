#lang scribble/manual
@(require "../../scribble-api.rkt" "../abbrevs.rkt")

@(define Tensor (a-id "Tensor" (xref "tensorflow" "Tensor")))
@(define TensorBuffer (a-id "TensorBuffer" (xref "tensorflow" "TensorBuffer")))
@(define Model (a-id "Model" (xref "tensorflow" "Model")))
@(define Sequential (a-id "Sequential" (xref "tensorflow" "Sequential")))
@(define SymbolicTensor (a-id "SymbolicTensor" (xref "tensorflow" "SymbolicTensor")))
@(define Layer (a-id "Layer" (xref "tensorflow" "Layer")))
@(define Optimizer (a-id "Optimizer" (xref "tensorflow" "Optimizer")))

@(define Object (a-id "Object" (xref "<global>" "Object")))
@(define Nothing (a-id "Nothing" (xref "<global>" "Nothing")))
@(define NumInteger (a-id "NumInteger" (xref "numbers" "NumInteger")))
@(define NumPositive (a-id "NumPositive" (xref "numbers" "NumPositive")))

@(define (tensor-method name)
  (method-doc "Tensor" #f name #:alt-docstrings ""))
@(define (tensor-buffer-method name)
  (method-doc "TensorBuffer" #f name #:alt-docstrings ""))
@(define (model-method name)
  (method-doc "Model" #f name #:alt-docstrings ""))
@(define (sequential-method name)
  (method-doc "Sequential" #f name #:alt-docstrings ""))
@(define (symbolic-tensor-method name)
  (method-doc "SymbolicTensor" #f name #:alt-docstrings ""))
@(define (layer-method name)
  (method-doc "Layer" #f name #:alt-docstrings ""))
@(define (optimizer-method name)
  (method-doc "Optimizer" #f name #:alt-docstrings ""))

@(append-gen-docs
  `(module "tensorflow"
    (path "src/arr/trove/tensorflow.arr")

    (fun-spec (name "tensor"))
    (fun-spec
      (name "is-tensor")
      (arity 1)
      (args ("val"))
      (return ,B)
      (contract
        (a-arrow ,A ,B)))
    (fun-spec
      (name "list-to-tensor")
      (arity 1)
      (args ("values"))
      (return ,Tensor)
      (contract
        (a-arrow ,(L-of N) ,Tensor)))
    (fun-spec
      (name "make-scalar")
      (arity 1)
      (args ("value"))
      (return ,Tensor)
      (contract
        (a-arrow ,N ,Tensor)))
    (fun-spec
      (name "fill")
      (arity 2)
      (args ("shape" "value"))
      (return ,Tensor)
      (contract
        (a-arrow ,(L-of NumInteger) ,N ,Tensor)))
    (fun-spec
      (name "linspace")
      (arity 3)
      (args ("start" "stop" "num-values"))
      (return ,Tensor)
      (contract
        (a-arrow ,N ,N, N ,Tensor)))
    (fun-spec
      (name "ones")
      (arity 1)
      (args ("shape"))
      (return ,Tensor)
      (contract
        (a-arrow ,(L-of NumInteger) ,Tensor)))
    (fun-spec
      (name "zeros")
      (arity 1)
      (args ("shape"))
      (return ,Tensor)
      (contract
        (a-arrow ,(L-of NumInteger) ,Tensor)))
    (fun-spec
      (name "multinomial")
      (arity 4)
      (args ("logits" "num-samples" "seed" "is-normalized"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,NumPositive ,(O-of N) ,B ,Tensor)))
    (fun-spec
      (name "random-normal")
      (arity 3)
      (args ("shape" "mean" "standard-deviation"))
      (return ,Tensor)
      (contract
        (a-arrow ,(L-of NumInteger) ,(O-of N) ,(O-of N) ,Tensor)))
    (fun-spec
      (name "random-uniform")
      (arity 3)
      (args ("shape" "min-val" "max-val"))
      (return ,Tensor)
      (contract
        (a-arrow ,(L-of NumInteger) ,(O-of N) ,(O-of N) ,Tensor)))
    (fun-spec
      (name "make-variable")
      (arity 1)
      (args ("initial-value"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))

    (data-spec
      (name "Tensor")
      (type-vars ())
      (variants ("tensor"))
      (shared
        ((method-spec
          (name "size")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,N)
          (contract
            (a-arrow ,Tensor ,N)))
        (method-spec
          (name "shape")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,(L-of N))
          (contract
            (a-arrow ,Tensor ,(L-of N))))
        (method-spec
          (name "flatten")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor)))
        (method-spec
          (name "as-scalar")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor)))
        (method-spec
          (name "as-1d")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor)))
        (method-spec
          (name "as-2d")
          (arity 3)
          (params ())
          (args ("self" "rows" "columns"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,NumInteger ,NumInteger ,Tensor)))
        (method-spec
          (name "as-3d")
          (arity 4)
          (params ())
          (args ("self" "rows" "columns" "depth"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,NumInteger ,NumInteger ,NumInteger ,Tensor)))
        (method-spec
          (name "as-4d")
          (arity 5)
          (params ())
          (args ("self" "rows" "columns" "depth1" "depth2"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,NumInteger ,NumInteger ,NumInteger ,NumInteger ,Tensor)))
        (method-spec
          (name "as-type")
          (arity 2)
          (params ())
          (args ("self" "data-type"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,S ,Tensor)))
        (method-spec
          (name "data-now")
          (arity 1)
          (params ())
          (args ("self" ))
          (return ,(L-of RN))
          (contract
            (a-arrow ,Tensor ,(L-of RN))))
        (method-spec
          (name "to-float")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor)))
        (method-spec
          (name "to-int")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor)))
        (method-spec
          (name "to-bool")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor)))
        (method-spec
          (name "to-buffer")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,TensorBuffer)
          (contract
            (a-arrow ,Tensor ,TensorBuffer)))
        (method-spec
          (name "to-variable")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor)))
        (method-spec
          (name "reshape")
          (arity 2)
          (params ())
          (args ("self" "new-shape"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,(L-of NumInteger) ,Tensor)))
        (method-spec
          (name "expand-dims")
          (arity 2)
          (params ())
          (args ("self" "axis"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,(O-of NumInteger) ,Tensor)))
        (method-spec
          (name "squeeze")
          (arity 2)
          (params ())
          (args ("self" "axes"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,(O-of (L-of NumInteger)) ,Tensor)))
        (method-spec
          (name "clone")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor)))
        (method-spec
          (name "add")
          (arity 2)
          (params ())
          (args ("self" "x"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor ,Tensor)))
        (method-spec
          (name "subtract")
          (arity 2)
          (params ())
          (args ("self" "x"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor ,Tensor)))
        (method-spec
          (name "multiply")
          (arity 2)
          (params ())
          (args ("self" "x"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor ,Tensor)))
        (method-spec
          (name "divide")
          (arity 2)
          (params ())
          (args ("self" "x"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor ,Tensor)))
        (method-spec
          (name "floor-divide")
          (arity 2)
          (params ())
          (args ("self" "x"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor ,Tensor)))
        (method-spec
          (name "max")
          (arity 2)
          (params ())
          (args ("self" "x"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor ,Tensor)))
        (method-spec
          (name "min")
          (arity 2)
          (params ())
          (args ("self" "x"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor ,Tensor)))
        (method-spec
          (name "modulo")
          (arity 2)
          (params ())
          (args ("self" "x"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor ,Tensor)))
        (method-spec
          (name "expt")
          (arity 2)
          (params ())
          (args ("self" "x"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor ,Tensor)))
        (method-spec
          (name "squared-difference")
          (arity 2)
          (params ())
          (args ("self" "x"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor ,Tensor))))))

    (fun-spec
      (name "make-buffer")
      (arity 1)
      (args ("shape"))
      (return ,TensorBuffer)
      (contract
        (a-arrow ,(L-of NumInteger) ,TensorBuffer)))
    (fun-spec
      (name "is-tensor-buffer")
      (arity 1)
      (args ("shape"))
      (return ,A)
      (contract
        (a-arrow ,A ,B)))

    (data-spec
      (name "TensorBuffer")
      (type-vars ())
      (variants)
      (shared
        ((method-spec
          (name "get-now")
          (arity 2)
          (params ())
          (args ("self" "indices"))
          (return ,N)
          (contract
            (a-arrow ,TensorBuffer ,(L-of NumInteger) ,N)))
        (method-spec
          (name "set-now")
          (arity 3)
          (params ())
          (args ("self" "value" "indices"))
          (return ,Nothing)
          (contract
            (a-arrow ,TensorBuffer ,N ,(L-of NumInteger) ,Nothing)))
        (method-spec
          (name "get-all-now")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,(L-of RN))
          (contract
            (a-arrow ,TensorBuffer ,(L-of RN))))
        (method-spec
          (name "to-tensor")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,Tensor)
          (contract
            (a-arrow ,TensorBuffer ,Tensor))))))


    (fun-spec
      (name "add-tensors")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "strict-add-tensors")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "subtract-tensors")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "strict-subtract-tensors")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "multiply-tensors")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "strict-multiply-tensors")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "divide-tensors")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "strict-divide-tensors")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "floor-divide-tensors")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-max")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "strict-tensor-max")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-min")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "strict-tensor-min")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-modulo")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "strict-tensor-modulo")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-expt")
      (arity 2)
      (args ("base" "exponent"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "strict-tensor-expt")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "squared-difference")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "strict-squared-difference")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))

    (fun-spec
      (name "tensor-abs")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-acos")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-acosh")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-asin")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-asinh")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-atan")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-atan2")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-atanh")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-ceil")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "clip-by-value")
      (arity 3)
      (args ("tensor" "min-value" "max-value"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,N, N ,Tensor)))
    (fun-spec
      (name "tensor-cos")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-cosh")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "exponential-linear-units")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "elu")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "gauss-error")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "erf")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-exp")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-exp-min1")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-floor")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "leaky-relu")
      (arity 2)
      (args ("tensor" "alpha"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,N ,Tensor)))
    (fun-spec
      (name "tensor-log")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-log-plus1")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "log-sigmoid")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-negate")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "parametric-relu")
      (arity 2)
      (args ("tensor" "alpha"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,N ,Tensor)))
    (fun-spec
      (name "tensor-reciprocal")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "relu")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-round")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "reciprocal-sqrt")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "scaled-elu")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "sigmoid")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "signed-ones")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-sin")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-sinh")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "softplus")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-sqrt")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-square")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "step")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-tan")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-tanh")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))

    (fun-spec
      (name "all")
      (arity 2)
      (args ("tensor" "axis"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,(O-of N) ,Tensor)))
    (fun-spec
      (name "any")
      (arity 2)
      (args ("tensor" "axis"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,(O-of N) ,Tensor)))
    (fun-spec
      (name "arg-max")
      (arity 2)
      (args ("tensor" "axis"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,(O-of N) ,Tensor)))
    (fun-spec
      (name "arg-min")
      (arity 2)
      (args ("tensor" "axis"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,(O-of N) ,Tensor)))
    (fun-spec
      (name "log-sum-exp")
      (arity 2)
      (args ("tensor" "axis"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,(O-of N) ,Tensor)))
    (fun-spec
      (name "reduce-max")
      (arity 2)
      (args ("tensor" "axis"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,(O-of N) ,Tensor)))
    (fun-spec
      (name "reduce-mean")
      (arity 2)
      (args ("tensor" "axis"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,(O-of N) ,Tensor)))
    (fun-spec
      (name "reduce-min")
      (arity 2)
      (args ("tensor" "axis"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,(O-of N) ,Tensor)))
    (fun-spec
      (name "reduce-sum")
      (arity 2)
      (args ("tensor" "axis"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,(O-of N) ,Tensor)))



    (fun-spec
      (name "concatenate")
      (arity 2)
      (args ("tensors" "axis"))
      (return ,Tensor)
      (contract
        (a-arrow ,(L-of Tensor) ,(O-of N) ,Tensor)))
    (fun-spec
      (name "gather")
      (arity 3)
      (args ("tensor" "indices" "axis"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,(O-of N) ,Tensor)))
    (fun-spec
      (name "reverse")
      (arity 2)
      (args ("tensor" "axes"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,(O-of (L-of N)) ,Tensor)))
    (fun-spec
      (name "slice")
      (arity 3 )
      (args ("tensor" "begin" "size"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,(L-of N) ,(O-of (L-of N)) ,Tensor)))
    (fun-spec
      (name "split")
      (arity 2)
      (args ("tensor" "axes"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,(O-of (L-of N)) ,Tensor)))
    (fun-spec
      (name "stack")
      (arity 2)
      (args ("tensor" "axes"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,(O-of (L-of N)) ,Tensor)))
    (fun-spec
      (name "tile")
      (arity 2)
      (args ("tensor" "axes"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,(O-of (L-of N)) ,Tensor)))
    (fun-spec
      (name "unstack")
      (arity 2)
      (args ("tensor" "axes"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,(O-of (L-of N)) ,Tensor)))
    (fun-spec
      (name "strided-slice")
      (arity 4)
      (args ("tensor" "begin" "end" "strides"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,(L-of N) ,(L-of N) ,(L-of N) ,Tensor)))

    (fun-spec
      (name "is-model")
      (arity 1)
      (args ("val"))
      (return ,B)
      (contract
        (a-arrow ,A ,B)))
    (fun-spec
      (name "make-model")
      (arity 1)
      (args ("config"))
      (return ,Model)
      (contract
        (a-arrow ,Object ,Model)))

    (data-spec
      (name "Model")
      (type-vars ())
      (variants)
      (shared
        ((method-spec
          (name "size")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,N)
          (contract
            (a-arrow ,Tensor ,N)))
            )))

    (fun-spec
      (name "is-sequential")
      (arity 1)
      (args ("val"))
      (return ,B)
      (contract
        (a-arrow ,A ,B)))
    (fun-spec
      (name "make-sequential")
      (arity 1)
      (args ("config"))
      (return ,Sequential)
      (contract
        (a-arrow ,Object ,Sequential)))

    (data-spec
      (name "Sequential")
      (type-vars ())
      (variants)
      (shared
        ((method-spec
          (name "add")
          (arity 2)
          (params ())
          (args ("self" "layer"))
          (return ,Nothing)
          (contract
            (a-arrow ,Sequential ,Layer ,Nothing)))
        (method-spec
          (name "compile")
          (arity 2)
          (params ())
          (args ("self" "config"))
          (return ,Nothing)
          (contract
            (a-arrow ,Sequential ,Object ,Nothing)))
        (method-spec
          (name "evaluate")
          (arity 4)
          (params ())
          (args ("self" "x" "y" "config"))
          (return ,Tensor)
          (contract
            (a-arrow ,Sequential ,Tensor ,Tensor ,Object ,Tensor)))
        (method-spec
          (name "predict")
          (arity 3)
          (params ())
          (args ("self" "x" "config"))
          (return ,Tensor)
          (contract
            (a-arrow ,Sequential ,Tensor ,Object ,Tensor)))
        (method-spec
          (name "predict-on-batch")
          (arity 2)
          (params ())
          (args ("self" "x"))
          (return ,Tensor)
          (contract
            (a-arrow ,Sequential ,Tensor ,Tensor)))
        (method-spec
          (name "fit")
          (arity 5)
          (params ())
          (args ("self" "x" "y" "config" "epoch-callback"))
          (return ,Nothing)
          (contract
            (a-arrow ,Sequential ,Tensor ,Tensor ,Object (a-arrow ,N ,Object ,Nothing) ,Nothing)))
            )))

    (fun-spec
      (name "make-input")
      (arity 1)
      (args ("shape"))
      (return ,SymbolicTensor)
      (contract
        (a-arrow ,(L-of (O-of N)) ,SymbolicTensor)))
    (fun-spec
      (name "make-batch-input")
      (arity 1)
      (args ("batch-shape"))
      (return ,SymbolicTensor)
      (contract
        (a-arrow ,(L-of (O-of N)) ,SymbolicTensor)))

    (data-spec
      (name "SymbolicTensor")
      (type-vars ())
      (variants)
      (shared
        ((method-spec
          (name "shape")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,(L-of (O-of N)))
          (contract
            (a-arrow ,SymbolicTensor ,(L-of (O-of N))))))))

    (fun-spec
      (name "is-layer")
      (arity 1)
      (args ("val"))
      (return ,B)
      (contract
        (a-arrow ,A ,B)))
    (fun-spec
      (name "activation-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "dense-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "dropout-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "embedding-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "flatten-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "repeat-vector-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "reshape-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "conv-1d-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "conv-2d-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "conv-2d-transpose-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "cropping-2d-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "depthwise-conv-2d-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "separable-conv-2d-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "up-sampling-2d-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "add-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "average-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "concatenate-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "maximum-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "minimum-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "multiply-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "batch-normalization-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "average-pooling-1d-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "average-pooling-2d-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "global-average-pooling-1d-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "global-average-pooling-2d-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "global-max-pooling-1d-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "global-max-pooling-2d-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "max-pooling-1d-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "max-pooling-2d-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "gru-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "gru-cell-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "lstm-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "lstm-cell-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "rnn-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "simple-rnn-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "simple-rnn-cell-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "stacked-rnn-cells-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "bidirectional-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))
    (fun-spec
      (name "time-distributed-layer")
      (arity 1)
      (args ("config"))
      (return ,Layer)
      (contract
        (a-arrow ,Object ,Layer)))

    (data-spec
      (name "Layer")
      (type-vars ())
      (variants)
      (shared
        ((method-spec
          (name "size")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,N)
          (contract
            (a-arrow ,Tensor ,N)))
            )))

    (fun-spec
      (name "is-optimizer")
      (arity 1)
      (args ("val"))
      (return ,B)
      (contract
        (a-arrow ,A ,B)))
    (fun-spec
      (name "train-sgd")
      (arity 1)
      (args ("learning-rate"))
      (return ,Optimizer)
      (contract
        (a-arrow ,N ,Optimizer)))
    (fun-spec
      (name "train-momentum")
      (arity 2)
      (args ("learning-rate" "momentum"))
      (return ,Optimizer)
      (contract
        (a-arrow ,N ,N ,Optimizer)))
    (fun-spec
      (name "train-adagrad")
      (arity 2)
      (args ("learning-rate" "initial-accumulator"))
      (return ,Optimizer)
      (contract
        (a-arrow
          ,N
          ,(O-of (a-id "NumPositive" (xref "numbers" "NumPositive")))
          ,Optimizer)))
    (fun-spec
      (name "train-adadelta")
      (arity 3)
      (args ("learning-rate" "rho" "epsilon"))
      (return ,Optimizer)
      (contract
        (a-arrow ,(O-of N) ,(O-of N) ,(O-of N) ,Optimizer)))
    (fun-spec
      (name "train-adam")
      (arity 4)
      (args ("learning-rate" "beta-1" "beta-2" "epsilon"))
      (return ,Optimizer)
      (contract
        (a-arrow ,(O-of N) ,(O-of N) ,(O-of N) ,(O-of N) ,Optimizer)))
    (fun-spec
      (name "train-adamax")
      (arity 5)
      (args ("learning-rate" "beta-1" "beta-2" "epsilon" "decay"))
      (return ,Optimizer)
      (contract
        (a-arrow ,(O-of N) ,(O-of N) ,(O-of N) ,(O-of N) ,(O-of N) ,Optimizer)))
    (fun-spec
      (name "train-rmsprop")
      (arity 5)
      (args ("learning-rate" "decay" "momentum" "epsilon" "is-centered"))
      (return ,Optimizer)
      (contract
        (a-arrow ,N ,(O-of N) ,(O-of N) ,(O-of N) ,B ,Optimizer)))

    (data-spec
      (name "Optimizer")
      (type-vars ())
      (variants)
      (shared
        ((method-spec
          (name "minimize")
          (arity 3)
          (params ())
          (args ("self" "f", "variables"))
          (return ,Tensor)
          (contract
            (a-arrow ,Optimizer (a-arrow "" ,Tensor) ,(L-of Tensor) ,Tensor)))
            )))
   ))

@docmodule["tensorflow"]{
  A module that provides a Pyret interface for TensorFlow, a
  symbolic math library for machine learning applications.

  @(table-of-contents)

  @;#########################################################################
  @section{Tensors}

  @type-spec["Tensor"]{

    @pyret{Tensor}s are the core datastructure for @pyret{tensorflow}
    applications. They are a generalization of vectors and matrices that
    allows for higher dimensions.

    For example, a tensor could be a one-dimensional matrix (a vector), a
    three-dimensional matrix (a cube), a zero-dimensional matrix (a single
    number), or a higher dimensional structure that is more difficult to
    visualize.

    @margin-note{
      @pyret{Tensor}s actually store values in a form slightly less precise
      than @pyret{Roughnum}s. The reason for this is that TensorFlow.js (the
      library that Pyret @pyret{Tensor}s are built on) stores tensor values in
      JavaScript @tt{Float32Array}s for performance reasons. (But this
      shouldn't substantially affect program results in most cases.)
    }

    For performance reasons, @pyret{Tensor}s do not support arbitrary
    precision. Retrieving values from a @pyret{Tensor} using
    @pyret-method["Tensor" "data-now"] always returns a
    @pyret{List<Roughnum>}.

    Since @pyret{Tensor}s are immutable, all operations always return new
    @pyret{Tensor}s and never modify the input @pyret{Tensor}s. The exception
    to this is when a @pyret{Tensor} is transformed into a mutable
    @pyret{Tensor} using the @pyret-id["make-variable"] function or the
    @pyret-method["Tensor" "to-variable"] method. These "variable tensors"
    can be modified by @pyret{Optimizer}s.

  }

  @;#########################################################################
  @subsection{Tensor Constructors}

  @collection-doc["tensor" #:contract `(a-arrow ("value" ,N) ,Tensor)]

  Creates a new @pyret{Tensor} with the given @pyret{value}s.

  Every @pyret{Tensor} created with this constructor is one-dimensional. Use
  @pyret-method["Tensor" "as-1d"], @pyret-method["Tensor" "as-2d"],
  @pyret-method["Tensor" "as-3d"], @pyret-method["Tensor" "as-4d"], or
  @pyret-method["Tensor" "reshape"] to change the shape of a @pyret{Tensor}
  after instantiating it.

  @examples{
    [tensor: 1, 2, 3] # a size-3 tensor
    [tensor: 1.4, 5.2, 0.4, 12.4, 14.3, 6].as-2d(3, 2) # a 3 x 2 tensor
    [tensor: 9, 4, 0, -32, 23, 1, 3, 2].as-3d(2, 2, 2) # a 2 x 2 x 2 tensor
  }

  @function["is-tensor"]

  Returns @pyret{true} if @pyret{val} is a @pyret{Tensor}; otherwise, returns
  @pyret{false}.

  @examples{
    check:
      is-tensor([tensor: 1, 2, 3]) is true
      is-tensor(true) is false
      is-tensor(0) is false
      is-tensor([list: 1, 2, 3]) is false
    end
  }

  @function["list-to-tensor"]

  Creates a new @pyret{Tensor} with the values in the input @pyret{List}.

  Similar to the @pyret-id["tensor"] constructor, all @pyret{Tensor}s created
  using @pyret-id["list-to-tensor"] are one-dimensional by default. Use
  @pyret-method["Tensor" "as-1d"], @pyret-method["Tensor" "as-2d"],
  @pyret-method["Tensor" "as-3d"], @pyret-method["Tensor" "as-4d"], or
  @pyret-method["Tensor" "reshape"] to change the shape of a @pyret{Tensor}
  after instantiating it.

  @examples{
    check:
      list-to-tensor(empty) satisfies is-tensor
      list-to-tensor([list: 5, 3, 4, 7]) satisfies is-tensor

      list-to-tensor(empty).data-now() is empty
      list-to-tensor([list: 9, 3, 2, 3]).data-now() is-roughly [list: 9, 3, 2, 3]
      list-to-tensor([list: 3, 2, 1, 0, 4, 9]).as-2d(2, 3).shape() is [list: 2, 3]
    end
  }

  @function["make-scalar"]

  Creates a new @pyret{Tensor} of rank-0 with the given @pyret{value}.

  The same functionality can be achieved with the @pyret-id["tensor"]
  constructor and the @pyret-method["Tensor" "as-scalar"] method, but it's
  recommended to use @pyret-id["make-scalar"] as it makes the code more
  readable.

  @examples{
    check:
      make-scalar(1).size() is 1
      make-scalar(~12.3).shape() is empty
      make-scalar(2.34).data-now() is-roughly [list: 2.34]
    end
  }

  @function["fill"]

  Creates a @pyret{Tensor} with the input @pyret{shape} where all of the
  entries are @pyret{value}.

  @examples{
    check:
      fill([list: 0], 1).data-now()
        is-roughly [list: ]
      fill([list: 3], 5).data-now()
        is-roughly [list: 5, 5, 5]
      fill([list: 3, 2], -3).data-now()
        is-roughly [list: -3, -3, -3, -3, -3, -3]
    end
  }

  @function["linspace"]

  Returns a @pyret{Tensor} whose values are an evenly spaced sequence of
  numbers over the range @pyret{[start, stop]}. @pyret{num-values} is the
  number of entries in the output @pyret{Tensor}.

  @examples{
    check:
      linspace(0, 3, 1).data-now()
        is-roughly [list: 0]
      linspace(10, 11, 1).data-now()
        is-roughly [list: 10]
      linspace(5, 1, 5).data-now()
        is-roughly [list: 5, 4, 3, 2, 1]
      linspace(0, 9, 10).data-now()
        is-roughly [list: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
      linspace(0, 4, 9).data-now()
        is-roughly [list: 0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4]
    end
  }

  @function["ones"]

  Returns a @pyret{Tensor} with the given @pyret{shape} where all of the
  entries are ones.

  @examples{
    check:
      ones([list: 0]).data-now() is-roughly [list: ]
      ones([list: 4]).data-now() is-roughly [list: 1, 1, 1, 1]
      two-dim = ones([list: 3, 2])
      two-dim.shape() is [list: 3, 2]
      two-dim.data-now() is-roughly [list: 1, 1, 1, 1, 1, 1]
    end
  }

  @function["zeros"]

  Returns a @pyret{Tensor} with the given @pyret{shape} where all of the
  entries are zeros.

  @examples{
    check:
      zeros([list: 0]).data-now() is-roughly [list: ]
      zeros([list: 4]).data-now() is-roughly [list: 0, 0, 0, 0]
      two-dim = zeros([list: 3, 2])
      two-dim.shape() is [list: 3, 2]
      two-dim.data-now() is-roughly [list: 0, 0, 0, 0, 0, 0]
    end
  }

  @function["multinomial"]

  Creates a new @pyret{Tensor} where all of the values are sampled from a
  multinomial distribution.

  @pyret{logits} should be a @pyret{Tensor} representing a one-dimensional
  array containing with unnormalized log-probabilities, or a two-dimensional
  array of structure @pyret{[batch-size, num-outcomes]}.

  @pyret{num-samples} is the number of samples to draw for each row slice.
  @pyret{seed} represents the random seed to use when generating values; if
  @pyret{none}, the seed is randomly generated. @pyret{normalized} designates
  whether or not the provided logits are normalized true probabilities (i.e:
  they sum to 1).

  @examples{
    check:
      three-dim = [tensor: 1, 1, 1, 1, 1, 1, 1, 1].as-3d(2, 2, 2)
      multinomial(three-dim, 2, none, false)
        raises "must be a one-dimensional or two-dimensional Tensor"

      multinomial([tensor: ], 1, none, false)
        raises "must have at least two possible outcomes"
      multinomial([tensor: 0.8], 7, none, false)
        raises "must have at least two possible outcomes"

      multinomial([tensor: 1.0, 0.0], 1, none, true).shape() is [list: 1]
      multinomial([tensor: 1.0, 0.0], 3, none, true).shape() is [list: 3]
      multinomial([tensor: 0.3, 0.5, 0.7], 10, none, false).shape() is [list: 10]
    end
  }

  @function["random-normal"]

  Creates a new @pyret{Tensor} with the given shape (represented as values in
  the input @pyret{List<Number> shape}) where all of the values are sampled
  from a normal distribution.

  @pyret{mean} is the mean of the normal distribution and
  @pyret{standard-deviation} is the standard deviation of the normal
  distribution. If @pyret{none}, the respective parameters are set to the
  TensorFlow.js defaults.

  @examples{
    check:
      random-normal(empty, none, none).size() is 1
      random-normal(empty, none, none).shape() is empty
      random-normal([list: 4, 3], none, none).shape() is [list: 4, 3]
      random-normal([list: 2, 5, 3], none, none).shape() is [list: 2, 5, 3]
    end
  }

  @function["random-uniform"]

  Creates a new @pyret{Tensor} with the given shape (represented as values in
  the input @pyret{List}) where all of the values are sampled from a uniform
  distribution.

  @pyret{min-val} is the lower bound on the range of random values to generate
  and @pyret{max-val} is the upper bound on the range of random values to
  generate. If @pyret{none}, the respective parameters are set to the
  TensorFlow.js defaults.

  @examples{
    check:
      random-uniform(empty, none, none).size() is 1
      random-uniform(empty, none, none).shape() is empty
      random-uniform([list: 1, 3], none, none).shape() is [list: 1, 3]
      random-uniform([list: 5, 4, 8], none, none).shape() is [list: 5, 4, 8]

      lower-bound = 1
      upper-bound = 10
      random-data = random-uniform([list: 20], some(lower-bound), some(upper-bound))
      for each(data-point from random-data.data-now()):
        data-point satisfies lam(x): (x >= lower-bound) and (x <= upper-bound) end
      end
    end
  }

  @function["make-variable"]

  Creates a new, mutable @pyret{Tensor} initialized to the values of the input
  @pyret{Tensor}.

  The same functionality can be achieved with the
  @pyret-method["Tensor" "to-variable"] method.

  @examples{
    check:
      make-variable([tensor: ]).data-now() is-roughly empty
      make-variable([tensor: 1]).data-now() is-roughly [list: 1]

      # We can perform normal Tensor operations on mutable Tensors:
      two-dim = [tensor: 4, 5, 3, 9].as-2d(2, 2)
      make-variable(two-dim).size() is 4
      make-variable(two-dim).shape() is [list: 2, 2]
      make-variable(two-dim).data-now() is-roughly [list: 4, 5, 3, 9]
      make-variable(two-dim).as-3d(4, 1, 1).shape() is [list: 4, 1, 1]
    end
  }

  @;#########################################################################
  @subsection{Tensor Methods}

  @tensor-method["size"]

  Returns the size of the @pyret{Tensor} (the number of values stored in the
  @pyret{Tensor}).

  @examples{
    check:
      make-scalar(4.21).size() is 1
      [tensor: 6.32].size() is 1
      [tensor: 1, 2, 3].size() is 3
      [tensor: 1.4, 5.2, 0.4, 12.4, 14.3, 6].as-2d(3, 2).size() is 6
    end
  }

  @tensor-method["shape"]

  Returns a @pyret{List<Number>} representing the shape of the @pyret{Tensor}.
  Each element in the @pyret{List<Number>} corresponds to the size in each
  dimension.

  @examples{
    check:
      make-scalar(3).shape() is empty
      [tensor: 9].shape() is [list: 1]
      [tensor: 8, 3, 1].shape() is [list: 3]
      [tensor: 0, 0, 0, 0, 0, 0].as-2d(3, 2).shape() is [list: 3, 2]
    end
  }

  @tensor-method["flatten"]

  Constructs a new, one-dimensional @pyret{Tensor} from the values of the
  original @pyret{Tensor}.

  @examples{
    check:
      a = [tensor: 1, 2, 3, 4, 5, 6].as-2d(3, 2)
      a.shape() is [list: 3, 2]
      a.flatten().shape() is [list: 6]

      b = make-scalar(12)
      b.shape() is empty
      b.flatten().shape() is [list: 1]
    end
  }

  @tensor-method["as-scalar"]

  Constructs a new, zero-dimensional @pyret{Tensor} from the values of the
  original, size-1 @pyret{Tensor}.

  Raises an error if the calling @pyret{Tensor} is not size-1.

  @examples{
    check:
      size-one = [tensor: 1]
      size-one.as-scalar().shape() is empty
      size-one.shape() is [list: 1] # doesn't modify shape of original tensor

      size-two = [tensor: 1, 2]
      size-two.as-scalar() raises
        "Tensor was size-2 but `as-scalar` requires the tensor to be size-1"
    end
  }

  @tensor-method["as-1d"]

  Constructs a new, rank-1 @pyret{Tensor} from the values of the original
  @pyret{Tensor}.

  The same functionality can be achieved with @pyret-method["Tensor" "reshape"],
  but it's recommended to use @pyret-method["Tensor" "as-1d"] as it makes the
  code more readable.

  @examples{
    check:
      one-dim = [tensor: 1]
      two-dim = [tensor: 4, 3, 2, 1].as-2d(2, 2)
      three-dim = [tensor: 0, 1, 2, 3, 4, 5, 6, 7, 8].as-3d(3, 1, 3)

      one-dim.shape() is [list: 1]
      one-dim.as-1d().shape() is [list: 1]

      two-dim.shape() is [list: 2, 2]
      two-dim.as-1d().shape() is [list: 4]

      three-dim.shape() is [list: 3, 1, 3]
      three-dim.as-1d().shape() is [list: 9]
    end
  }

  @tensor-method["as-2d"]

  Constructs a new, rank-2 @pyret{Tensor} with the input dimensions from the
  values of the original @pyret{Tensor}.

  The number of elements implied by the input dimensions must be the same as the
  number of elements in the calling @pyret{Tensor}. Otherwise, the method
  raises an error.

  The same functionality can be achieved with @pyret-method["Tensor" "reshape"],
  but it's recommended to use @pyret-method["Tensor" "as-2d"] as it makes the
  code more readable.

  @examples{
    check:
      one-dim = [tensor: 1]
      two-dim = [tensor: 0, 1, 2, 3, 4, 5].as-2d(3, 2)
      three-dim = [tensor: 4, 3, 2, 1, 0, -1, -2, -3].as-3d(2, 2, 2)

      one-dim.shape() is [list: 1]
      one-dim.as-2d(1, 1).shape() is [list: 1, 1]

      two-dim.shape() is [list: 3, 2]
      two-dim.as-2d(2, 3).shape() is [list: 2, 3]

      three-dim.shape() is [list: 2, 2, 2]
      three-dim.as-2d(4, 2).shape() is [list: 4, 2]

      one-dim.as-2d(2, 1) raises "Cannot reshape"
      two-dim.as-2d(3, 3) raises "Cannot reshape"
      three-dim.as-2d(5, 4) raises "Cannot reshape"
    end
  }

  @tensor-method["as-3d"]

  Constructs a new, rank-3 @pyret{Tensor} with the input dimensions from the
  values of the original @pyret{Tensor}.

  The number of elements implied by the input dimensions must be the same as the
  number of elements in the calling @pyret{Tensor}. Otherwise, the method
  raises an error.

  The same functionality can be achieved with @pyret-method["Tensor" "reshape"],
  but it's recommended to use @pyret-method["Tensor" "as-3d"] as it makes the
  code more readable.

  @examples{
    check:
      one-dim = [tensor: 1]
      two-dim = [tensor: 0, 1, 2, 3, 4, 5, 6, 7].as-2d(4, 2)

      one-dim.shape() is [list: 1]
      one-dim.as-3d(1, 1, 1).shape() is [list: 1, 1, 1]

      two-dim.shape() is [list: 4, 2]
      two-dim.as-3d(2, 2, 2).shape() is [list: 2, 2, 2]

      one-dim.as-3d(2, 1, 1) raises "Cannot reshape"
      two-dim.as-3d(4, 3, 2) raises "Cannot reshape"
    end
  }

  @tensor-method["as-4d"]

  Constructs a new, rank-4 @pyret{Tensor} with the input dimensions from the
  values of the original @pyret{Tensor}.

  The number of elements implied by the input dimensions must be the same as the
  number of elements in the calling @pyret{Tensor}. Otherwise, the method
  raises an error.

  The same functionality can be achieved with @pyret-method["Tensor" "reshape"],
  but it's recommended to use @pyret-method["Tensor" "as-4d"] as it makes the
  code more readable.

  @examples{
    check:
      one-dim = [tensor: 1]
      two-dim = [tensor: 0, 1, 2, 3, 4, 5, 6, 7].as-2d(4, 2)

      one-dim.shape() is [list: 1]
      one-dim.as-4d(1, 1, 1, 1).shape() is [list: 1, 1, 1, 1]

      two-dim.shape() is [list: 4, 2]
      two-dim.as-4d(2, 2, 1, 2).shape() is [list: 2, 2, 1, 2]

      one-dim.as-4d(2, 1, 1, 1) raises "Cannot reshape"
      two-dim.as-4d(2, 2, 2, 2) raises "Cannot reshape"
    end
  }

  @tensor-method["as-type"]

  Constructs a new @pyret{Tensor} from the values of the original
  @pyret{Tensor} with all of the values cast to the input datatype.

  The possible @pyret{data-type}s are @pyret{"float32"}, @pyret{"int32"}, or
  @pyret{"bool"}. Any other @pyret{dataType} will raise an error.

  @examples{
    check:
      some-tensor = [tensor: 1, 3, 5, 8]

      some-tensor.as-type("float32") does-not-raise
      some-tensor.as-type("int32") does-not-raise
      some-tensor.as-type("bool") does-not-raise
      some-tensor.as-type("invalid")
        raises "Attempted to cast tensor to invalid type"
    end
  }

  @tensor-method["data-now"]

  Returns a @pyret{List} containing the data in the @pyret{Tensor}.

  @examples{
    check:
      [tensor: ].data-now() is-roughly [list: ]
      [tensor: 1].data-now() is-roughly [list: 1]
      [tensor: 1.43].data-now() is-roughly [list: 1.43]
      [tensor: -3.21, 9.4, 0.32].data-now() is-roughly [list: -3.21, 9.4, 0.32]
    end
  }

  @tensor-method["to-float"]

  Constructs a new @pyret{Tensor} from the values of the original
  @pyret{Tensor} with all of the values cast to the @tt{"float32"} datatype.

  @examples{
    check:
      [tensor: 0].to-float().data-now() is-roughly [list: 0]
      [tensor: 1].to-float().data-now() is-roughly [list: 1]
      [tensor: 0.42].to-float().data-now() is-roughly [list: 0.42]
      [tensor: 4, 0.32, 9.40, 8].to-float().data-now()
        is-roughly [list: 4, 0.32, 9.40, 8]
    end
  }

  @tensor-method["to-int"]

  Constructs a new @pyret{Tensor} from the values of the original
  @pyret{Tensor} with all of the values cast to the @tt{"int32"} datatype.

  @examples{
    check:
      [tensor: 0].to-int().data-now() is-roughly [list: 0]
      [tensor: 1].to-int().data-now() is-roughly [list: 1]
      [tensor: 0.999999].to-int().data-now() is-roughly [list: 0]
      [tensor: 1.52, 4.12, 5.99].to-int().data-now()
        is-roughly [list: 1, 4, 5]
    end
  }

  @tensor-method["to-bool"]

  Constructs a new @pyret{Tensor} from the values of the original
  @pyret{Tensor} with all of the values cast to the @tt{"bool"} datatype.

  @examples{
    check:
      [tensor: 0].to-bool().data-now() is-roughly [list: 0]
      [tensor: 1].to-bool().data-now() is-roughly [list: 1]
      [tensor: 0.42].tox-bool().data-now() is-roughly [list: 1]
      [tensor: 1, 4, 5].to-bool().data-now() is-roughly [list: 1, 1, 1]
    end
  }

  @tensor-method["to-buffer"]

  Constructs a new @pyret-id["TensorBuffer"] from the values of the original
  @pyret{Tensor}.

  @examples{
    check:
      empty-buffer = [tensor: ].to-buffer()
      empty-buffer satisfies is-tensor-buffer
      empty-buffer.get-all-now() is-roughly [list: ]

      some-shape  = [list: 2, 2]
      some-values = [list: 4, 5, 9, 3]
      some-tensor = list-to-tensor(some-values).reshape(some-shape)
      some-buffer = some-tensor.to-buffer()
      some-buffer satisfies is-tensor-buffer
      some-buffer.get-all-now() is-roughly some-values
      some-buffer.to-tensor().shape() is some-shape
    end
  }

  @tensor-method["to-variable"]

  Constructs a new, mutable @pyret{Tensor} from the values of the original
  @pyret{Tensor}. Equivalent to applying @pyret-id["make-variable"] on the
  calling @pyret{Tensor}.

  @examples{
    check:
      [tensor: ].to-variable() does-not-raise
      [tensor: 4, 5, 1].to-variable() does-not-raise
      [tensor: 0, 5, 1, 9, 8, 4].as-2d(3, 2).to-variable() does-not-raise
    end
  }

  @tensor-method["reshape"]

  Constructs a new @pyret{Tensor} with the input dimensions @pyret{new-shape}
  from the values of the original @pyret{Tensor}.

  The number of elements implied by @pyret{new-shape} must be the same as the
  number of elements in the calling @pyret{Tensor}. Otherwise, the method
  raises an error.

  When reshaping a @pyret{Tensor} to be 0-, 1-, 2-, 3-, or 4-dimensional,
  it's recommended to use @pyret-method["Tensor" "as-scalar"],
  @pyret-method["Tensor" "as-1d"], @pyret-method["Tensor" "as-2d"],
  @pyret-method["Tensor" "as-3d"], or @pyret-method["Tensor" "as-4d"] as
  they make the code more readable.

  @examples{
    check:
      [tensor: ].reshape([list: ]) raises "Cannot reshape"
      [tensor: 3, 2].reshape([list: ]) raises "Cannot reshape"
      [tensor: 3, 2].reshape([list: 6]) raises "Cannot reshape"
      [tensor: 3, 2, 1].reshape([list: 2, 4]) raises "Cannot reshape"

      [tensor: 1].reshape([list: 1]).shape() is [list: 1]
      [tensor: 1].reshape([list: 1, 1, 1]).shape() is [list: 1, 1, 1]
      [tensor: 1].reshape([list: 1, 1, 1, 1, 1]).shape() is [list: 1, 1, 1, 1, 1]
      [tensor: 1, 4].reshape([list: 2, 1]).shape() is [list: 2, 1]
      [tensor: 1, 4, 4, 5, 9, 3].reshape([list: 3, 2]).shape() is [list: 3, 2]
    end
  }

  @tensor-method["expand-dims"]

  Returns a @pyret{Tensor} that has expanded rank, by inserting a dimension
  into the @pyret{Tensor}'s shape at the given dimension index @pyret{axis}.
  If @pyret{axis} is @pyret{none}, the method inserts a dimension at index 0
  by default.

  @examples{
    check:
      one-dim = [tensor: 1, 2, 3, 4]
      one-dim.shape() is [list: 4]
      one-dim.expand-dims(none).shape() is [list: 1, 4]
      one-dim.expand-dims(some(1)).shape() is [list: 4, 1]

      one-dim.expand-dims(some(2))
        raises "input axis must be less than or equal to the rank of the tensor"
    end
  }

  @tensor-method["squeeze"]

  Returns a @pyret{Tensor} with dimensions of size 1 removed from the shape.

  If @pyret{axis} is not @pyret{none}, the method only squeezes the dimensions
  listed as indices in @pyret{axis}. The method will raise an error if one of
  the dimensions specified in @pyret{axis} is not of size 1.

  @examples{
    check:
      multi-dim = [tensor: 1, 2, 3, 4].reshape([list: 1, 1, 1, 4, 1])
      multi-dim.shape() is [list: 1, 1, 1, 4, 1]
      multi-dim.squeeze(none).shape() is [list: 4]
      multi-dim.squeeze(some([list: 0])).shape() is [list: 1, 1, 4, 1]
      multi-dim.squeeze(some([list: 4])).shape() is [list: 1, 1, 1, 4]
      multi-dim.squeeze(some([list: 1, 2])).shape() is [list: 1, 4, 1]

      multi-dim.squeeze(some([list: 7]))
        raises "Cannot squeeze axis 7 since the axis does not exist"
      multi-dim.squeeze(some([list: 3]))
        raises "Cannot squeeze axis 3 since the dimension of that axis is 4, not 1"
    end
  }

  @tensor-method["clone"]

  Constructs a new @pyret{Tensor} that is a copy of the original @pyret{Tensor}.

  @examples{
    check:
      some-tensor = [tensor: 1, 2, 3, 4]
      new-tensor  = some-tensor.clone()
      new-tensor.size() is some-tensor.size()
      new-tensor.shape() is some-tensor.shape()
      new-tensor.data-now() is-roughly some-tensor.data-now()
    end
  }

  @tensor-method["add"]

  Adds @pyret{x} to the @pyret{Tensor}. This is equivalent to
  @pyret-id["add-tensors"]@pyret{(self, x)}.

  @tensor-method["subtract"]

  Subtracts @pyret{x} from the @pyret{Tensor}. This is equivalent to
  @pyret-id["subtract-tensors"]@pyret{(self, x)}.

  @tensor-method["multiply"]

  Multiplies the @pyret{Tensor} by @pyret{x}. This is equivalent to
  @pyret-id["multiply-tensors"]@pyret{(self, x)}.

  @tensor-method["divide"]

  Divides the @pyret{Tensor} by @pyret{x}. This is equivalent to
  @pyret-id["divide-tensors"]@pyret{(self, x)}.

  @tensor-method["floor-divide"]

  Divides the @pyret{Tensor} by @pyret{x}, with the result rounded
  with the floor function. This is equivalent to
  @pyret-id["floor-divide-tensors"]@pyret{(self, x)}.

  @tensor-method["max"]

  Returns the maximum of the @pyret{Tensor} and @pyret{x}. This is equivalent to
  @pyret-id["tensor-max"]@pyret{(self, x)}.

  @tensor-method["min"]

  Returns the minimum of the @pyret{Tensor} and @pyret{x}. This is equivalent to
  @pyret-id["tensor-min"]@pyret{(self, x)}.

  @tensor-method["modulo"]

  Computes the modulo of the @pyret{Tensor} and @pyret{x}. This is equivalent to
  @pyret-id["tensor-modulo"]@pyret{(self, x)}.

  @tensor-method["expt"]

  Computes the power of the @pyret{Tensor} to @pyret{exponent}. This is
  equivalent to @pyret-id["tensor-expt"]@pyret{(self, x)}.

  @tensor-method["squared-difference"]

  Computes @pyret{(self - x) * (self - x)}, element-wise. This is
  equivalent to @pyret-id["squared-difference"]@pyret{(self, x)}.

  @;#########################################################################
  @section{TensorBuffers}

  @type-spec["TensorBuffer"]{

    @pyret{TensorBuffer}s are mutable objects that allow users to set values
    at specific locations before converting the buffer into an immutable
    @pyret-id["Tensor"].

  }

  @function["is-tensor-buffer"]

  Returns @pyret{true} if @pyret{val} is a @pyret{TensorBuffer}; otherwise,
  returns @pyret{false}.

  @;#########################################################################
  @subsection{TensorBuffer Constructors}

  @function["make-buffer"]

  Creates an @pyret{TensorBuffer} with the specified @pyret{shape}. The
  returned @pyret{TensorBuffer}'s values are initialized to @pyret{~0}.

  @;#########################################################################
  @subsection{TensorBuffer Methods}

  @tensor-buffer-method["set-now"]

  Sets the value in the @pyret{TensorBuffer} at the specified @pyret{indicies}
  to @pyret{value}.

  @tensor-buffer-method["get-now"]

  Returns the value in the @pyret{TensorBuffer} at the specified
  @pyret{indicies}.

  @tensor-buffer-method["get-all-now"]

  Returns all values in the @pyret{TensorBuffer}.

  @tensor-buffer-method["to-tensor"]

  Creates an immutable @pyret-id["Tensor"] from the @pyret{TensorBuffer}.

  @;#########################################################################
  @section{Operations}

  @;#########################################################################
  @subsection{Arithmetic Operations}

  @function["add-tensors"]

  Adds two @pyret-id["Tensor"]s element-wise, A + B.

  To assert that @pyret{a} and @pyret{b} are the same shape, use
  @pyret-id["strict-add-tensors"].

  @function["subtract-tensors"]

  Subtracts two @pyret-id["Tensor"]s element-wise, A – B.

  To assert that @pyret{a} and @pyret{b} are the same shape, use
  @pyret-id["strict-subtract-tensors"].

  @function["multiply-tensors"]

  Multiplies two @pyret-id["Tensor"]s element-wise, A * B.

  To assert that @pyret{a} and @pyret{b} are the same shape, use
  @pyret-id["strict-multiply-tensors"].

  @function["divide-tensors"]

  Divides two @pyret-id["Tensor"]s element-wise, A / B.

  To assert that @pyret{a} and @pyret{b} are the same shape, use
  @pyret-id["strict-divide-tensors"].

  @function["floor-divide-tensors"]

  Divides two @pyret-id["Tensor"]s element-wise, A / B, with the result rounded
  with the floor function.

  @function["tensor-max"]

  Returns a @pyret-id["Tensor"] containing the maximum of @pyret{a} and @pyret{b},
  element-wise.

  To assert that @pyret{a} and @pyret{b} are the same shape, use
  @pyret-id["strict-tensor-max"].

  @function["tensor-min"]

  Returns a @pyret-id["Tensor"] containing the minimum of @pyret{a} and @pyret{b},
  element-wise.

  To assert that @pyret{a} and @pyret{b} are the same shape, use
  @pyret-id["strict-tensor-min"].

  @function["tensor-modulo"]

  Computes the modulo of @pyret{a} and @pyret{b}, element-wise.

  To assert that @pyret{a} and @pyret{b} are the same shape, use
  @pyret-id["strict-tensor-modulo"].

  @function["tensor-expt"]

  Computes the power of @pyret{base} to @pyret{exponent}, element-wise.

  To ensure that @pyret{a} and @pyret{b} are the same shape, use
  @pyret-id["strict-tensor-expt"].

  @function["squared-difference"]

  Computes @pyret{(a - b) * (a - b)}, element-wise.

  To assert that @pyret{a} and @pyret{b} are the same shape, use
  @pyret-id["strict-squared-difference"].

  @function["strict-add-tensors"]

  Same as @pyret-id["add-tensors"], but raises an error if @pyret{a} and
  @pyret{b} are not the same shape (as determined by
  @pyret-method["Tensor" "shape"]).

  @function["strict-subtract-tensors"]

  Same as @pyret-id["subtract-tensors"], but raises an error if @pyret{a} and
  @pyret{b} are not the same shape (as determined by
  @pyret-method["Tensor" "shape"]).

  @function["strict-multiply-tensors"]

  Same as @pyret-id["multiply-tensors"], but raises an error if @pyret{a} and
  @pyret{b} are not the same shape (as determined by
  @pyret-method["Tensor" "shape"]).

  @function["strict-divide-tensors"]

  Same as @pyret-id["divide-tensors"], but raises an error if @pyret{a} and
  @pyret{b} are not the same shape (as determined by
  @pyret-method["Tensor" "shape"]).

  @function["strict-tensor-max"]

  Same as @pyret-id["tensor-max"], but raises an error if @pyret{a} and
  @pyret{b} are not the same shape (as determined by
  @pyret-method["Tensor" "shape"]).

  @function["strict-tensor-min"]

  Same as @pyret-id["tensor-min"], but raises an error if @pyret{a} and
  @pyret{b} are not the same shape (as determined by
  @pyret-method["Tensor" "shape"]).

  @function["strict-tensor-expt"]

  Same as @pyret-id["tensor-expt"], but raises an error if @pyret{a} and
  @pyret{b} are not the same shape (as determined by
  @pyret-method["Tensor" "shape"]).

  @function["strict-tensor-modulo"]

  Same as @pyret-id["tensor-modulo"], but raises an error if @pyret{a} and
  @pyret{b} are not the same shape (as determined by
  @pyret-method["Tensor" "shape"]).

  @function["strict-squared-difference"]

  Same as @pyret-id["squared-difference"], but raises an error if @pyret{a} and
  @pyret{b} are not the same shape (as determined by
  @pyret-method["Tensor" "shape"]).

  @;#########################################################################
  @subsection{Basic Math Operations}

  @function["tensor-abs"]

  Computes the absolute value of the @pyret-id["Tensor"], element-wise.

  @function["tensor-acos"]

  Computes the inverse cosine of the @pyret-id["Tensor"], element-wise.

  @function["tensor-acosh"]

  Computes the inverse hyperbolic cosine of the @pyret-id["Tensor"], element-wise.

  @function["tensor-asin"]

  Computes the inverse sine of the @pyret-id["Tensor"], element-wise.

  @function["tensor-asinh"]

  Computes the inverse hyperbolic sine of the @pyret-id["Tensor"], element-wise.

  @function["tensor-atan"]

  Computes the inverse tangent of the @pyret-id["Tensor"], element-wise.

  @function["tensor-atan2"]

  Computes the @link["https://en.wikipedia.org/wiki/Atan2"
  "four-quadrant inverse tangent"] of @pyret{a} and @pyret{b}, element-wise.

  @function["tensor-atanh"]

  Computes the inverse hyperbolic tangent of the @pyret-id["Tensor"], element-wise.

  @function["tensor-ceil"]

  Computes the ceiling of the @pyret-id["Tensor"], element-wise.

  @function["clip-by-value"]

  Clips the values of the @pyret-id["Tensor"], element-wise, such that every element
  in the resulting @pyret-id["Tensor"] is at least @pyret{min-value} and is at most
  @pyret{max-value}.

  @function["tensor-cos"]

  Computes the cosine of the @pyret-id["Tensor"], element-wise.

  @function["tensor-cosh"]

  Computes the hyperbolic cosine of the @pyret-id["Tensor"], element-wise.

  @function["exponential-linear-units"]

  Applies the @link["https://en.wikipedia.org/wiki/Rectifier_(neural_networks)#ELUs"
  "exponential linear units"] function to the @pyret-id["Tensor"], element-wise.

  @function["elu"]

  Alias for @pyret-id["exponential-linear-units"].

  @function["gauss-error"]

  Applies the @link["http://mathworld.wolfram.com/Erf.html" "gauss error function"]
  to the @pyret-id["Tensor"], element-wise.

  @function["erf"]

  Alias for @pyret-id["gauss-error"].

  @function["tensor-exp"]

  Computes the equivalent of @pyret{num-exp(tensor)}, element-wise.

  @function["tensor-exp-min1"]

  Computes the equivalent of @pyret{num-exp(tensor - 1)}, element-wise.

  @function["tensor-floor"]

  Computes the floor of the @pyret-id["Tensor"], element-wise.

  @function["leaky-relu"]

  Applies a @link["https://en.wikipedia.org/wiki/Rectifier_(neural_networks)#Leaky_ReLUs"
  "leaky rectified linear units"] function to the @pyret-id["Tensor"],
  element-wise.

  @pyret{alpha} is the scaling factor for negative values. The default in
  TensorFlow.js is @pyret{0.2}, but the argument has been exposed here for more
  flexibility.

  @function["tensor-log"]

  Computes the natural logarithm of the @pyret-id["Tensor"], element-wise; that
  is, it computes the equivalent of @pyret{num-log(tensor)}.

  @function["tensor-log-plus1"]

  Computes the natural logarithm of the @pyret-id["Tensor"] plus 1,
  element-wise; that is, it computes the equivalent of
  @pyret{num-log(tensor + 1)}.

  @function["log-sigmoid"]

  Applies the @link["https://en.wikibooks.org/wiki/Artificial_Neural_Networks/
  Activation_Functions#Continuous_Log-Sigmoid_Function" "log sigmoid"] function
  to the @pyret-id["Tensor"], element-wise.

  @function["tensor-negate"]

  Multiplies each element in the @pyret-id["Tensor"] by @pyret{-1}.

  @function["parametric-relu"]

  Applies a @link["https://en.wikipedia.org/wiki/Rectifier_(neural_networks)#Leaky_ReLUs"
  "leaky rectified linear units"] function to the @pyret-id["Tensor"],
  element-wise, using parametric alphas.

  @pyret{alpha} is the scaling factor for negative values.

  @function["tensor-reciprocal"]

  Computes the reciprocal of the @pyret-id["Tensor"], element-wise; that is, it
  computes the equivalent of @pyret{1 / tensor}.

  @function["relu"]

  Applies a @link["https://en.wikipedia.org/wiki/Rectifier_(neural_networks)"
  "rectified linear units"] function to the @pyret-id["Tensor"], element-wise.

  @function["tensor-round"]

  Computes the equivalent of @pyret{num-round(tensor)}, element-wise.

  @function["reciprocal-sqrt"]

  Computes the recriprocal of the square root of the @pyret-id["Tensor"],
  element-wise.

  The resulting @pyret-id["Tensor"] is roughly equivalent to
  @pyret{tensor-reciprocal(tensor-sqrt(tensor))}.

  @function["scaled-elu"]

  Applies a scaled, exponential linear units function to the
  @pyret-id["Tensor"], element-wise.

  @function["sigmoid"]

  Applies the sigmoid function to the @pyret-id["Tensor"], element-wise.

  @function["signed-ones"]

  Returns an element-wise indication of the sign of each number in the
  @pyret-id["Tensor"]; that is, every value in the original tensor is
  represented in the resulting tensor as @pyret{~+1} if the value is positive,
  @pyret{~-1} if the value was negative, or @pyret{~0} if the value was zero
  or not a number.

  @function["tensor-sin"]

  Computes the sine of the @pyret-id["Tensor"], element-wise.

  @function["tensor-sinh"]

  Computes the hyperbolic sine of the @pyret-id["Tensor"], element-wise.

  @function["softplus"]

  Applies the @link["https://sefiks.com/2017/08/11/softplus-as-a-neural-networks-activation-function/"
  "softplus"] function to the @pyret-id["Tensor"], element-wise.

  @function["tensor-sqrt"]

  Computes the square root of the @pyret-id["Tensor"], element-wise.

  @function["tensor-square"]

  Computes the square of the @pyret-id["Tensor"], element-wise.

  @function["step"]

  Applies the unit step function to the @pyret-id["Tensor"], element-wise;
  that is, every value in the original tensor is represented in the resulting
  tensor as @pyret{~0} if the value is negative; otherwise, it is represented
  as @pyret{~+1}.

  @function["tensor-tan"]

  Computes the tangent of the @pyret-id["Tensor"], element-wise.

  @function["tensor-tanh"]

  Computes the hyperbolic tangent of the @pyret-id["Tensor"], element-wise.

  @;#########################################################################
  @subsection{Reduction Operations}

  @function["all"]

  Reduces the input @pyret-id["Tensor"] across all dimensions by computing the
  logical "and" of its elements.

  @pyret{tensor} must be of type @pyret{"bool"}; otherwise, the function raises
  an error.

  @function["any"]

  Reduces the input @pyret-id["Tensor"] across all dimensions by computing the
  logical "or" of its elements.

  @pyret{tensor} must be of type @pyret{"bool"}; otherwise, the function raises
  an error.

  @function["arg-max"]

  Returns a new @pyret-id["Tensor"] where each element is the index of the maximum
  values along the outermost dimension of @pyret{tensor}.

  @function["arg-min"]

  Returns a new @pyret-id["Tensor"] where each element is the index of the minimum
  values along the outermost dimension of @pyret{tensor}.

  @function["log-sum-exp"]

  Computes @pyret{log(sum(exp(elements along the outermost dimension))}.

  Reduces @pyret{tensor} along the outermost dimension.

  @function["reduce-max"]

  Returns a @pyret-id["Tensor"] containing a single value that is the maximum value
  of all entries in @pyret{tensor}.

  @function["reduce-min"]

  Returns a @pyret-id["Tensor"] containing a single value that is the minimum value
  of all entries in @pyret{tensor}.

  @function["reduce-mean"]

  Returns a @pyret-id["Tensor"] containing a single value that is the mean value
  of all entries in @pyret{tensor}.

  @function["reduce-sum"]

  Returns a @pyret-id["Tensor"] containing a single value that is the sum
  of all entries in @pyret{tensor}.

  @;#########################################################################
  @subsection{Slicing and Joining Operations}

  @function["concatenate"]

  Concatenates each @pyret-id["Tensor"] in @pyret{tensors} along the given
  @pyret{axis}.

  If @pyret{axis} is @pyret{none}, the function defaults to concatenating along
  axis 0 (the first dimension).

  The @pyret-id["Tensor"]s' ranks and types must match, and their sizes must
  match in all dimensions except @pyret{axis}.

  @function["gather"]

  Gathers slices from the @pyret-id["Tensor"] at every index in @pyret{indices}
  along the given @pyret{axis}.

  If @pyret{axis} is @pyret{none}, the function defaults to gathering along
  axis 0 (the first dimension).

  @examples{
    check:
      input-1   = [tensor: 1, 2, 3, 4]
      indices-1 = [tensor: 1, 3, 3]

      gather(input-1, indices-1).data-now() is [list: 2, 4, 4]

      input-2   = [tensor: 1, 2, 3, 4].as-2d(2, 2)
      indices-2 = [tensor: 1, 1, 0]

      gather(input-2, indices-2).data-now() is [list: 3, 4,
                                                       3, 4,
                                                       1, 2]
    end
  }

  @function["reverse"]

  Reverses the values in @pyret{tensor} along the specified @pyret{axis}.

  If @pyret{axis} is @pyret{none}, the function defaults to reversing along
  axis 0 (the first dimension).

  @function["slice"]

  Extracts a slice from @pyret{tensor} starting at the coordinates represented
  by @pyret{begin}. The resulting slice is of size @pyret{size}.

  A value of @pyret{-1} in @pyret{size} means that the resulting slice will go
  all the way to the end of the dimensions in the respective axis.

  If the length of @pyret{size} is less than the rank of in @pyret{tensor}, the
  size of the rest of the axes will be implicitly set to @pyret{-1}. If
  @pyret{size} is @pyret{none}, the size of all axes will be set to @pyret{-1}.

  @function["split"]
  @function["stack"]
  @function["tile"]
  @function["unstack"]
  @function["strided-slice"]

  Extracts a strided slice of a @pyret-id["Tensor"].

  Roughly speaking, this operations extracts a slice of size
  @pyret{(end - begin) / stride} from @pyret{tensor}. Starting at the location
  specified by @pyret{begin}, the slice continues by adding @pyret{stride} to
  the index until all dimensions are not less than @pyret{end}. Note that a
  stride can be negative, which causes a reverse slice.

  @;#########################################################################
  @section{Models}

  @pyret{Model}s represent a collection of @pyret-id["Layer"]s, and define a
  series of inputs and outputs. They are one of the primary abstractions used
  in TensorFlow, and can be trained, evaluated, and used for prediction.

  There are two types of models in TensorFlow: @pyret-id["Sequential"], where
  the outputs of one @pyret-id["Layer"] are the inputs to the next
  @pyret-id["Layer"], and @pyret-id["Model"], which is more generic and
  supports arbitrary, non-cyclic graphs of @pyret-id["Layer"]s.

  @;#########################################################################
  @subsection{Generic Models}

  @type-spec["Model"]{

    A @pyret{Model} is a data structure that consists of @pyret-id["Layer"]s and
    defines inputs and outputs. It is more generic than @pyret-id["Sequential"]
    models as it supports arbitrary, non-cyclic graphs of @pyret-id["Layer"]s.

  }

  @function["is-model"]

  @function["make-model"]

  @;#########################################################################
  @subsection{Sequential Models}

  @type-spec["Sequential"]{

    A @pyret{Sequential} model is a model where the outputs of one
    @pyret-id["Layer"] are the inputs to the next @pyret-id["Layer"]. That is,
    the model topology is a simple "stack" of layers, with no branching or
    skipping.

    As a result, the first layer passed to a @pyret{Sequential} model must
    have a defined input shape.

  }

  @function["is-sequential"]

  @function["make-sequential"]

  @sequential-method["add"]
  @sequential-method["compile"]
  @sequential-method["evaluate"]
  @sequential-method["predict"]
  @sequential-method["predict-on-batch"]
  @sequential-method["fit"]

  @;#########################################################################
  @section{SymbolicTensors}

  @type-spec["SymbolicTensor"]{

    @pyret{SymbolicTensor}s are placeholders for @pyret-id["Tensor"]s without
    any concrete value.

    They are most often encountered when building a graph of @pyret-id["Layer"]s
    for a @pyret-id["Model"] that takes in some kind of unknown input.

  }

  @;#########################################################################
  @subsection{SymbolicTensor Constructors}

  @function["make-input"]
  @function["make-batch-input"]

  @;#########################################################################
  @subsection{SymbolicTensor Methods}

  @symbolic-tensor-method["shape"]

  @;#########################################################################
  @section{Layers}

  @type-spec["Layer"]{

    @pyret{Layer}s are the primary building block for constructing a
    @pyret-id["Model"]. Each @pyret{Layer} will typically perform some
    computation to transform its input to its output.

    @pyret{Layer}s will automatically take care of creating and initializing
    the various internal variables/weights they need to function.

  }

  @function["is-layer"]

  @;#########################################################################
  @subsection{Basic Layers}

  @function["activation-layer"]
  @function["dense-layer"]
  @function["dropout-layer"]
  @function["embedding-layer"]
  @function["flatten-layer"]
  @function["repeat-vector-layer"]
  @function["reshape-layer"]

  @;#########################################################################
  @subsection{Convolutional Layers}

  @function["conv-1d-layer"]
  @function["conv-2d-layer"]
  @function["conv-2d-transpose-layer"]
  @function["cropping-2d-layer"]
  @function["depthwise-conv-2d-layer"]
  @function["separable-conv-2d-layer"]
  @function["up-sampling-2d-layer"]

  @;#########################################################################
  @subsection{Merge Layers}

  @function["add-layer"]
  @function["average-layer"]
  @function["concatenate-layer"]
  @function["maximum-layer"]
  @function["minimum-layer"]
  @function["multiply-layer"]

  @;#########################################################################
  @subsection{Normalization Layers}

  @function["batch-normalization-layer"]

  @;#########################################################################
  @subsection{Pooling Layers}

  @function["average-pooling-1d-layer"]
  @function["average-pooling-2d-layer"]
  @function["global-average-pooling-1d-layer"]
  @function["global-average-pooling-2d-layer"]
  @function["global-max-pooling-1d-layer"]
  @function["global-max-pooling-2d-layer"]
  @function["max-pooling-1d-layer"]
  @function["max-pooling-2d-layer"]

  @;#########################################################################
  @subsection{Recurrent Layers}

  @function["gru-layer"]
  @function["gru-cell-layer"]
  @function["lstm-layer"]
  @function["lstm-cell-layer"]
  @function["rnn-layer"]
  @function["simple-rnn-layer"]
  @function["simple-rnn-cell-layer"]
  @function["stacked-rnn-cells-layer"]

  @;#########################################################################
  @subsection{Wrapper Layers}

  @function["bidirectional-layer"]
  @function["time-distributed-layer"]

  @;#########################################################################
  @section{Optimizers}

  @type-spec["Optimizer"]{

    @pyret{Optimizer}s are used to perform training operations and compute
    gradients.

    @pyret{Optimizer}s eagerly compute gradients. This means that when a user
    provides a function that is a combination of TensorFlow operations
    to an @pyret{Optimizer}, the @pyret{Optimizer} automatically differentiates
    that function's output with respect to its inputs.

  }

  @function["is-optimizer"]

  Returns @pyret{true} if @pyret{val} is an @pyret{Optimizer}; otherwise,
  returns @pyret{false}.

  @;#########################################################################
  @subsection{Optimizer Constructors}

  There are many different types of @pyret{Optimizer}s that use different
  formulas to compute gradients.

  @function["train-sgd"]

  Constructs an @pyret{Optimizer} that uses a stochastic gradient descent
  algorithm, where @pyret{learning-rate} is the learning rate to use for the
  algorithm.

  @function["train-momentum"]

  Constructs an @pyret{Optimizer} that uses a momentum gradient descent
  algorithm, where @pyret{learning-rate} is the learning rate to use for the
  algorithm and @pyret{momentum} is the momentum to use for the algorithm.

  See @link["http://proceedings.mlr.press/v28/sutskever13.pdf"
  "http://proceedings.mlr.press/v28/sutskever13.pdf"].

  @function["train-adagrad"]

  Constructs an @pyret{Optimizer} that uses the Adagrad algorithm, where
  @pyret{learning-rate} is the learning rate to use for the Adagrad gradient
  descent algorithm.

  If not @pyret{none}, @pyret{initial-accumulator} is the positive, starting
  value for the accumulators in the Adagrad algorithm. If
  @pyret{initial-accumulator} is specified but is not positive, the function
  raises an error.

  See @link["http://www.jmlr.org/papers/volume12/duchi11a/duchi11a.pdf"
  "http://www.jmlr.org/papers/volume12/duchi11a/duchi11a.pdf"] or
  @link["http://ruder.io/optimizing-gradient-descent/index.html#adagrad"
  "http://ruder.io/optimizing-gradient-descent/index.html#adagrad"].

  @function["train-adadelta"]

  Constructs an @pyret{Optimizer} that uses the Adadelta algorithm.

  If not @pyret{none}, @pyret{learning-rate} is the learning rate to use for
  the Adamax gradient descent algorithm, @pyret{rho} is the learning rate
  decay over each update, and @pyret{epsilon} is a constant used to better
  condition the gradient updates.

  See @link["https://arxiv.org/abs/1212.5701" "https://arxiv.org/abs/1212.5701"].

  @function["train-adam"]

  Constructs an @pyret{Optimizer} that uses the Adam algorithm.

  If not @pyret{none}, @pyret{learning-rate} is the learning rate to use for
  the Adamax gradient descent algorithm, @pyret{beta-1} is the exponential
  decay rate for the first moment estimates, @pyret{beta-2} is the
  exponential decay rate for the second moment estimates, and
  @pyret{epsilon} is a small constant for numerical stability.

  See @link["https://arxiv.org/abs/1412.6980" "https://arxiv.org/abs/1412.6980"].

  @function["train-adamax"]

  Constructs an @pyret{Optimizer} that uses the Adamax algorithm.

  If not @pyret{none}, @pyret{learning-rate} is the learning rate to use for
  the Adamax gradient descent algorithm, @pyret{beta-1} is the exponential
  decay rate for the first moment estimates, @pyret{beta-2} is the
  exponential decay rate for the second moment estimates, @pyret{epsilon} is
  a small constant for numerical stability, and @pyret{decay} is the learning
  rate decay over each update.

  See @link["https://arxiv.org/abs/1412.6980" "https://arxiv.org/abs/1412.6980"].

  @function["train-rmsprop"]

  Constructs an @pyret{Optimizer} that uses RMSProp gradient descent, where
  @pyret{learning-rate} is the learning rate to use for the RMSProp gradient
  descent algorithm.

  If not @pyret{none}, @pyret{decay} represents the discounting factor for the
  history/coming gradient, @pyret{momentum} represents the momentum to use for
  the RMSProp gradient descent algorithm, and @pyret{epsilon} is a small value
  to avoid division-by-zero errors.

  If @pyret{is-centered} is @pyret{true}, gradients are normalized by the
  estimated varience of the gradient.

  See @link["http://www.cs.toronto.edu/~tijmen/csc321/slides/lecture_slides_lec6.pdf"
  "these slides from the University of Toronto"] for a primer on RMSProp.

  @bold{Note:} This TensorFlow.js implementation uses plain momentum and is
  not the "centered" version of RMSProp.

  @;#########################################################################
  @subsection{Optimizer Methods}

  @optimizer-method["minimize"]

  Executes @pyret{f} and minimizes the scalar output of @pyret{f} by computing
  gradients of @pyret{y} with with respect to the list of trainable, variable
  @pyret{Tensor}s provided by @pyret{variables}.

  @pyret{f} must be a thunk that returns a scalar @pyret{Tensor}.
  The method then returns the scalar @pyret{Tensor} produced by @pyret{f}.

  If @pyret{variables} is @pyret{empty}, the @pyret{Optimizer} will default
  to training all trainable variables that have been instantiated.

  @;#########################################################################
  @section{Usage Examples}

  The below program demonstrates how to use @pyret{tensorflow} to perform
  linear regression operations on a dataset.

  @examples{
    import tensorflow as TF
    import chart as C
    import image as I
    import lists as L

    type Tensor = TF.Tensor
    type Optimizer = TF.Optimizer
    type ChartWindow = C.ChartWindow
    type Image = I.Image

    # Create a tiny helper function:
    fun positive-rand() -> Number:
      doc: "Generates a positive Number between 0 and 1"
      num-random(10000000) / 10000000
    end

    # `train-x` and `train-y` represent random points in a dataset, plotted
    # on `scatter-plot`:
    train-x = [list:
      3.3, 4.4, 5.5, 6.71, 6.93, 4.168, 9.779, 6.182, 7.59, 2.167, 7.042,
      10.791, 5.313, 7.997, 5.654, 9.27, 3.1]

    train-y = [list:
      1.7, 2.76, 2.09, 3.19, 1.694, 1.573, 3.366, 2.596, 2.53, 1.221,
      2.827, 3.465, 1.65, 2.904, 2.42, 2.94, 1.3]

    scatter-plot = C.from-list.scatter-plot(train-x, train-y)

    # Create two scalar Tensors `m` and `b` that are variables:
    m = TF.make-scalar(positive-rand()).to-variable()
    b = TF.make-scalar(positive-rand()).to-variable()

    # Setup a few helper functions before training:
    fun predict(x :: Tensor) -> Tensor:
      doc: ```Uses the current values of m and b to predict what Y-values will
           be generated given a Tensor `x` representing X-values```

      temp = TF.multiply-tensors(m, x)
      TF.add-tensors(temp, b)
    end

    fun loss(prediction :: Tensor, actual-values :: Tensor) -> Tensor:
      doc: ```Used to calculate a measure of difference between the predicted
           Y-values and the actual Y-values```

      TF.subtract-tensors(prediction, actual-values)
        ^ TF.tensor-square(_)
        ^ TF.reduce-mean(_)
    end

    # Train the model by creating an Optimizer. The optimizer will change any
    # variable tensors used in the function passed into it in an attempt to
    # minimize the returned loss:
    fun train():
      doc: "Trains the model"
      learning-rate = 0.005
      optimizer = TF.train-sgd(learning-rate)

      optimizer.minimize(lam() block:
          prediction = predict(TF.list-to-tensor(train-x).as-1d())
          step-loss = loss(prediction, TF.list-to-tensor(train-y).as-1d())
          step-loss
        end, empty)
    end

    fun plot() -> ChartWindow:
      doc: "Plots the current mx + b function and overlays it on the scatter plot"
      shadow m = m.data-now().first
      shadow b = b.data-now().first

      function-plot = C.from-list.function-plot(lam(x): (m * x) + b end)
      C.render-charts([list: scatter-plot, function-plot])
    end

    fun train-steps(steps :: Number) -> Image block:
      doc: "Trains the model `steps` times"
      for L.each(_ from L.range(0, steps)) block:
        train()
        print("y = " + num-to-string(m.data-now().first) + "x + " + num-to-string(b.data-now().first))
      end
      plot().get-image()
    end
  }

  The below program demonstrates how to use @pyret{tensorflow} to fit a cubic
  function to synthetic data using the stochastic gradient descent algorithm.

  Program based on @link["https://js.tensorflow.org/tutorials/fit-curve.html"
  "https://js.tensorflow.org/tutorials/fit-curve.html"].

  @examples{
    import tensorflow as TF
    import chart as C
    import image as I

    type Tensor = TF.Tensor
    type DataSeries = C.DataSeries

    fun positive-rand() -> Number:
      num-random(10000000) / 10000000
    end

    fun generate-data(num-points :: Number, coefficients :: Object, sigma :: Number) -> Object:
      a = TF.make-scalar(coefficients.a)
      b = TF.make-scalar(coefficients.b)
      c = TF.make-scalar(coefficients.c)
      d = TF.make-scalar(coefficients.d)

      xs = TF.random-uniform([list: num-points], some(-1), some(1))

      # The below represents ax^3 + bx^2 + cx + d:
      ys = a.multiply(xs.expt(TF.make-scalar(3)))
        .add(b.multiply(TF.tensor-square(xs)))
        .add(c.multiply(xs))
        .add(d)
        .add(TF.random-normal([list: num-points], some(0), some(sigma)))

      # Normalize the y values to the range 0 to 1:
      y-min = TF.reduce-min(ys)
      y-max = TF.reduce-max(ys)
      y-range = TF.subtract-tensors(y-max, y-min)
      ys-normalized = TF.subtract-tensors(ys, y-min) ^ TF.divide-tensors(_, y-range)

      {xs: xs, ys: ys-normalized}
    end

    fun predict(a :: Tensor, b :: Tensor, c :: Tensor, d :: Tensor, x :: Tensor) -> Tensor:
      # The below represents ax^3 + bx^2 + cx + d:
      a.multiply(x.expt(TF.make-scalar(3)))
        .add(b.multiply(TF.tensor-square(x)))
        .add(c.multiply(x))
        .add(d)
    end

    fun loss(prediction :: Tensor, actual-values :: Tensor) -> Tensor:
      TF.subtract-tensors(prediction, actual-values)
        ^ TF.tensor-square(_)
        ^ TF.reduce-mean(_)
    end

    fun plot(scatter-plot :: DataSeries, a :: Tensor, b :: Tensor, c :: Tensor, d :: Tensor) block:
      a-val = a.data-now().first
      b-val = b.data-now().first
      c-val = c.data-now().first
      d-val = d.data-now().first

      print("Equation:")
      print("y = "
          + num-to-string(a-val) + "x^3 + "
          + num-to-string(b-val) + "x^2 + "
          + num-to-string(c-val) + "x + "
          + num-to-string(d-val))
      function-plot = C.from-list.function-plot(
        lam(x): (a-val * num-expt(x, 3)) + (b-val * num-sqr(x)) + (c-val * x) + d-val end)
      chart-image = C.render-charts([list: scatter-plot, function-plot]).get-image()
      I.scale(0.6, chart-image)
    end

    # Generate synthetic data based on a cubic function
    test-data = generate-data(100, {a: -0.8, b: -0.2, c: 0.9, d: 0.5}, 0.04)
    train-x = test-data.xs.data-now()
    train-y = test-data.ys.data-now()

    # Plot the random points ahead of time for better perfomance:
    scatter-plot = C.from-list.scatter-plot(train-x, train-y)

    # Generate a few variables representing coefficients in the equation,
    # randomized to some value between 0 and 1
    a = TF.make-scalar(positive-rand()).to-variable()
    b = TF.make-scalar(positive-rand()).to-variable()
    c = TF.make-scalar(positive-rand()).to-variable()
    d = TF.make-scalar(positive-rand()).to-variable()

    # Plot the random cubic function overlayed on the initial points:
    plot(scatter-plot, a, b, c, d)

    # Create an optimizer:
    LEARNING-RATE = 0.5
    TRAINING-CYCLES = 200
    optimizer = TF.train-sgd(LEARNING-RATE)

    # Train the model
    for each(i from range(0, TRAINING-CYCLES)):
      optimizer.minimize(lam() block:
          prediction = predict(a, b, c, d, test-data.xs)
          loss(prediction, test-data.ys)
        end, empty)
    end

    # Plot the resulting cubic function overlayed on the initial points:
    plot(scatter-plot, a, b, c, d)
  }
}
