#lang scribble/base

@(define (version . t)
   (apply section "Version: " t))

@require{lib.rkt}

@title{Tutorial: Your First Song - Jingle Bells}

@(table-of-contents)

@section{Introduction}

In this tutorial we're going to write a program that constructs and plays the song -  
Jingle Bells on Pyret. The tutorial is built to facilitate the simple construction of a 
single line, but it'll have all the elements you need to build much sounds of your own.

@section{About the Pyret Sound Library}

The Pyret Sound Library is responsible for the creation and manipulation of various types of sounds.
  
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

@section{Preliminaries}

To begin with, we should inform Pyret that we plan to make use of the
sound library. Additionally we require the List and Global libraries.
@pydisp{
import global as G
import sound as S
import list as L
}
This tells Pyret to load to these three libraries and bind the results
to the corresponding names, @pyin{G}, @pyin{S} and @pyin{L}. Thus, all sound
operations are obtained from @pyin{S} and list operations from
@pyin{L}.

@section{Constructing the sound}
In this case, each note in the song can be visualized as pressing an octave key on a piano.
Once we have the individual notes, we can then append them together to construct the sound. 
However, one would have to be cognizant of the pauses in the song, and insert appropriate 
gaps of silence in between notes. One we have the song, we could further add in additional 
instrument backgrounds using overlaying, and also fad the final output towards the end, 
like a typical song.  

@subsection{Creating notes}

We will use the get-note funstion of the Sound library to create a note. This constructs 
a sound note of an octave of the given key, such as A4, C8 etc, with a tangible silence in the end. 
Hence, it works like a typical press of a piano key. Concatenation of several notes will result in a melody akin to playing notes on a piano.
Consider the following code that creates a note of keys A3, A1 and C3:

@pydisp{
a = S.get-note("A3")
b = S.get-note("A1")
c = S.get-note("C3")
}

@subsection{Concatenating notes}

Now we're ready to draw append these notes together, to create a line of music. For this,
we will use the concat function of the Sound library. This function concatenates different 
sounds together as one long sound. The function requires a list of sound objects in the order 
in which they need to be concatenated. It then returns the result as a new sound.
Hence, we need to construct a list of the above notes in the right order to create our first line.
@pydisp{
l1 = [L.list: a,a,a,b,a,a,a]

l2 = [L.list: c,c,c,b,c,c,c]

r = S.concat(l1)

q = S.concat(l2)
}

@subsection{Overlaying two sounds}
The reason for the creation of two sounds for the same line is to add a layer dimensionality, 
which makes the sound more profound and interesting. We can combine these two sounds to play a 
single line by overlaying them using the overlay function.Overlay places one sound over another, 
and is the equivalent of an addition operation between the amplitudes of a set of sounds. 
The Overlay function requires a list of sound objects that need to be overlayed, and returns the 
result as a new sound. 
@pydisp{
l3 = [L.list: r,q]

p = S.overlay(l3)
}

@exercise{
Are you happy with the resulting sound? Do you find anything amiss? If so, what can we do to
modify the sound, so that it sounds similar to the original?
}

@subsection{Increasing the Tempo}
We can increase the tempo of a sound to our required speed using the set-playback-speed function in 
the Sound library. This function Constructs a sound that plays at the new rate given by the playback 
speed, such as 2X, 3X etc. It takes a sound object and an integer number that specifies the factor by 
which the sound needs to be sped up or slowed down. It then returns a resultant new sound object.
@pydisp{
t = S.set-playback-speed(p, 3)
}

That's it! We've created our very first line of music using Pyret's sound library!

@exercise{
Now that we have constructed our very first line, can you think about how to similarly construct the 
entire song? You can use the following resource for note reference - 
@show-url{https://www.streetdirectory.com/travel_guide/31508/music/learn_to_play_jingle_bells_without_sheet_music.html}
}

@subsection{Fading a sound}

Have you ever noticed how the ending of a song has a gradual fade? You can implement that functionality
to your very own rendition of Jingle Bells that you have constructed above. we use the fade function from
the Pyret Sound library for this purpose. The function progressively fades a given sound towards the end 
and returns the result as a new sound.
@pydisp{
m = S.fade(t)
}