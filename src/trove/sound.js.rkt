#lang scribble/base
@(require "../../scribble-api.rkt"
          "../abbrevs.rkt"
          (prefix-in html: "../../manual-html.rkt")
          2htdp/image
          scribble/manual)

@(append-gen-docs
'(module "sound"
  (path "build/phase1/trove/sound.js")
  (fun-spec (name "makeSound") (arity 2))
  (fun-spec (name "getSoundFromURL") (arity 1))
  (fun-spec (name "getBufferFromURL") (arity 1))
  (fun-spec (name "getBufferFromSound") (arity 1))
  (fun-spec (name "denormalizeSound") (arity 1))
  (fun-spec (name "getSoundFromAudioBuffer") (arity 1))
  (fun-spec (name "overlay") (arity 1))
  (fun-spec (name "concat") (arity 1))
  (fun-spec (name "setPlaybackSpeed") (arity 2))
  (fun-spec (name "shorten") (arity 3))
  (fun-spec (name "getCosineWave") (arity 0))
  (fun-spec (name "getSineWave") (arity 0))
  (fun-spec (name "getTone") (arity 1))
  (fun-spec (name "fade") (arity 1))
  (fun-spec (name "removeVocals") (arity 1))
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
    "makeSound"
            #:contract (a-arrow N (A-of (A-of N)) Sound)
            #:return Sound   
            #:args (list '("sample_rate" "")
                         '("data_array" "") )]{
              Constructs a sound with the given sample rate and data array.
            }
  @function[
    "getSoundFromURL"
            #:contract (a-arrow S Sound)
            #:return Sound   
            #:args (list '("path" ""))]{
              Constructs a sound object from the given url path.
            }

  @section{Sound Buffers}
  @function[
    "getBufferFromURL"
            #:contract (a-arrow S Sound)
            #:return Sound   
            #:args (list '("path" ""))]{
              Constructs a sound buffer from the given url path.
            }
  @function[
    "getBufferFromSound"
            #:contract (a-arrow Sound AudioBuffer)
            #:return Sound   
            #:args (list '("sound" ""))]{
              Constructs a andio buffer from the given sound.
            }
  @function[
    "getSoundFromAudioBuffer"
            #:contract (a-arrow AudioBuffer Sound)
            #:return Sound   
            #:args (list '("buffer" ""))]{
              Constructs a sound from the given audio buffer.
            }
  @function[
    "denormalizeSound"
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
    "setPlaybackSpeed"
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
    "getCosineWave"
            #:contract (a-arrow Sound)
            #:return Sound   
            #:args (list )]{
              Constructs consine waves.
            }
  @function[
    "getSineWave"
            #:contract (a-arrow Sound)
            #:return Sound   
            #:args (list )]{
              Constructs sine waves.
            }
  @function[
    "getTone"
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
    "removeVocals"
            #:contract (a-arrow Sound Sound)
            #:return Sound   
            #:args (list '("sound" ""))]{
              Removes vocals from the given sound and returns the result.
            }
}