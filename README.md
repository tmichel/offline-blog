# (Offline) Blog

I started to pour my inner thoughts into text files and _not_ post them online.
Not everything has a place on the internet. I followed some simple rules to make
things a little easier, but in the end it turned out I'm too lazy to follow
these manually.

This is an attempt to automate some of the task that arose during the first few
posts.

The rules are the following:

* every post has a number
* post numbering starts from '001'
* the whole thing is kept in a git repository
* a post should not be modified, deleted or touched in any way after it has been
commited to the repo
* every post has its separate file
* posts are written in markdown
* file naming convention: `XXX-title-of-the-post.md`

## Install

TODO

## Commands

### blog new TITLE

Creates a new blog post in the directory we are currently in. It figures out the
number for the post, creates a the file and tries to open it. It also inserts
the title on the top of the file.

At the moment it uses the `sublime` command to open the editor. If the command
is not available nothing happens.
