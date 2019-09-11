<!--
.. title: Moving to Static Site Generation
.. slug: moving-to-static-site-generation
.. date: 2019-09-02 10:34:36 UTC+01:00
.. tags: code, website
.. category: documentation
.. link: 
.. description: A brief explanation of why I moved to a static site generator
.. type: text
-->

<img align="right" src="/images/blog/under-construction.png" style="max-height:25vh;">

This is the first post on my new site.  This site is a static site generated using [Nikola](https://getnikola.com/), 
a static-site generator written in Python. I chose it because I know Python pretty well and
so can customize any feature I want. It also natively supports [Jupyter Notebooks](https://jupyter.org/), which is 
a big plus. 

<!-- TEASER_END -->

While switching over I seriously considered [Hugo](https://gohugo.io/), a generator
written in Go which seems to have a very large and dedicated base. I may eventually switch 
over. Hugo although the Jupyter integration is nearly non-existent (i.e., manually export to
markdown).

# The Old Stack

## The good

For many years I have used [mediawiki](https://mediawiki.org) as a Content Management System. 
I found this to be a relatively simple approach since it allowed be to create and populate a page
with links to other documents or files, whether these existed or not. If a page or file did 
not exist, I could click on its link (which has a 404-color code) and either edit the missing
page or add the file.  The wiki software also has a number of special pages that let me see
all missing file.  As a bonus, MediaWiki indexes all content so that the site is immediately 
searchable. There are [many extensions](https://www.mediawiki.org/wiki/Manual:Extensions) that are helpful in integrating with other services,
e.g., embedding YouTube videos. 

## The bad

What I didn't like about the old site was its fragility.  I regularly received emails telling 
me that my site was down.  These were driven by a connectivity issue with the MariaDB that stored
the site's data or with php-fpm which managed the relationship between the nginx front end
and the PHP engine. My site depended on the correct operation of:

* nginx
* MariaDB
* php-fpm
* MediaWiki
* A DigitalOcean droplet

I also didn't like the feeling that I had to regularly patch the software. While I could setup
Ubuntu to automatically apply patches, I was always nervous about doing this with the MediaWiki
software. Instead, I would manually patch when I received an email from their security mailing list.
In addition, I had to occasionally migrate PHP versions when the current LTS increased its minimum
supported version. This was particularly challenging for me since I do not regularly use PHP and so 
I had to reinvent the wheel each time this happened (which I think was only twice, in fairness)

The extension landscape was also very uneven.  Many extensions I tried had no long-term support and 
so would continue to work until they used a feature that had been removed. This required repeatedly 
searching for new extensions, and eventually lead me to remove most of them.  

# The new site

## The good

The new site is static in the sense that it is only a collection of HTML, CSS, JavaScript, images
and other content files.  The only server I need is a webserver (e.g., nginx). While I 
am initially hosting it on the same droplet I used for my MediaWiki installation, I plan 
on moving to GitHub pages using [Travis CI](https://travis-ci.com) to build the pages.  This will both save my time and
money.

## The bad

While writing a simple site or pure blog is pretty food proof, Nikola is not a great site generator.
The biggest problems I have faced are (some) lack of out-of-box customizability, lack of
a theme I like, and nothing helping me ensure that I do not have missing or orphan pages.
The upside for me is that these are all pretty simple to fix writing a few custom plugins. 
For example, I wrote one that reads the site contents, file a list of files and finds all
links to these files.  It then uses a couple of set operations to determine if there are
any missing files (really important) or orphan files (less important, but still annoying).

