---
layout: song
category: music
tags: [music, mp3, songwriting, improv, piano, procrastination, weather]
teaser: piano improv
tumblr_audio_file: http://www.tumblr.com/audio_file/3467111748/tumblr_lh32tcn8UX1qzo4ep
---

It's kind of embarrassing, but I've been absolutely paralyzed about moving forward on one part of [wickedwx.com](http://wickedwx.com).

Specifically, I want people to be able to enter their location and get information tailored to their location, like is my location:

* in a severe risk area
* in watch
* in a warning

There's a whole bunch more planned for that part of the site, but those are the core features right there.

The problem is I have no idea where to start.

I'm paralyzed by questions like:

* how do I even do the queries that I need? Most are going to be point-in-polygon type queries, but my dataset also has less clear-cut "lines" where I'm going to have to figure out the actual boundaries myself.
* am I going to have to switch database I'm using? If so, *which one*? Or do I just run 2 different databases: the one I'm using now, and then the one with the geospatial features?
* am I going to have to switch to Active Record to get the ease-of-use queries that I need? Or even further, am I better just switching to Rails? If so, do I move just this part of the site to Rails or migrate everything over?
* geesh, should I have just stayed with Python and gone with geodjango?

It would be much harder to get away with procrastinating on this *if this were the only thing I needed to work on*. As it stands, there's a whole other host of features that I want to work on. I have no previous experience with this sort of geospatial work but the biggest thing is that I've yet to find the spoon feeding that I need. *I'm so unknowledgable about it at this point that I don't even know what questions to ask.* That's one of the many reasons that makes it so hard to get started.

And sadly, this isn't the only part of the site that's going to require massive advancements in my current knowledge. Part of my problem is I like step-by-step instruction, like from books. But I keep picking technologies that are either too new or too niche to have a lot of this sort of material.

The blessing and the curse with this project is that my ideas span so many different disciplines (though primarily it's data parsing, geo spatial, and data visualization). It gives me lots of exposure to lots of different things, but it also means I'm having to start from zero knowledge in so many things.

On the plus side though, one of the things I've cited as an excuse for lack of motivation (lack of severe weather), is getting ready to change. In fact Thursday, is looking like it's gonna be pretty nasty:

![severe weather risk areas for Thursday](https://img.skitch.com/20110223-q6ns54cpgi2taec1b6nda5672f.jpg)

Stay safe out there.
