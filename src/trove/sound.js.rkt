#lang scribble/base
@(require "../../scribble-api.rkt"
          "../abbrevs.rkt"
          (prefix-in html: "../../manual-html.rkt")
          2htdp/image
          scribble/manual)

@(append-gen-docs
'(module "sound"
  (path "build/phase1/trove/sound.js")
  (fun-spec (name "make-sound") (arity 2))
  (fun-spec (name "get-sound-from-url") (arity 1))
  (fun-spec (name "get-array-from-sound") (arity 1))
  (fun-spec (name "denormalize-sound") (arity 1))
  (fun-spec (name "overlay") (arity 1))
  (fun-spec (name "concat") (arity 1))
  (fun-spec (name "set-playback-speed") (arity 2))
  (fun-spec (name "shorten") (arity 3))
  (fun-spec (name "get-cosine-wave") (arity 0))
  (fun-spec (name "get-sine-wave") (arity 0))
  (fun-spec (name "get-tone") (arity 1))
  (fun-spec (name "fade") (arity 1))
  (fun-spec (name "remove-vocals") (arity 1))
  (data-spec (name "Sound") (variants) (shared))
))
@(define Sound (a-id "Sound" (xref "sound" "Sound")))
@(define AudioBuffer (a-id "AudioBuffer" (xref "audiobuffer" "AudioBuffer")))

@docmodule["sound"]{

  The functions in this module are responsible for the creation and manipulation of various types of sounds.
  
  A sound file can be visualized as a set of channels, each corresponding to a sound wave. Depending on the
  construction and framework, these channels serve varying purposes. In some cases, they may refer to the
  left and right stereo sound stream. In others, each channel may correspond to a different instrument. In
  many cases, a set of channels may contain very similar sounds that have been overlaid together to improve
  quality. This library is supported by an underlying infrastructure of the WebAudioAPI. Therefore, it is 
  equipped to handle only .wav files for uploads and downloads.

  A sound wave can be represented in a numeric form as a set of amplitudes whose values can range from -1
  to +1. As a consequence, each sound in this library is a characterized by a two-dimensional float array,
  where each row corresponds to the sound wave in a given channel. 
  
  The sound library is equipped with a widget that possesses media-player capabilities. Any object of the
  type 'sound', will automatically invoke the widget.

  @section[#:tag "sound_DataTypes"]{Data Types}
  @type-spec["Sound" (list)]{

    This data type is the standard representation in this library for a sound. 
    Imitating a real-world sound, this object is characterized by the two-dimensional
    float array of amplitudes, the sample rate, the duration, and the number of channels.

    This is the return type of many of the functions in this module; it
    includes simple sounds, and also combinations or transformations of 
    existing sounds, like overlays, concatenations, and scaling. 
    }

  @section{Basic Sounds}
  @function[
    "make-sound"
            #:contract (a-arrow N (RA-of (RA-of N)) Sound)
            #:return Sound   
            #:args (list '("sample_rate" "")
                         '("data_array" "") )]{
              Primary function to constructs a sound from scratch using the given sample rate and data array.
            }
  @function[
    "get-sound-from-url"
            #:contract (a-arrow S Sound)
            #:return Sound   
            #:args (list '("path" ""))]{
              Constructs a sound object from the given URL resource that points to a .wav audio file.
            }

  @section{Sound Buffers}
  @function[
    "get-array-from-sound"
            #:contract (a-arrow Sound (RA-of (RA-of N)))
            #:return Sound   
            #:args (list '("sound" ""))]{
              Returns the two-dimensional float array of the given sound.
            }
  @function[
    "denormalize-sound"
            #:contract (a-arrow Sound (RA-of (RA-of N)))
            #:return Sound   
            #:args (list '("buffer" ""))]{
              Denormalizes the given sound and returns the result as a new sound. Note that a given sound
              is normalized by default. 
            }
  @section{Overlaying Sounds}
  @function[
    "overlay"
            #:contract (a-arrow (L-of Sound) Sound)
            #:return Sound   
            #:args (list '("samples" ""))]{
              Overlays all sounds in the given sample list and returns the result as a new sound.
            }

  @section{Concatenating Sounds}
  @function[
    "concat"
            #:contract (a-arrow (L-of Sound) Sound)
            #:return Sound   
            #:args (list '("samples" ""))]{
              Concatenates all sounds in the given sample list in order and returns the result as a new sound.
            }
  @section{Scaling, and Shortening Sounds}
  @function[
    "set-playback-speed"
            #:contract (a-arrow Sound N Sound)
            #:return Sound   
            #:args (list '("sample" "")
                         '("rate" ""))]{
              Constructs a sound that plays at the new rate given by the playback speed, such as 2X, 3X etc.
            }
  @function[
    "shorten"
            #:contract (a-arrow Sound N N Sound)
            #:return Sound   
            #:args (list '("sample" "")
                         '("start" "")
                         '("end" ""))]{
              Shortens a sound to a new sound based on the given start and end time. In other words, 
              it crops the sound to specified interval.
            }
  @section{Starter Sound Waves and Tones}
  @function[
    "get-cosine-wave"
            #:contract (a-arrow Sound)
            #:return Sound   
            #:args (list )]{
              Constructs a default cosine wave with frequency of 440Hz.
            }
  @function[
    "get-sine-wave"
            #:contract (a-arrow Sound)
            #:return Sound   
            #:args (list )]{
              Constructs a default sine wave with frequency of 440Hz.
            }
  @function[
    "get-tone"
            #:contract (a-arrow S Sound)
            #:return Sound   
            #:args (list '("key" ""))]{
              Constructs a sound tone of an octave of the given key, such as A4, C8 etc.
            }
  @section{Panning and Fading Sounds}
  @function[
    "fade"
            #:contract (a-arrow Sound Sound)
            #:return Sound   
            #:args (list '("sound" ""))]{
              Progressively fades a given sound and returns the result.
            }
  @section{Removing Vocals}
  @function[
    "remove-vocals"
            #:contract (a-arrow Sound Sound)
            #:return Sound   
            #:args (list '("sound" ""))]{
              Removes vocals from the given sound and returns the result.
            }
}