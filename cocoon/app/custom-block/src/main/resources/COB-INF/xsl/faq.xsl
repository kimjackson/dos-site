<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:include href="myvariables.xsl"/>
	<xsl:include href="framework.xsl"/>
	<xsl:include href="util.xsl"/>
	<xsl:include href="factoid.xsl"/>

	<xsl:template match="/">
		<xsl:call-template name="framework">
			<xsl:with-param name="title">Frequently Asked Questions - Dictionary of Sydney</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="extraCSS"/>
	<xsl:template name="extraScripts"/>
	<xsl:template name="previewStubs"/>

	<xsl:template name="content">

<div id="block-heading">

<a href="image/{hml/records/record/id}" class="preview-{hml/records/record/id}">
	<img src="{$urlbase}images/pictures/img-faqs.jpg"/>
</a>

<div id="banner-attribution">
	<xsl:call-template name="makeMediaAttributionStatement">
		<xsl:with-param name="record" select="hml/records/record"/>
	</xsl:call-template>
</div>


<h1>Frequently Asked Questions</h1>

<p><a href="#faq-01">What browsers are supported?</a></p>
<p><a href="#faq-02">Can I see a demonstration of this site?</a></p>
<p><a href="#faq-03">How is this different from other websites and online encyclopaedias?</a></p>
<p><a href="#faq-04">How is this different from Wikipedia?</a></p>
<p><a href="#faq-05">Why can't I find the article I want?</a></p>
<p><a href="#faq-06">Can I suggest topics that should be in the Dictionary?</a></p>
<p><a href="#faq-07">Can I contribute to the Dictionary of Sydney?</a></p>
<p><a href="#faq-08">I've found a mistake, who do I tell?</a></p>
<p><a href="#faq-09">When's the hardcover book coming out?</a></p>
<p><a href="#faq-10">Can I use text and images from the Dictionary?</a></p>
<p><a href="#faq-11">How is the Dictionary funded?</a></p>
<p><a href="#faq-12">Why isn't there more contemporary information?</a></p>
<p><a href="#faq-13">Why can't I find anything on topics outside Sydney?</a></p>

</div>

<div class="block-content" id="faq-01">
<h2>What browsers are supported?</h2>
<p>
You will need IE7 or above or Firefox or Chrome. You will need javascript
enabled, a flash plugin installed and a screen resolution of 1024x768 gives the
best results.
</p>
</div>

<div class="block-content" id="faq-02">
<h2>Can I see a demonstration of this site?</h2>
<p>
You can see a demonstration of this website <a href="http://trust.dictionaryofsydney.org/dos/dosdemo.html">here</a> - you'll need a good internet
link and a Flash plugin in your browser.
</p>
</div>

<div class="block-content" id="faq-03">
<h2>How is this different from other websites and online encyclopaedias?</h2>
<p>
The Dictionary of Sydney's structure provides a framework for building an
ever-growing repository of historical information. Our people, buildings,
organisations, structures, artefacts, places, natural features and events
contain basic details and historical and geographical information and can be
related and connected. Each one may or may not have a linked text entry giving
a fuller historical account.
</p>
<p>
This structure means that we can attach multiple entries to one entity, link a
range of people or places to a theme, and illustrate all of them with a full
range of multimedia. The flexibility and scalability of the project is
innovative and allows the information to be presented in a number of different
ways as the technology develops.
</p>
</div>

<div class="block-content" id="faq-04">
<h2>How is this different from Wikipedia?</h2>
<p>
All material on the Dictionary of Sydney is edited and curated to present a
rounded and satisfying online experience that is sharply focused on Sydney's
history. Dictionary of Sydney articles are written by named authors, and we have
the capacity to publish more than one article on any given topic. Many of our
articles are based on original research by experts in the field. Any internal
links in Dictionary articles will take you to other material on Sydney's
history.
</p>
<p>
We have a good relationship with Wikipedia, and their Sydney chapter, and we
hope they will be able to use the Dictionary as a reputable source of research
for their Sydney articles. Wikipedia is a global encyclopaedic project that we
are pleased to be associated with, but which has quite a different style and
purpose.
</p>
</div>

<div class="block-content" id="faq-05">
<h2>Why can't I find the article I want?</h2>
<p>
The Dictionary of Sydney is a work in progress. The project will continue to
grow and new material is added regularly. There are nearly 500 articles on the
site now, and many thousands of people, places, organisations, events, artefacts
and buildings that will have articles attached to them in the future.
</p>
<p>
We know there are lots of people, things and events that are missing. The
project team will continue to expand the range and increase the depth of the
Dictionary's coverage over time, so keep checking back.
</p>
</div>

