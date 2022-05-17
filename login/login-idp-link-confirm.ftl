<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("confirmLinkIdpTitle")}
    <#elseif section = "form">
        <form id="kc-register-form" action="${url.loginAction}" method="post">
            <div class="${properties.kcFormGroupClass!}">
              <div id="kc-eea-buttons">
                <button type="submit" class="ui primary button" name="submitAction" id="updateProfile" value="updateProfile">${msg("confirmLinkIdpReviewProfile")}</button>
                <button type="submit" class="ui secondary button" name="submitAction" id="linkAccount" value="linkAccount">${msg("confirmLinkIdpContinue", idpDisplayName)}</button>
              </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
