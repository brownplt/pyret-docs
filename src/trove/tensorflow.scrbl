#lang scribble/manual
@(require "../../scribble-api.rkt" "../abbrevs.rkt")

@(define Tensor (a-id "Tensor" (xref "tensorflow" "Tensor")))
@(define Model (a-id "Model" (xref "tensorflow" "Model")))
@(define Layer (a-id "Layer" (xref "tensorflow" "Layer")))

@(define (tensor-method name)
  (method-doc "Tensor" #f name #:alt-docstrings ""))

@(append-gen-docs
  `(module "tensorflow"
    (path "src/arr/trove/tensorflow.arr")

    (fun-spec (name "tensor"))
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
          (args ("self" "dataType"))
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
          (args ("self" "newShape"))
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
      (name "multiply-tensors")
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
      (name "tensor-min")
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
      (name "tensor-expt")
      (arity 2)
      (args ("a" "b"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor ,Tensor)))
    (fun-spec
      (name "tensor-squared-difference")
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
      (arity 1)
      (args ("tensor"))
      (return ,Tensor)
      (contract
        (a-arrow ,Tensor ,Tensor)))
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

  @tensor-method["as-2d"]

  Constructs a new, rank-2 @pyret{Tensor} with the input dimensions from the
  values of the original @pyret{Tensor}.

  @tensor-method["as-3d"]

  Constructs a new, rank-3 @pyret{Tensor} with the input dimensions from the
  values of the original @pyret{Tensor}.

  @tensor-method["as-4d"]

  Constructs a new, rank-4 @pyret{Tensor} with the input dimensions from the
  values of the original @pyret{Tensor}.

  @tensor-method["as-type"]

  Constructs a new @pyret{Tensor} from the values of the original
  @pyret{Tensor} with all of the values cast to the input datatype.

  The possible @pyret{dataType}s are @pyret{"float32"}, @pyret{"int32"}, or
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

  Constructs a new @pyret{Tensor} with the input dimensions @pyret{newShape}
  from the values of the original @pyret{Tensor}.

  @tensor-method["clone"]

  Constructs a new @pyret{Tensor} that is a copy of the original @pyret{Tensor}.

  @;#########################################################################
  @section{Arithmetic Operations}

  @function["add-tensors"]

  Adds two @pyret{Tensor}s element-wise, A + B.

  @function["strict-add-tensors"]

  @function["subtract-tensors"]

  @function["multiply-tensors"]

  @function["divide-tensors"]

  @function["floor-divide-tensors"]

  @function["tensor-max"]

  @function["tensor-min"]

  @function["tensor-modulo"]

  @function["tensor-expt"]

  @function["tensor-squared-difference"]

  @;#########################################################################
  @section{Basic Math Operations}

  @function["tensor-abs"]
  @function["tensor-acos"]
  @function["tensor-acosh"]
  @function["tensor-asin"]
  @function["tensor-asinh"]
  @function["tensor-atan"]
  @function["tensor-atan2"]
  @function["tensor-atanh"]
  @function["tensor-ceil"]
  @function["clip-by-value"]
  @function["tensor-cos"]
  @function["tensor-cosh"]
  @function["exponential-linear-units"]
  @function["elu"]
  @function["erf"]
  @function["gauss-error"]
  @function["tensor-exp"]
  @function["tensor-exp-min1"]
  @function["tensor-floor"]
  @function["leaky-relu"]
  @function["tensor-log"]
  @function["tensor-log-plus1"]
  @function["log-sigmoid"]
  @function["tensor-negate"]
  @function["parametric-relu"]
  @function["tensor-reciprocal"]
  @function["relu"]
  @function["tensor-round"]
  @function["reciprocal-sqrt"]
  @function["scaled-elu"]
  @function["sigmoid"]
  @function["signed-ones"]
  @function["tensor-sin"]
  @function["softplus"]
  @function["tensor-sqrt"]
  @function["tensor-square"]
  @function["step"]
  @function["tensor-tan"]
  @function["tensor-tanh"]

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

  @type-spec["Model"]{
    Models are one of the primary abstractions used in TensorFlow. Models can be
    trained, evaluated, and used for prediction.

    Models represent a collection of @pyret{Layers}.
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
