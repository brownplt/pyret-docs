#lang scribble/manual
@(require "../../scribble-api.rkt" "../abbrevs.rkt")

@(define Tensor (a-id "Tensor" (xref "tensorflow" "Tensor")))
@(define Model (a-id "Model" (xref "tensorflow" "Model")))
@(define Sequential (a-id "Sequential" (xref "tensorflow" "Sequential")))
@(define Layer (a-id "Layer" (xref "tensorflow" "Layer")))
@(define Optimizer (a-id "Optimizer" (xref "tensorflow" "Optimizer")))

@(define (tensor-method name)
  (method-doc "Tensor" #f name #:alt-docstrings ""))

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
      (name "random-normal")
      (arity 1)
      (args ("shape"))
      (return ,Tensor)
      (contract
        (a-arrow ,(L-of N) ,Tensor)))
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
          (return ,N)
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
            (a-arrow ,Tensor ,N ,N ,Tensor)))
        (method-spec
          (name "as-3d")
          (arity 4)
          (params ())
          (args ("self" "rows" "columns" "depth"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,N ,N ,N ,Tensor)))
        (method-spec
          (name "as-4d")
          (arity 5)
          (params ())
          (args ("self" "rows" "columns" "depth1" "depth2"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,N ,N ,N ,N ,Tensor)))
        (method-spec
          (name "as-type")
          (arity 2)
          (params ())
          (args ("self" "data-type"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,S ,Tensor)))
        (method-spec
          (name "data-sync")
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
            (a-arrow ,Tensor ,(L-of N) ,Tensor)))
        (method-spec
          (name "clone")
          (arity 1)
          (params ())
          (args ("self"))
          (return ,Tensor)
          (contract
            (a-arrow ,Tensor ,Tensor)))
        (method-spec
          (name "placeholder")
          (arity 2)
          (params ())
          (args ("self" "width"))
          (return ,(L-of S))
          (contract
            (a-arrow ,Tensor ,N ,(L-of S))))
            )))

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
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "arg-max")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "arg-min")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "log-sum-exp")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "reduce-max")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "mean")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "reduce-min")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
    (fun-spec
      (name "reduce-sum")
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))

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
      (args ("values"))
      (return ,Model)
      (contract
        (a-arrow ,(L-of N) ,Model)))

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
      (args ("values"))
      (return ,Sequential)
      (contract
        (a-arrow ,(L-of N) ,Sequential)))

    (data-spec
      (name "Sequential")
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
      (name "is-dense-layer")
      (arity 1)
      (args ("val"))
      (return ,B)
      (contract
        (a-arrow ,A ,B)))
    (fun-spec
      (name "make-dense-layer")
      (arity 1)
      (args ("values"))
      (return ,Layer)
      (contract
        (a-arrow ,(L-of N) ,Layer)))

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
      (args ("values"))
      (return ,Optimizer)
      (contract
        (a-arrow ,(L-of N) ,Optimizer)))

    (data-spec
      (name "Optimizer")
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
   ))

