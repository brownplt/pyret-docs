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
  (fun-spec (name "make-multi-channel-sound") (arity 2))
  (fun-spec (name "get-sound-from-url") (arity 1))
  (fun-spec (name "get-multi-channel-data-arrays") (arity 1))
  (fun-spec (name "get-channel-data-array") (arity 2))
  (fun-spec (name "sound-duration") (arity 1))
  (fun-spec (name "sound-sample-rate") (arity 1))
  (fun-spec (name "sound-num-channels") (arity 1))
  (fun-spec (name "sound-num-samples") (arity 1))
  (fun-spec (name "is-sound") (arity 1))
  (fun-spec (name "sounds-equal") (arity 2))
  (fun-spec (name "normalize-sound") (arity 1))
  (fun-spec (name "overlay") (arity 2))
  (fun-spec (name "concat") (arity 2))
  (fun-spec (name "overlay-list") (arity 1))
  (fun-spec (name "concat-list") (arity 1))
  (fun-spec (name "adjust-playback-speed") (arity 2))
  (fun-spec (name "set-sample-rate") (arity 2))
  (fun-spec (name "crop-by-time") (arity 3))
  (fun-spec (name "crop-by-index") (arity 3))
  (fun-spec (name "get-cosine-wave") (arity 1))
  (fun-spec (name "get-sine-wave") (arity 1))
  (fun-spec (name "get-tone") (arity 2))
  (fun-spec (name "get-note") (arity 3))
  (fun-spec (name "fade-in") (arity 1))
  (fun-spec (name "fade-in-by-index") (arity 2))
  (fun-spec (name "fade-in-by-time") (arity 2))
  (fun-spec (name "fade-out") (arity 1))
  (fun-spec (name "fade-out-by-index") (arity 2))
  (fun-spec (name "fade-out-by-time") (arity 2))
  ; (fun-spec (name "remove-vocals") (arity 1))
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
    "make-sound"
            #:contract (a-arrow N (RA-of N) Sound)
            #:return Sound   
            #:args (list '("sample_rate" "")
                         '("data_array" "") )]{
              Primary function to construct a sound from scratch using the given sample rate and data array.
              
              The sample rate of a sound needs to be within the permissible range of 3000 to 384000.

              The data array is a 1 - Dimensional float array, where the elements  
              correspond to the amplitudes of the sound wave present in that channel.

            }

            @repl-examples[
            `(@{soundA = S.make-sound(3000, [G.raw-array: 0.1, 0.2, 0.3, 0.1])}, @image[#:scale 0.5 "src/builtin/soundwave.PNG"])
             ]

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
            }

            @repl-examples[
            `(@{soundB = S.make-multi-channel-sound(3000, [G.raw-array: 
            [G.raw-array: 0.1, 0.2, 0.3, 0.1], [G.raw-array: -0.2, -0.3, -0.1, 0.5]])}, 
            @image[#:scale 0.35 "src/builtin/multichannel.png"])
             ]
  @function[
    "get-sound-from-url"
            #:contract (a-arrow S Sound)
            #:return Sound   
            #:args (list '("path" ""))]{
              Constructs a sound object from a given URL resource that points to a .wav audio file.
              The URL is passed as a string parameter.

            }
             @repl-examples[
            `(@{urlSound = 
            S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")}, 
            @image[#:scale 0.35 "src/builtin/urlsound.png"])
             ]

  @section{Sound Properties}
  @function[
    "get-multi-channel-data-arrays"
            #:contract (a-arrow Sound (RA-of (RA-of N)))
            #:return (RA-of N)   
            #:args (list '("sound" ""))]{
              Returns the two-dimensional / single-dimensional float array of the given sound.
              
            }
            @examples{
            urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
            numArray = S.get-multi-channel-data-arrays(urlSound)} 


  @function[
    "get-channel-data-array"
            #:contract (a-arrow Sound N (RA-of N) )
            #:return (RA-of N)  
            #:args (list '("sound" "")
                         '("channel" ""))]{
              Returns the single-dimensional float array of the given channel of a given sound.
              
            }
            @examples{
            urlSound = 
            S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
            numArray = S.get-channel-data-array(urlSound)
             }

  @function[
    "sound-duration"
            #:contract (a-arrow Sound N)
            #:return N   
            #:args (list '("sound" ""))]{
              Returns the duration of a given sound in seconds.
              
            }
            @examples{
                urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                duration = S.sound-duration(urlSound)
            }
  @function[
    "sound-sample-rate"
            #:contract (a-arrow Sound N)
            #:return N   
            #:args (list '("sound" ""))]{
              Returns the sample rate (number of samples per second) of a given sound, which is necessarily the frequency of a sound in Hz.
              
            }
            @examples{
                urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                sampleRate = S.sound-sample-rate(urlSound)
            }
  @function[
    "set-sample-rate"
            #:contract (a-arrow Sound N Sound)
            #:return Sound   
            #:args (list '("sound" "")
            '("sampleRate" ""))]{
              Sets / Updates the sample rate (number of samples per second) of a given sound, 
              and returns the new sound.
              
            }
            @examples{
                urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                newSound = S.set-sample-rate(urlSound, 10000)
            }
  @function[
    "sound-num-channels"
            #:contract (a-arrow Sound N)
            #:return N  
            #:args (list '("sound" ""))]{
              Returns the number of channels present in a given sound.
              
            }
            @examples{
                urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                numChannels = S.sound-num-channels(urlSound)
            }
  @function[
    "sound-num-samples"
            #:contract (a-arrow Sound N)
            #:return N   
            #:args (list '("sound" ""))]{
              Returns the number of samples or the size of the float array of the very first channel present in a given sound.
              
            }
            @examples{
                urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                numSamples = S.sound-num-samples(urlSound)
            }
  @function[
    "is-sound"
            #:contract (a-arrow A B)
            #:return B  
            #:args (list '("thing" ""))]{
              Validates if a given object is of a valid sound type.
              
            }
            @examples{
                urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                val = S.is-sound(urlSound)
            } 
  @function[
    "sounds-equal"
            #:contract (a-arrow Sound Sound B)
            #:return B  
            #:args (list '("sound1" "")
                         '("sound2" ""))]{
              Specifies if two given sound objects are equal.
              
            }
            @examples{
                urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                urlSound2 = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                val = S.sounds-equal(urlSound, urlSound2)
            }         
  @function[
    "normalize-sound"
            #:contract (a-arrow Sound Sound)
            #:return Sound   
            #:args (list '("sound" ""))]{
              Normalization is the process of transforming / scaling the amplitudes of a sound to 
              fall between the range of -1 to +1. 

              Please note that the array returned by a sound that is not normalized will have amplitude values 
              that are outside the range of -1 to +1. However, while playing the sound, the internal
              sound API automatically clamps the values that fall out of this range, in order to play it as a valid sound. 
              One can observe these non-compliant points being plotted as red dots on the widget. 

            }
            @examples{
                urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                normSound = S.normalize-sound(urlSound)
            }

  @section{Overlaying Sounds}

    @function[
    "overlay"
            #:contract (a-arrow Sound Sound Sound)
            #:return Sound   
            #:args (list '("sound1" "")
                         '("sound2" ""))]{
              Places one sound over another, and is the equivalent of an addition operation 
              between the amplitudes of a set of sounds. The function requires two 
              sound objects that need to be overlayed, and returns the result as a new sound.

              Given below are two individual sound objects, and the sound resulting from an 
              overlay of these two sounds. A practical application of this function is when we want to 
              overlay the sounds being played by different instruments for one one song.

            }
            @repl-examples[
            `(@{soundA = S.get-note("A3", 0.5, 0.25)}, 
            @image[#:scale 0.5 "src/builtin/overlayone.PNG"])
            `(@{soundB = S.get-note("A1", 0.5, 0.25)}, 
            @image[#:scale 0.5 "src/builtin/overlaytwo.PNG"])
            `(@{soundC = S.overlay(soundA, soundB)}, 
            @image[#:scale 0.5 "src/builtin/overlayed.PNG"])
             ]   

  @function[
    "overlay-list"
            #:contract (a-arrow (RA-of Sound) Sound)
            #:return Sound   
            #:args (list '("samples" ""))]{
              Places one sound over another, and is the equivalent of an addition operation 
              between the amplitudes of a set of sounds. The function requires a 
              list of sound objects that need to be overlayed, and returns the result as a new sound.

              Given below are two individual sound objects, and the sound resulting from an 
              overlay of these two sounds. A practical application of this function is when we want to 
              overlay the sounds being played by different instruments for one one song.

            }
            @examples{
                soundA = S.get-note("A3", 0.5, 0.25)
                soundB = S.get-note("A1", 0.5, 0.25)
                soundList = [G.raw-array: soundA, soundB]
                soundC = S.overlay(soundList)
            }
            @repl-examples[
            `(@{soundA = S.get-note("A3", 0.5, 0.25)}, 
            @image[#:scale 0.5 "src/builtin/overlayone.PNG"])
            `(@{soundB = S.get-note("A1", 0.5, 0.25)}, 
            @image[#:scale 0.5 "src/builtin/overlaytwo.PNG"])
            `(@{soundList = [G.raw-array: soundA, soundB]
                soundC = S.overlay(soundList)}, 
            @image[#:scale 0.5 "src/builtin/overlayed.PNG"])
             ]    

    @function[
    "concat"
            #:contract (a-arrow Sound Sound Sound)
            #:return Sound   
            #:args (list '("sound1" "")
                         '("sound2" ""))]{
              Concatenates different sounds together as one long sound. The function requires a 
              list of sound objects in the order in which they need to be concatenated. It then 
              returns the result as a new sound.

              Given below are two individual sound objects, and the sound resulting from a
              concatenation of these two sounds.

            }
            @repl-examples[
            `(@{soundA = S.get-note("A3", 0.5, 0.25)}, 
            @image[#:scale 0.5 "src/builtin/overlayone.PNG"])
            `(@{soundB = S.get-note("A1", 0.5, 0.25)}, 
            @image[#:scale 0.5 "src/builtin/overlaytwo.PNG"])
            `(@{soundC = S.concat(soundA, soundB)}, 
            @image[#:scale 0.5 "src/builtin/concated.PNG"])
             ]     


  @section{Concatenating Sounds}
  @function[
    "concat-list"
            #:contract (a-arrow (RA-of Sound) Sound)
            #:return Sound   
            #:args (list '("samples" ""))]{
              Concatenates different sounds together as one long sound. The function requires a 
              list of sound objects in the order in which they need to be concatenated. It then 
              returns the result as a new sound.

              Given below are two individual sound objects, and the sound resulting from a
              concatenation of these two sounds.

            }
            @repl-examples[
            `(@{soundA = S.get-note("A3", 0.5, 0.25)}, 
            @image[#:scale 0.5 "src/builtin/overlayone.PNG"])
            `(@{soundB = S.get-note("A1", 0.5, 0.25)}, 
            @image[#:scale 0.5 "src/builtin/overlaytwo.PNG"])
            `(@{soundList = [G.raw-array: soundA, soundB]
                soundC = S.concat(soundList)}, 
            @image[#:scale 0.5 "src/builtin/concated.PNG"])
             ]       


  @section{Scaling, and Cropping Sounds}
  @function[
    "adjust-playback-speed"
            #:contract (a-arrow Sound N Sound)
            #:return Sound   
            #:args (list '("sample" "")
                         '("rate" ""))]{
              Constructs a sound that plays at the new rate given by the playback speed, such as 2X, 3X etc.
              It takes a sound object and an integer number that specifies the factor by which the sound needs 
              to be sped up or slowed down. It then returns a resultant new sound object.

            }
            
            @examples{
                soundA = S.get-note("A3", 0.5, 0.25)
                soundC = S.adjust-playback-speed(soundA, 3)
            }


  @function[
    "crop-by-time"
            #:contract (a-arrow Sound N N Sound)
            #:return Sound   
            #:args (list '("sample" "")
                         '("start" "")
                         '("end" ""))]{
              Crops a sound to a new sound based on the given start and end time. 

            }
            @examples{
                urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                soundC = S.crop-by-time(urlSound, 1, 2)
            }
  @function[
    "crop-by-index"
            #:contract (a-arrow Sound N N Sound)
            #:return Sound   
            #:args (list '("sample" "")
                         '("start" "")
                         '("end" ""))]{
              Crops a sound to a new sound based on the given start and end index for the float array. 

            }
            @examples{
                urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                soundC = S.crop-by-index(urlSound, 20, 100)
            }
  @section{Starter Sound Waves and Tones}
  @function[
    "get-cosine-wave"
            #:contract (a-arrow N Sound)
            #:return Sound   
            #:args (list '("duration" ""))]{
              Constructs a default cosine wave of the given duration with frequency of 440Hz.

            }
            @examples{
                soundC = S.get-cosine-wave()
            }
  @function[
    "get-sine-wave"
            #:contract (a-arrow N Sound)
            #:return Sound   
            #:args (list '("duration" ""))]{
              Constructs a default sine wave of the given duration with frequency of 440Hz.

            }
            @examples{
                soundC = S.get-sine-wave()
            }
  @function[
    "get-tone"
            #:contract (a-arrow S N Sound)
            #:return Sound   
            #:args (list '("key" "")
            '("duration" ""))]{
              Constructs a sound tone of the given duration of an octave of the given key, such as A4, C8 etc. 
              Concatenation of several tones will result in one long set of beeps with no pauses in between.

            }

            @repl-examples[
            `(@{soundC = S.get-tone("A4", 0.5)}, 
            @image[#:scale 0.5 "src/builtin/overlayone.PNG"])
             ]   

  @function[
    "get-note"
            #:contract (a-arrow S N N Sound)
            #:return Sound   
            #:args (list '("key" "")
            '("durationOn" "")
            '("durationOff" ""))]{
              Constructs a sound note of the given durationOn of an octave of the given key, such as A4, C8 etc, with a 
              tangible silence of the given durationOff in the end. Hence, it works like a typical press of a piano key. 
              Concatenation of several notes will result in a melody akin to playing notes on a piano.
    
            }

            @repl-examples[
            `(@{soundC = S.get-note("A4", 0.5, 0.25)}, 
            @image[#:scale 0.5 "src/builtin/getnote.PNG"])
             ]   

  @section{Fading Sounds}
  @function[
    "fade-in"
            #:contract (a-arrow Sound Sound)
            #:return Sound   
            #:args (list '("sound" ""))]{
              Progressively fades in a given sound from the beginning towards the end and returns the result as a new sound.

            }

            @repl-examples[
            `(@{urlSound = S.get-tone("C3", 5)
                soundC = S.fade-in(urlSound)}, 
            @image[#:scale 0.35 "src/builtin/fadein.png"])
             ]   

      @function[
    "fade-in-by-index"
            #:contract (a-arrow Sound N Sound)
            #:return Sound   
            #:args (list '("sound" "")
            '("end" ""))]{
               Progressively fades in a given sound from the beginning towards the end index and returns the result as a new sound.

            }
            
            @repl-examples[
            `(@{urlSound = S.get-tone("C3", 5)
                soundC = S.fade-in-by-index(urlSound, 50000)}, 
            @image[#:scale 0.35 "src/builtin/fadeinindex.png"])
             ]   
  @function[
    "fade-in-by-time"
            #:contract (a-arrow Sound N Sound)
            #:return Sound   
            #:args (list '("sound" "")
            '("end" ""))]{
              Progressively fades in a given sound from the beginning towards the end time and returns the result as a new sound.

            }
            
            @repl-examples[
            `(@{urlSound = S.get-tone("C3", 5)
                soundC = S.fade-in-by-time(urlSound, 3)}, 
            @image[#:scale 0.35 "src/builtin/fadeintime.png"])
             ]  
          
  @function[
    "fade-out"
            #:contract (a-arrow Sound Sound)
            #:return Sound   
            #:args (list '("sound" ""))]{
              Progressively fades out a given sound towards the end and returns the result as a new sound.

            }

            @repl-examples[
            `(@{urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                soundC = S.fade-out(urlSound)}, 
            @image[#:scale 0.5 "src/builtin/fadeout.PNG"])
             ]   
  @function[
    "fade-out-by-index"
            #:contract (a-arrow Sound N Sound)
            #:return Sound   
            #:args (list '("sound" "")
            '("start" ""))]{
              Progressively fades out a given sound from the start index towards the end and returns the result as a new sound.

            }
            
            @repl-examples[
            `(@{urlSound = S.get-tone("C3", 5)
                soundC = S.fade-out-by-index(urlSound, 50000)}, 
            @image[#:scale 0.35 "src/builtin/fadeoutindex.png"])]

  @function[
    "fade-out-by-time"
            #:contract (a-arrow Sound N Sound)
            #:return Sound   
            #:args (list '("sound" "")
            '("start" ""))]{
              Progressively fades in a given sound from the start time towards the end and returns the result as a new sound.

            }
            
            @repl-examples[
            `(@{urlSound = S.get-sound-from-url("http://bbcsfx.acropolis.org.uk/assets/07075055.wav")
                soundC = S.fade-out-by-time(urlSound, 3)}, @image[#:scale 0.35 "src/builtin/fadeouttime.png"])]

}