<div class="block-content" id="faq-06">
<h2>Can I suggest topics that should be in the Dictionary?</h2>
<p>
Yes please! We have long lists of topics that we want to cover in the Dictionary
but we are always pleased to have suggestions. Our editorial, commissioning,
editing and curation process takes time, however, and there may be a long lag
before your suggestion is incorporated. If you have a suggested author for your
topic, please let us know that too. Click on the
<a href="contribute.html">Contribute</a> link at the bottom of any page
and tell us about your suggested topic.
</p>
</div>

<div class="block-content" id="faq-07">
<h2>Can I contribute to the Dictionary of Sydney?</h2>
<p>
If you have researched a topic and can write a history of it, we'd love to hear
from you. It's possible your topic has already been commissioned to someone else
and is in preparation, so we can't guarantee that you will be commissioned to
write it. Our editorial committee considers all requests. Click on the
<a href="contribute.html">Contribute</a> link at the bottom of any page
and tell us about your topic, and your qualifications and experience, and we
will get back to you as soon as we can.
</p>
</div>

<div class="block-content" id="faq-08">
<h2>I've found a mistake, who do I tell?</h2>
<p>
We're really pleased to hear about anything in the Dictionary that we can
improve, and especially any factual errors that might have crept in. Please
click on the <a href="contribute.html">Contribute</a> link at the bottom of the
page where you found the mistake and describe it. We'll look into it and fix it
as soon as we can.
</p>
</div>

<div class="block-content" id="faq-09">
<h2>When's the hardcover book coming out?</h2>
<p>
There will never be a hardcover printed version of the whole Dictionary of
Sydney, though print-on-demand books that contain smaller selections of
Dictionary text might one day be a reality.
</p>
<p>
For a start, the Dictionary of Sydney is just too big &#8211; even the very
first edition would run to 6 printed volumes. Secondly, much of the value of the
Dictionary lies in the connections between people, things, organisations and
places and the thematic essays and other entries &#8211; most of which would be
lost in a book format. The Dictionary was envisaged as an online,
interconnected, digital project, and is quite different from an online version
of a book.
</p>
</div>

<div class="block-content" id="faq-10">
<h2>Can I use text and images from the Dictionary?</h2>

<p>Dictionary text authors retain the copyright in their work. Images and other
multimedia are also owned by other institutions and individuals and licensed for
use in the Dictionary of Sydney. If you would like to re-use parts of what you
see here in your own project please contact the listed owner of the piece
(article, photograph, etc.).
</p>
<p>
Some of our authors have agreed to release their work under the Creative Commons
Attribution Share-Alike license. This means you <i>can</i> re-use that specific text
(marked with the CC-BY-SA logo) in your project without having to ask permission
first. Find out more at our <a href="copyright.html">Copyright</a> page.
</p>
</div>

<div class="block-content" id="faq-11">
<h2>How is the Dictionary funded?</h2>
<p>
The Dictionary of Sydney is governed by a charitable trust set up as a result of
an Australian Research Council linkage grant between the City of Sydney,
University of Sydney, University of Technology, Sydney, the State Records NSW
and the State Library of NSW. This has provided for a small team of staff, based
at the City of Sydney offices at Town Hall, and a group of volunteers helping
the project. All of the textual and multimedia content has been generously
provided for free.
</p>
<p>
We have also received several sustaining and project-specific grants from the
City of Sydney, the Sydney Mechanics' School of Arts and the Sydney Harbour
Foreshore Authority. The technical component of the Dictionary is being
supported by the Archaeological Computing Laboratory at the University of
Sydney. See the <a href="about.html">About Us</a> page or the
<a href="http://trust.dictionaryofsydney.org/">Dictionary of Sydney Trust
website</a> for more information.
</p>
</div>

<div class="block-content" id="faq-12">
<h2>Why isn't there more contemporary information?</h2>
<p>
The Dictionary is a history project. The scope of the project is to cover
Sydney's history from first human habitation to the present, and many of our
articles cover material up to the present day, but we don't focus on providing
information about contemporary Sydney.
</p>
</div>

<div class="block-content" id="faq-13">
<h2>Why can't I find anything on topics outside Sydney?</h2>
<p>
The Dictionary of Sydney has no limit in time, but strict limits in space. It
does not contain any entries on people who never came here, organisations that
were located elsewhere or places outside the Sydney basin. This means that some
people and organisations which were very influential in Sydney's history are not
covered directly in the Dictionary. We had to draw the line somewhere, and
you'll find information on these subjects elsewhere.
</p>
</div>

	</xsl:template>


	<xsl:template name="sidebar">
		<xsl:call-template name="makeBrowseMenu">
			<xsl:with-param name="base" select="''"/>
		</xsl:call-template>
	</xsl:template>


</xsl:stylesheet>
