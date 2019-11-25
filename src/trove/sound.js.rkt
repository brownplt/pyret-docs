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
  (fun-spec (name "get-buffer-from-url") (arity 1))
  (fun-spec (name "get-array-from-sound") (arity 1))
  (fun-spec (name "denormalize-sound") (arity 1))
  (fun-spec (name "get-sound-from-audio-buffer") (arity 1))
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
  (data-spec (name "AudioBuffer") (variants) (shared))
))
@(define Sound (a-id "Sound" (xref "sound" "Sound")))
@(define AudioBuffer (a-id "AudioBuffer" (xref "audiobuffer" "AudioBuffer")))

@docmodule["sound"]{

  The functions in this module are used for creating, combining, and displaying
  sounds.

  @section[#:tag "sound_DataTypes"]{Data Types}
  @type-spec["Sound" (list)]{

    This is the return type of many of the functions in this module; it
    includes simple sounds, and also combinations or transformations of 
    existing sounds, like overlays, concatenations, and scaling.
    }
  @type-spec["AudioBuffer" (list)]{

    The AudioBuffer represents a short audio asset residing in memory; it
    includes sample rate, channel data, and length.
    }

  @section{Basic Sounds}
  @function[
    "make-sound"
            #:contract (a-arrow N (RA-of (RA-of N)) Sound)
            #:return Sound   
            #:args (list '("sample_rate" "")
                         '("data_array" "") )]{
              Constructs a sound with the given sample rate and data array.
            }
  @function[
    "get-sound-from-url"
            #:contract (a-arrow S Sound)
            #:return Sound   
            #:args (list '("path" ""))]{
              Constructs a sound object from the given url path.
            }

  @section{Sound Buffers}
  @function[
    "get-buffer-from-url"
            #:contract (a-arrow S Sound)
            #:return Sound   
            #:args (list '("path" ""))]{
              Constructs a sound buffer from the given url path.
            }
  @function[
    "get-array-from-sound"
            #:contract (a-arrow Sound (RA-of (RA-of N)))
            #:return Sound   
            #:args (list '("sound" ""))]{
              Returns the data array of the given sound.
            }
  @function[
    "get-sound-from-audio-buffer"
            #:contract (a-arrow AudioBuffer Sound)
            #:return Sound   
            #:args (list '("buffer" ""))]{
              Constructs a sound from the given audio buffer.
            }
  @function[
    "denormalize-sound"
            #:contract (a-arrow AudioBuffer AudioBuffer)
            #:return Sound   
            #:args (list '("buffer" ""))]{
              Denormalizes the given audio buffer and returns the result as a new audio buffer.
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
              Constructs a sound with the given sample at the given rate.
            }
  @function[
    "shorten"
            #:contract (a-arrow Sound N N Sound)
            #:return Sound   
            #:args (list '("sample" "")
                         '("start" "")
                         '("end" ""))]{
              Shortens a sound with the given start and end time.
            }
  @section{Starter Sound Waves and Tones}
  @function[
    "get-cosine-wave"
            #:contract (a-arrow Sound)
            #:return Sound   
            #:args (list )]{
              Constructs consine waves.
            }
  @function[
    "get-sine-wave"
            #:contract (a-arrow Sound)
            #:return Sound   
            #:args (list )]{
              Constructs sine waves.
            }
  @function[
    "get-tone"
            #:contract (a-arrow S Sound)
            #:return Sound   
            #:args (list '("key" ""))]{
              Constructs a tone with the given key.
            }
  @section{Panning and Fading Sounds}
  @function[
    "fade"
            #:contract (a-arrow Sound Sound)
            #:return Sound   
            #:args (list '("sound" ""))]{
              Fades the given sound and returns the result.
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