@docmodule["tensorflow"]{
  A module that provides a Pyret interface for TensorFlow, a
  symbolic math library for machine learning applications.

  @;#########################################################################
  @section{The Tensor Datatype}

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
    @pyret-method["Tensor" "data-sync"] always returns a
    @pyret{List<Roughnum>}.

    Since @pyret{Tensor}s are immutable, all operations always return new
    @pyret{Tensor}s and never modify the input @pyret{Tensor}s. The exception
    to this is when a @pyret{Tensor} is transformed into a mutable
    @pyret{Tensor} using the @pyret-id["make-variable"] function or the
    @pyret-method["Tensor" "to-variable"] method. These "variable tensors"
    can be modified by @pyret{Optimizer}s.

  }

  @;#########################################################################
  @section{Tensor Constructors}

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

  @function["list-to-tensor"]

  Creates a new @pyret{Tensor} with the values in the input @pyret{List}.

  Similar to the @pyret-id["tensor"] constructor, all @pyret{Tensor}s created
  using @pyret-id["list-to-tensor"] are one-dimensional by default. Use
  @pyret-method["Tensor" "as-1d"], @pyret-method["Tensor" "as-2d"],
  @pyret-method["Tensor" "as-3d"], @pyret-method["Tensor" "as-4d"], or
  @pyret-method["Tensor" "reshape"] to change the shape of a @pyret{Tensor}
  after instantiating it.

  @function["make-scalar"]

  Creates a new @pyret{Tensor} of rank-0 with the given @pyret{value}.

  The same functionality can be achieved with the @pyret-id["tensor"]
  constructor and the @pyret-method["Tensor" "as-scalar"] method, but it's
  recommended to use @pyret-id["make-scalar"] as it makes the code more
  readable.

  @function["random-normal"]

  Creates a new @pyret{Tensor} with the given shape (represented as values in
  the input @pyret{List}) where all of the values are sampled from a normal
  distribution.

  @function["make-variable"]

  Creates a new, mutable @pyret{Tensor} initialized to the values of the input
  @pyret{Tensor}.

  The same functionality can be achieved with the
  @pyret-method["Tensor" "to-variable"] method.

  @;#########################################################################
  @section{Tensor Methods}

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
      one-dim = [TF.tensor: 1]
      one-dim.as-scalar().shape() is empty
      one-dim.shape() is [list: 1] # doesn't modify shape of original tensor

      two-dim = [TF.tensor: 1, 2]
      two-dim.as-scalar() raises
        "Tensor was size-2 but `as-scalar` requires the tensor to be size-1"
    end
  }

  @tensor-method["as-1d"]

  Constructs a new, rank-1 @pyret{Tensor} from the values of the original
  @pyret{Tensor}.

  The same functionality can be achieved with @pyret-method["Tensor" "reshape"],
  but it's recommended to use @pyret-method["Tensor" "as-1d"] as it makes the
  code more readable.

  @tensor-method["as-2d"]

  Constructs a new, rank-2 @pyret{Tensor} with the input dimensions from the
  values of the original @pyret{Tensor}.

  The number of elements implied by the input dimensions must be the same as the
  number of elements in the calling @pyret{Tensor}. Otherwise, the method
  raises an error.

  The same functionality can be achieved with @pyret-method["Tensor" "reshape"],
  but it's recommended to use @pyret-method["Tensor" "as-2d"] as it makes the
  code more readable.

  @tensor-method["as-3d"]

  Constructs a new, rank-3 @pyret{Tensor} with the input dimensions from the
  values of the original @pyret{Tensor}.

  The number of elements implied by the input dimensions must be the same as the
  number of elements in the calling @pyret{Tensor}. Otherwise, the method
  raises an error.

  The same functionality can be achieved with @pyret-method["Tensor" "reshape"],
  but it's recommended to use @pyret-method["Tensor" "as-3d"] as it makes the
  code more readable.

  @tensor-method["as-4d"]

  Constructs a new, rank-4 @pyret{Tensor} with the input dimensions from the
  values of the original @pyret{Tensor}.

  The number of elements implied by the input dimensions must be the same as the
  number of elements in the calling @pyret{Tensor}. Otherwise, the method
  raises an error.

  The same functionality can be achieved with @pyret-method["Tensor" "reshape"],
  but it's recommended to use @pyret-method["Tensor" "as-4d"] as it makes the
  code more readable.

  @tensor-method["as-type"]

  Constructs a new @pyret{Tensor} from the values of the original
  @pyret{Tensor} with all of the values cast to the input datatype.

  The possible @pyret{data-type}s are @pyret{"float32"}, @pyret{"int32"}, or
  @pyret{"bool"}. Any other @pyret{dataType} will raise an error.

  @tensor-method["data-sync"]

  Returns a @pyret{List} containing the data in the @pyret{Tensor}.

  The "@pyret{-sync}" part of the method name is a remnant of the Tensorflow.js
  naming scheme.

  @tensor-method["to-float"]

  Constructs a new @pyret{Tensor} from the values of the original
  @pyret{Tensor} with all of the values cast to the @tt{"float32"} datatype.

  @tensor-method["to-int"]

  Constructs a new @pyret{Tensor} from the values of the original
  @pyret{Tensor} with all of the values cast to the @tt{"int32"} datatype.

  @tensor-method["to-bool"]

  Constructs a new @pyret{Tensor} from the values of the original
  @pyret{Tensor} with all of the values cast to the @tt{"bool"} datatype.

  @tensor-method["to-variable"]

  Constructs a new, mutable @pyret{Tensor} from the values of the original
  @pyret{Tensor}.

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

  @tensor-method["clone"]

  Constructs a new @pyret{Tensor} that is a copy of the original @pyret{Tensor}.

  @;#########################################################################
  @section{Arithmetic Operations}

  @function["add-tensors"]

  Adds two @pyret{Tensor}s element-wise, A + B.

  To assert that @pyret{a} and @pyret{b} are the same shape, use
  @pyret-id["strict-add-tensors"].

  @function["subtract-tensors"]

  Subtracts two @pyret{Tensor}s element-wise, A – B.

  To assert that @pyret{a} and @pyret{b} are the same shape, use
  @pyret-id["strict-subtract-tensors"].

  @function["multiply-tensors"]

  Multiplies two @pyret{Tensor}s element-wise, A * B.

  To assert that @pyret{a} and @pyret{b} are the same shape, use
  @pyret-id["strict-multiply-tensors"].

  @function["divide-tensors"]

  Divides two @pyret{Tensor}s element-wise, A / B.

  To assert that @pyret{a} and @pyret{b} are the same shape, use
  @pyret-id["strict-divide-tensors"].

  @function["floor-divide-tensors"]

  Divides two @pyret{Tensor}s element-wise, A / B, with the result rounded
  with the floor function.

  @function["tensor-max"]

  Returns a @pyret{Tensor} containing the maximum of @pyret{a} and @pyret{b},
  element-wise.

  To assert that @pyret{a} and @pyret{b} are the same shape, use
  @pyret-id["strict-tensor-max"].

  @function["tensor-min"]

  Returns a @pyret{Tensor} containing the minimum of @pyret{a} and @pyret{b},
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
  @section{Basic Math Operations}

  @function["tensor-abs"]

  Computes the absolute value of the @pyret{Tensor}, element-wise.

  @function["tensor-acos"]

  Computes the inverse cosine of the @pyret{Tensor}, element-wise.

  @function["tensor-acosh"]

  Computes the inverse hyperbolic cosine of the @pyret{Tensor}, element-wise.

  @function["tensor-asin"]

  Computes the inverse sine of the @pyret{Tensor}, element-wise.

  @function["tensor-asinh"]

  Computes the inverse hyperbolic sine of the @pyret{Tensor}, element-wise.

  @function["tensor-atan"]

  Computes the inverse tangent of the @pyret{Tensor}, element-wise.

  @function["tensor-atan2"]

  Computes the @link["https://en.wikipedia.org/wiki/Atan2"
  "four-quadrant inverse tangent"] of @pyret{a} and @pyret{b}, element-wise.

  @function["tensor-atanh"]

  Computes the inverse hyperbolic tangent of the @pyret{Tensor}, element-wise.

  @function["tensor-ceil"]

  Computes the ceiling of the @pyret{Tensor}, element-wise.

  @function["clip-by-value"]

  Clips the values of the @pyret{Tensor}, element-wise, such that every element
  in the resulting @pyret{Tensor} is at least @pyret{min-value} and is at most
  @pyret{max-value}.

  @function["tensor-cos"]

  Computes the cosine of the @pyret{Tensor}, element-wise.

  @function["tensor-cosh"]

  Computes the hyperbolic cosine of the @pyret{Tensor}, element-wise.

  @function["exponential-linear-units"]

  Applies the @link["https://en.wikipedia.org/wiki/Rectifier_(neural_networks)#ELUs"
  "exponential linear units"] function to the @pyret{Tensor}, element-wise.

  @function["elu"]

  Alias for @pyret-id["exponential-linear-units"].

  @function["gauss-error"]

  Applies the @link["http://mathworld.wolfram.com/Erf.html" "gauss error function"]
  to the @pyret{Tensor}, element-wise.

  @function["erf"]

  Alias for @pyret-id["gauss-error"].

  @function["tensor-exp"]

  Computes the equivalent of @pyret{num-exp(tensor)}, element-wise.

  @function["tensor-exp-min1"]

  Computes the equivalent of @pyret{num-exp(tensor - 1)}, element-wise.

  @function["tensor-floor"]

  Computes the floor of the @pyret{Tensor}, element-wise.

  @function["leaky-relu"]

  Applies a @link["https://en.wikipedia.org/wiki/Rectifier_(neural_networks)#Leaky_ReLUs"
  "leaky rectified linear units"] function to the @pyret{Tensor}, element-wise.

  @pyret{alpha} is the scaling factor for negative values. The default in
  TensorFlow.js is @pyret{0.2}, but the argument has been exposed here for more
  flexibility.

  @function["tensor-log"]

  Computes the natural logarithm of the @pyret{Tensor}, element-wise; that is,
  it computes the equivalent of @pyret{num-log(tensor)}.

  @function["tensor-log-plus1"]

  Computes the natural logarithm of the @pyret{Tensor} plus 1, element-wise;
  that is, it computes the equivalent of @pyret{num-log(tensor + 1)}.

  @function["log-sigmoid"]

  Applies the @link["https://en.wikibooks.org/wiki/Artificial_Neural_Networks/
  Activation_Functions#Continuous_Log-Sigmoid_Function" "log sigmoid"] function
  to the @pyret{Tensor}, element-wise.

  @function["tensor-negate"]

  Multiplies each element in the @pyret{Tensor} by @pyret{-1}.

  @function["parametric-relu"]

  Applies a @link["https://en.wikipedia.org/wiki/Rectifier_(neural_networks)#Leaky_ReLUs"
  "leaky rectified linear units"] function to the @pyret{Tensor}, element-wise,
  using parametric alphas.

  @pyret{alpha} is the scaling factor for negative values.

  @function["tensor-reciprocal"]

  Computes the reciprocal of the @pyret{Tensor}, element-wise; that is, it
  computes the equivalent of @pyret{1 / tensor}.

  @function["relu"]

  Applies a @link["https://en.wikipedia.org/wiki/Rectifier_(neural_networks)"
  "rectified linear units"] function to the @pyret{Tensor}, element-wise.

  @function["tensor-round"]

  Computes the equivalent of @pyret{num-round(tensor)}, element-wise.

  @function["reciprocal-sqrt"]

  Computes the recriprocal of the square root of the @pyret{Tensor},
  element-wise.

  The resulting @pyret{Tensor} is roughly equivalent to
  @pyret{tensor-reciprocal(tensor-sqrt(tensor))}.

  @function["scaled-elu"]

  Applies a scaled, exponential linear units function to the @pyret{Tensor},
  element-wise.

  @function["sigmoid"]

  Applies the sigmoid function to the @pyret{Tensor}, element-wise.

  @function["signed-ones"]

  Returns an element-wise indication of the sign of each number in the
  @pyret{Tensor}; that is, every value in the original tensor is represented
  in the resulting tensor as @pyret{~+1} if the value is positive, @pyret{~-1}
  if the value was negative, or @pyret{~0} if the value was zero or not a
  number.

  @function["tensor-sin"]

  Computes the sine of the @pyret{Tensor}, element-wise.

  @function["softplus"]

  Applies the @link["https://sefiks.com/2017/08/11/softplus-as-a-neural-networks-activation-function/"
  "softplus"] function to the @pyret{Tensor}, element-wise.

  @function["tensor-sqrt"]

  Computes the square root of the @pyret{Tensor}, element-wise.

  @function["tensor-square"]

  Computes the square of the @pyret{Tensor}, element-wise.

  @function["step"]

  Returns an element-wise indication of the sign of each number in the
  @pyret{Tensor}; that is, every value in the original tensor is represented
  in the resulting tensor as @pyret{~+1} if the value is positive; otherwise,
  it is represented as @pyret{~0}.

  @function["tensor-tan"]

  Computes the tangent of the @pyret{Tensor}, element-wise.

  @function["tensor-tanh"]

  Computes the hyperbolic tangent of the @pyret{Tensor}, element-wise.

  @;#########################################################################
  @section{Reduction Operations}

  @function["all"]
  @function["arg-max"]
  @function["arg-min"]
  @function["log-sum-exp"]
  @function["reduce-max"]
  @function["mean"]
  @function["reduce-min"]
  @function["reduce-sum"]

  @;#########################################################################
  @section{Models}

  @pyret{Model}s represent a collection of @pyret{Layers}, and define a series
  of inputs and outputs. They are one of the primary abstractions used in
  TensorFlow, and can be trained, evaluated, and used for prediction.

  There are two types of models in TensorFlow: @pyret{Sequential}, where
  the outputs of one @pyret{Layer} are the inputs to the next @pyret{Layer},
  and @pyret{Model}, which is more generic and supports arbitrary, non-cyclic
  graphs of @pyret{Layer}s.

  @type-spec["Model"]{

    A @pyret{Model} is a data structure that consists of @pyret{Layer}s and
    defines inputs and outputs. It is more generic than @pyret{Sequential}
    models as it supports arbitrary, non-cyclic graphs of @pyret{Layer}s.

  }

  @type-spec["Sequential"]{

    A @pyret{Sequential} model is a model where the outputs of one
    @pyret{Layer} are the inputs to the next @pyret{Layer}. That is, the model
    topology is a simple "stack" of layers, with no branching or skipping.

    As a result, the first layer passed to a @pyret{Sequential} model must
    have a defined input shape.

  }

  @;#########################################################################
  @section{Layers}

  @type-spec["Layer"]{

    Layers are the primary building block for constructing a @pyret{Model}. Each
    layer will typically perform some computation to transform its input to its
    output.

    Layers will automatically take care of creating and initializing the various
    internal variables/weights they need to function.

  }

  @;#########################################################################
  @section{Optimizers}

  @type-spec["Optimizer"]{

    Layers are the primary building block for constructing a @pyret{Model}. Each
    layer will typically perform some computation to transform its input to its
    output.

    Layers will automatically take care of creating and initializing the various
    internal variables/weights they need to function.

  }

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
      num-random(10000000) / 1000000
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
        ^ TF.mean(_)
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
      shadow m = m.data-sync().first
      shadow b = b.data-sync().first

      function-plot = C.from-list.function-plot(lam(x): (m * x) + b end)
      C.render-charts([list: scatter-plot, function-plot])
    end

    fun train-steps(steps :: Number) -> Image block:
      doc: "Trains the model `steps` times"
      for L.each(_ from L.range(0, steps)) block:
        train()
        print("y = " + num-to-string(m.data-sync().first) + "x + " + num-to-string(b.data-sync().first))
      end
      plot().get-image()
    end
  }
}
