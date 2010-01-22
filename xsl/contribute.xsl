<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:include href="myvariables.xsl"/>
	<xsl:include href="framework.xsl"/>
	<xsl:include href="util.xsl"/>
	<xsl:include href="factoid.xsl"/>

	<xsl:template match="/">
		<xsl:call-template name="framework">
			<xsl:with-param name="title">Contribute - Dictionary of Sydney</xsl:with-param>
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
				<img src="{$urlbase}images/pictures/img-contribute.jpg"/>
			</a>
			<div id="banner-attribution">
				<xsl:call-template name="makeMediaAttributionStatement">
					<xsl:with-param name="record" select="hml/references/reference"/>
				</xsl:call-template>
			</div>
		</div>
		<div id="form-left-col">
			<h1>Contribute</h1>
			<p>If you have information, research, personal stories, or images that you
			would like to contribute to the Dictionary of Sydney, please let us know.</p>

			<p>To send us a message or suggestion, click on the
			<a href="contact.html">Contact Us</a> link on any page.</p>

			<p>We may not be able to include your contribution, depending on length,
			other commissions or suitability, but we'd like to see it.</p>

			<ul>
				<li>Write a short summary of your contribution in the text box</li>
				<!--li>Upload files or photos by browsing your computer and selecting
				the ones you want to send us. Please don't attach more than 2MB of files.</li-->
				<li>Check your contact details are correct so that we can get back to you</li>
				<li>Before sending, type the two words you see in the reCAPTCHA box into
				the field provided &#8211; this protects the site from spammers.</li>
			</ul>

		</div>
		<div id="form-right-col">
			<form method="post" action="{$urlbase}contact.php" onsubmit="return validateForm()">
				<input type="hidden" name="mode" value="contribute"/>
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
