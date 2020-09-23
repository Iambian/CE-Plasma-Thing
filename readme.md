Plasma Effect Thinger
=====================

The result of an off-hand comment in the CE dev Discord server.

This is not really a plasma effect. All this does is rotate the palette around
a color circle defined in the HSV color palette, except without bothering
with S or V. The real magic is in the palette sorting which, depending
on the image, allows the rotation to appear as a smoothly moving gradient.

An image is supplied which contains all the magic needed to pretend like
it's really doing the effect. Which it isn't. This program doesn't generate
the image at all.

Dependencies
------------

*	CE C toolchain from 2019 or earlier (requires convpng, no support for convimg)
*	Python 2.7.x. (It might work for 3.x; the script involved is doesn't seem version-specific)
*	Python Imaging Library (PIL/Pillow)

Usage
-----

1.	Take your input image and modify it in an editor to be 320 by 240 pixels.
2.	Save that image in the `src/gfx` folder as `Plasmafractal.png`
3.	Open a command-line window in the `src/gfx` folder. The following commands
	done, in order, should prepare the image for build:
	*	`convpng`
	*	`python sortpal.py`
	*	`convpng`
4.	With the final `convpng` run, ensure that the converted size (the one shown
	on the right) is less than 65000. If it is larger, you should pick a 
	different image or modify it to use fewer colors, then to gack to step 2.
5.	Modify the `NUMBER_OF_COLORS` constant near the top of `src/main.c` to
	contain the number of colors of the input image to help optimize speed.
	(You can ignore this step if you want)
6.	Navigate to project root folder, then run in command-line:
	*	`make`
7.	You're done. Send `bin/DEMO.8xp` to your 84+CE.

License
-------

Do what you want.


Confessions
-----------

*	Writing this readme took longer than writing the actual program.
*	Writing this readme was much less fun than writing the actual program.
*	Writing this readme was only done becuse future-me would've probably had
	choice words with me via use of a time machine and I wanted to head that off
	as soon as possible. Because I don't want Terminators after me.
*	I might have forgotten something else but all I want to do is share the
	trippy cat image (which remains on github and is shown to Cemetech)
	and push this to github. Because cats.




