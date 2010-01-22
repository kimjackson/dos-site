<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:include href="myvariables.xsl"/>
	<xsl:include href="framework.xsl"/>
	<xsl:include href="util.xsl"/>
	<xsl:include href="factoid.xsl"/>

	<xsl:template match="/">
		<xsl:call-template name="framework">
			<xsl:with-param name="title">Contact Us - Dictionary of Sydney</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="extraCSS"/>
	<xsl:template name="previewStubs"/>

	<xsl:template name="extraScripts">
		<script src="{$urlbase}js/contact.js" type="text/javascript"/>
	</xsl:template>

	<xsl:template name="content">

		<div id="form-heading">
			<a href="image/{hml/references/reference/id}" class="preview-{hml/references/reference/id}">
				<img src="{$urlbase}images/pictures/img-contact-us.jpg"/>
			</a>
			<div id="banner-attribution">
				<xsl:call-template name="makeMediaAttributionStatement">
					<xsl:with-param name="record" select="hml/references/reference"/>
				</xsl:call-template>
			</div>
		</div>
		<div id="form-left-col">
			<h1>Contact Us</h1>
			<p>If you have a recommendation for an entry or author, you've found an
			error, or you'd like to send us a message, please let us know.</p>

			<p>To send us an entry, story or photograph, click on the Contribute link on
			any page.</p>

			<p>We may not be able to take action on your suggestion straight away, but
			we will put it on our list.</p>

			<ul>
				<li>Write your message in the text box</li>
				<li>Check your contact details are correct so that we can get back to you.</li>
				<li>Before sending, type the two words you see in the reCAPTCHA box into
				the field provided &#8211; this protects the site from spammers.</li>
			</ul>

			<p>The Dictionary of Sydney may also be contacted at:</p>
			<h3>Email:</h3>
			<p>info [at] dictionaryofsydney.org</p>
			<h3>Address:</h3>
			<p>
			Dictionary of Sydney<br/>
			GPO Box 1591<br/>
			Sydney 2001
			</p>

		</div>
		<div id="form-right-col">
			<form method="post" action="{$urlbase}contact.php" onsubmit="return validateForm()">
				<input type="hidden" name="mode" value="contact"/>
				<p>Please send us your message here ...</p>
				<div class="form-row">
					<label>Name</label>
					<input type="text" name="name" id="name" size="20" maxlength="40"/>
				</div>
				<div class="form-row">
					<label>Email</label>
					<input type="text" name="email" id="email" size="20" maxlength="40"/>
				</div>
				<div class="form-row">
					<label>Phone</label>
					<input type="text" name="phone" id="phone" size="20" maxlength="40"/>
				</div>
				<div class="form-row div-message">
					<label>Message</label>
					<textarea name="message" id="message"/>
				</div>
				<div class="clearfix"/>
				<div>
					<script type="text/javascript">
						RecaptchaOptions = { theme: 'white' };
					</script>
					<script type="text/javascript" src="http://api.recaptcha.net/challenge?k=6LekFwkAAAAAACAxDFNRMOWNrJ9urFg7RY_v5M-E"/>
					<noscript>
						<iframe src="http://api.recaptcha.net/noscript?k=6LekFwkAAAAAACAxDFNRMOWNrJ9urFg7RY_v5M-E" height="300" width="500" frameborder="0"/><br/>
						<textarea name="recaptcha_challenge_field" rows="3" cols="40"/>
						<input type="hidden" name="recaptcha_response_field" value="manual_challenge"/>
					</noscript>
				</div>
				<div class="send">
					<input type="submit" name="send" id="send" value="Submit"/>
				</div>
			</form>
		</div>

	</xsl:template>


	<xsl:template name="sidebar">
		<xsl:call-template name="makeBrowseMenu">
			<xsl:with-param name="base" select="''"/>
		</xsl:call-template>
	</xsl:template>


</xsl:stylesheet>
