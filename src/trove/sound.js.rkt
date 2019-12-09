#lang scribble/base
@(require "../../scribble-api.rkt"
          "../abbrevs.rkt"
          (prefix-in html: "../../manual-html.rkt")
          2htdp/image
          scribble/manual)

@(append-gen-docs
'(module "sound"
  (path "build/phase1/trove/sound.js")
  (fun-spec (name "make-single-channel-sound") (arity 2))
  (fun-spec (name "make-multi-channel-sound") (arity 2))
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
  (fun-spec (name "get-note") (arity 1))
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
  to +1. As a consequence, each sound in this library is characterized by a two-dimensional float array,
  where each row corresponds to the sound wave in a given channel. 
  
  The sound library is equipped with a widget that possesses media-player capabilities. Any object of the
  type 'sound', will automatically invoke the widget.

  @section[#:tag "sound_DataTypes"]{Data Types}
  @type-spec["Sound" (list)]{

    This data type is the standard representation in this library for a sound. 
    Imitating a real-world sound, this object is characterized by the two-dimensional
    float array of amplitudes, the sample rate, the duration, and the number of channels.

    The sample rate of a sound needs to be within the permissible range of 3000 to 384000.

    The duration is mentioned in terms of seconds.

    The number of channels is an integer.

    'Sound' is the return type of many of the functions in this module; it
    includes simple sounds, and also combinations or transformations of 
    existing sounds, like overlays, concatenations, and scaling. 
    }

  @section{Basic Sounds}
  @function[
    "make-single-channel-sound"
            #:contract (a-arrow N (RA-of (RA-of N)) Sound)
            #:return Sound   
            #:args (list '("sample_rate" "")
                         '("data_array" "") )]{
              Primary function to construct a sound from scratch using the given sample rate and data array.
              
              The sample rate of a sound needs to be within the permissible range of 3000 to 384000.

              The data array is a 1 - Dimensional float array, where the elements  
              correspond to the amplitudes of the sound wave present in that channel.

              @(image "src/builtin/soundwave.PNG")
            }
  @function[
    "make-multi-channel-sound"
            #:contract (a-arrow N (RA-of (RA-of N)) Sound)
            #:return Sound   
            #:args (list '("sample_rate" "")
                         '("data_array" "") )]{
              Primary function to construct a sound from scratch using the given sample rate and data array.
              
              The sample rate of a sound needs to be within the permissible range of 3000 to 384000.

              The data array is a 2 - Dimensional float array, where the elements of each row of this array 
              corresponds to the amplitudes of the sound wave present in that channel.

              @(image "src/builtin/soundwave.PNG")
              @(image "src/builtin/soundwave.PNG")
            }
  @function[
    "get-sound-from-url"
            #:contract (a-arrow S Sound)
            #:return Sound   
            #:args (list '("path" ""))]{
              Constructs a sound object from a given URL resource that points to a .wav audio file.
              The URL is passed as a string parameter.

            }
            @codeblock|{
                urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
            }|

  @section{Sound Buffers}
  @function[
    "get-array-from-sound"
            #:contract (a-arrow Sound (RA-of (RA-of N)))
            #:return Sound   
            #:args (list '("sound" ""))]{
              Returns the two-dimensional / single-dimensional float array of the given sound.
              
            }
            @codeblock|{
                urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                numArray = S.get-array-from-sound(urlSound)
            }|

  @function[
    "denormalize-sound"
            #:contract (a-arrow Sound (RA-of (RA-of N)))
            #:return Sound   
            #:args (list '("buffer" ""))]{
              Normalization is the process of transforming / scaling the amplitudes of a sound to 
              fall between the range of -1 to +1. Note that a given sound is normalized by default. 
              The above function denormalizes the given sound and returns the result as a new sound. 

              Please note that the array returned by a denormalized sound will have amplitude values 
              that are outside the range of -1 to +1. However, while playing the sound, the internal
              sound API automatically clamps the values that fall out of this range, in order to play it as a valid sound. 
              One can observe these non-compliant points being plotted as red dots on the widget. 

            }
            @codeblock|{
                urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                normSound = S.denormalize-sound(urlSound)
            }|

  @section{Overlaying Sounds}
  @function[
    "overlay"
            #:contract (a-arrow (L-of Sound) Sound)
            #:return Sound   
            #:args (list '("samples" ""))]{
              Places one sound over another, and is the equivalent of an addition operation 
              between the amplitudes of a set of sounds. The Overlay function requires a 
              list of sound objects that need to be overlayed, and returns the result as a new sound.

              Given below are two individual sound objects, and the sound resulting from an 
              overlay of these two sounds. A practical application of this function is when we want to 
              overlay the sounds being played by different instruments for one one song.

              @(image "src/builtin/overlayone.PNG")

              @(image "src/builtin/overlaytwo.PNG")

              @(image "src/builtin/overlayed.PNG")

            }
            @codeblock|{
                soundA = S.get-note("A3")
                soundB = S.get-note("A1")
                soundList = [L.list: a,b]
                soundC = S.overlay(soundList)
            }|

  @section{Concatenating Sounds}
  @function[
    "concat"
            #:contract (a-arrow (L-of Sound) Sound)
            #:return Sound   
            #:args (list '("samples" ""))]{
              Concatenates different sounds together as one long sound. The function requires a 
              list of sound objects in the order in which they need to be concatenated. It then 
              returns the result as a new sound.

              Given below are two individual sound objects, and the sound resulting from a
              concatenation of these two sounds.

              @(image "src/builtin/overlayone.PNG")

              @(image "src/builtin/overlaytwo.PNG")

              @(image "src/builtin/concated.PNG")
            }
            @codeblock|{
                soundA = S.get-note("A3")
                soundB = S.get-note("A1")
                soundList = [L.list: a,a,a,b,a,a,a]
                soundC = S.concat(soundList)
            }|

  @section{Scaling, and Shortening Sounds}
  @function[
    "set-playback-speed"
            #:contract (a-arrow Sound N Sound)
            #:return Sound   
            #:args (list '("sample" "")
                         '("rate" ""))]{
              Constructs a sound that plays at the new rate given by the playback speed, such as 2X, 3X etc.
              It takes a sound object and an integer number that specifies the factor by which the sound needs 
              to be sped up or slowed down. It then returns a resultant new sound object.

            }
            
            @codeblock|{
                soundA = S.get-note("A3")
                soundC = S.set-playback-speed(soundA, 3)
            }|
  @function[
    "shorten"
            #:contract (a-arrow Sound N N Sound)
            #:return Sound   
            #:args (list '("sample" "")
                         '("start" "")
                         '("end" ""))]{
              Shortens a sound to a new sound based on the given start and end time. In other words, 
              it crops the sound to the specified interval.

            }
            @codeblock|{
                urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                soundC = S.set-playback-speed(urlSound, 1, 2)
            }|
  @section{Starter Sound Waves and Tones}
  @function[
    "get-cosine-wave"
            #:contract (a-arrow Sound)
            #:return Sound   
            #:args (list )]{
              Constructs a default cosine wave with frequency of 440Hz.

            }
            @codeblock|{
                soundC = S.get-cosine-wave()
            }|
  @function[
    "get-sine-wave"
            #:contract (a-arrow Sound)
            #:return Sound   
            #:args (list )]{
              Constructs a default sine wave with frequency of 440Hz.

            }
            @codeblock|{
                soundC = S.get-sine-wave()
            }|
  @function[
    "get-tone"
            #:contract (a-arrow S Sound)
            #:return Sound   
            #:args (list '("key" ""))]{
              Constructs a sound tone of an octave of the given key, such as A4, C8 etc. 
              Concatenation of several tones will result in one long set of beeps with no pauses in between.

              @(image "src/builtin/overlayone.PNG")
            }
            @codeblock|{
                soundC = S.get-tone("A4")
            }|

  @function[
    "get-note"
            #:contract (a-arrow S Sound)
            #:return Sound   
            #:args (list '("key" ""))]{
              Constructs a sound note of an octave of the given key, such as A4, C8 etc, with a 
              tangible silence in the end. Hence, it works like a typical press of a piano key. 
              Concatenation of several notes will result in a melody akin to playing notes on a piano.

              @(image "src/builtin/getnote.PNG")
            }
            @codeblock|{
                soundC = S.get-note("A4")
            }|
  @section{Fading Sounds}
  @function[
    "fade"
            #:contract (a-arrow Sound Sound)
            #:return Sound   
            #:args (list '("sound" ""))]{
              Progressively fades a given sound towards the end and returns the result as a new sound.

              @(image "src/builtin/fade.PNG")
            }
            
            @codeblock|{
                urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                soundC = S.fade(urlSound)
            }|
  @section{Removing Vocals}
  @function[
    "remove-vocals"
            #:contract (a-arrow Sound Sound)
            #:return Sound   
            #:args (list '("sound" ""))]{
              Removes vocals from the given sound and returns the result.

              @codeblock|{
                urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                soundC = S.removeVocals(urlSound)
              }|

            }
}