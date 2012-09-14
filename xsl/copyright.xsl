<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:include href="framework.xsl"/>
	<xsl:include href="util.xsl"/>
	<xsl:include href="factoid.xsl"/>

	<xsl:variable name="urlbase"/>
	<xsl:variable name="fullurlbase"/>

	<xsl:template match="/">
		<xsl:call-template name="framework">
			<xsl:with-param name="title">Copyright - Dictionary of Sydney</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="extraCSS"/>
	<xsl:template name="extraScripts"/>
	<xsl:template name="previewStubs"/>

	<xsl:template name="content">

<div id="block-heading">

<a href="image/{hml/records/record/id}" class="preview-{hml/records/record/id}">
	<img src="{$urlbase}images/pictures/img-copyright.jpg"/>
</a>

<div id="banner-attribution">
	<xsl:call-template name="makeMediaAttributionStatement">
		<xsl:with-param name="record" select="hml/records/record"/>
	</xsl:call-template>
</div>


<h1>Copyright</h1>

<p>
The <i>Dictionary of Sydney</i> brings together the intellectual property of a
large number of contributors in an innovative way.  All of the content you will
find here has been provided to us by others and the <i>Dictionary</i> is not the
copyright holder of material appearing within the project.
</p>

<p>
We have received permission to use, for our purposes, everything you find here.
If you wish to use any of this content for your purposes (above and beyond
normal personal use or uses permitted by copyright law such as 'fair dealing')
you will need to make a direct request to the owner.
</p>

</div>

<div class="block-content">

<h2>Text</h2>

<p>
All articles (also known as entries) in the <i>Dictionary of Sydney</i> are
newly commissioned texts from the listed authors and have been licensed to the
<i>Dictionary</i> for its use, adaptation and integration into our project
(present and future). The copyright in each article lies with its listed
author(s) who retains the right to license it commercially, publish elsewhere,
adapt or otherwise exploit their rights as the copyright holder.
</p>

<p>
In many cases, authors of articles have also agreed to license their work under
Creative Commons Attribution Share-Alike (version Au-2.5) (commonly referred to
as CC-BY-SA). The Creative Commons licence describes the circumstances under
which third parties may use articles without having to ask permission or pay
fees. This is a voluntary licence and it encourages the wider dissemination and
use of the information. Articles which are so licensed are clearly indicated by
the CC-BY-SA logo next to the title.
</p>

<p>
You can see the full details of the CC-BY-SA licence
<a href="http://creativecommons.org/licenses/by-sa/2.5/au/" target="_blank">here</a>.
In summary, this licence means that third parties are specifically allowed to
copy, distribute and adapt the article provided that they attribute the original
source, and that adaptations, such as translations, abridged versions or new
articles based on the original, are made equally free for others to further
adapt and re-use under the same CC-BY-SA licence. If you would like to re-use
article(s) in ways not permitted under this licence you need to contact the
author(s) to gain specific permission.
</p>

<p>
Paratexts (such as captions, subheadings, project description pages) are written
in-house. Attribution texts (also known as metadata) are supplied by the
provider of the multimedia items and are either their copyright or not
copyrightable.
</p>

</div>

<div class="block-content">

<h2>Multimedia</h2>

<p>
The <i>Dictionary of Sydney</i> has partnered with a wide range of public
institutions, commercial companies and individuals to find and license
multimedia items (images, video, audio) to associate with our articles. The
<i>Dictionary</i> has sought and received specific permission to use each one of
these items in the project. However, our licence does not permit us to
on-license any multimedia content to third parties. Except in a few specific
circumstances (described below) we do not provide advice about the copyright
status of multimedia items appearing in the <i>Dictionary of Sydney</i>.
</p>

<p>
If you wish to re-use this content you need to undertake your own copyright
assessment and/or contact the listed provider. We have made best efforts to
obtain permissions and show the correct attribution, citation and metadata for
all material in the <i>Dictionary</i> but if you believe we have made a mistake
or omission, please contact us.
</p>

<p>
In some circumstances we have used multimedia items which have been published
elsewhere with one of the several Creative Commons licences available. We have
indicated this fact within the metadata of the item. If you would like to know
more about the copyright status of such an item please check at the location
where the item was first published.
</p>

</div>

<div class="block-content">

<h2>Software</h2>

<p>
The material which appears on this website has been aggregated and curated on
the Heurist platform developed at the Archaeological Computing Lab at the
University of Sydney.  For further inquiries regarding Heurist, please contact
the Lab at info [at] acl.arts.usyd.edu.au
</p>

</div>

<div class="block-content">

<h2>Website design</h2>

<p>
Design and build of this website was undertaken jointly by the Archaeological
Computing Lab and StudioEmotion design.
</p>

</div>

<div class="block-content">

<h2>Historical model</h2>

<p>
While the content appearing in the <i>Dictionary of Sydney</i> has been licensed
from others, the model into which these items are placed is original work
arising from the <i>Dictionary of Sydney</i> project. Among much else, this
includes the ontological structures, set of historical relationships, subject
thesaurus, and other elements. The <i>Dictionary of Sydney</i> has created a
unique model and asserts copyright in it. For further inquiries regarding this
model, please contact the Dictionary at info [at] dictionaryofsydney.org
</p>

</div>


	</xsl:template>


	<xsl:template name="sidebar">
		<xsl:call-template name="makeBrowseMenu">
			<xsl:with-param name="base" select="''"/>
		</xsl:call-template>
	</xsl:template>


</xsl:stylesheet>
