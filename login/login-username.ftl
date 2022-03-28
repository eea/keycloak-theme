<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username') displayInfo=(realm.password && realm.registrationAllowed && !registrationDisabled??); section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
                          method="post">
                        <#if !usernameHidden??>
                            <div class="${properties.kcFormGroupClass!}">
                            <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}
                            <#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>

                            <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}" placeholder="${msg("usernameOrEmail")}" type="text" autofocus autocomplete="off"
                                   aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                            />

                                <#if messagesPerField.existsError('username')>
                                    <span id="input-error-username" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                        ${kcSanitize(messagesPerField.get('username'))?no_esc}
                                    </span>
                                </#if>
                            </div>
                        </#if>

                        <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                            <div>
                                <#if realm.rememberMe && !usernameHidden??>
                                    <div class="checkbox">
                                        <label>
                                            <#if login.rememberMe??>
                                                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                            <#else>
                                                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                            </#if>
                                        </label>
                                    </div>
                                </#if>
                                </div>
                                <div id="kc-form-forgotPassword" class="${properties.kcFormOptionsWrapperClass!}">
                                    <#if realm.resetPasswordAllowed>
                                        <p><a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></p>
                                    </#if>
                                </div>
                          </div>

                        <div id="kc-container-buttons">
                          <div id="kc-form-buttons">
                            <button id="login-form-cancel" aria-label="Cancel" title="Cancel" class="right floated button" role="button" href="/">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 36 36" style="width:auto;fill:currentColor" class="icon circled"><path fill-rule="evenodd" d="M27.899 9.515L26.485 8.101 18 16.586 9.514 8.101 8.1 9.515 16.586 18 8.1 26.486 9.514 27.9 18 19.414 26.485 27.9 27.899 26.486 19.414 18z"></path></svg>
                            </button>
                            <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} button" name="login" id="kc-login" type="submit" aria-label="Log in" title="Log in">
                              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 36 36" style="width:auto;fill:currentColor" class="icon circled"><path fill-rule="evenodd" d="M18.707 5.293L17.293 6.707 27.586 17 5 17 5 19 27.586 19 17.293 29.293 18.707 30.707 31.414 18z"></path></svg>
                            </button>
                          </div>
                        </div>
                    </form>
                </#if>
            </div>
        </div>

        <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                <hr/>
                <h4>${msg("identity-provider-login-label")}</h4>

                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                    <#list social.providers as p>
                        <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                type="button" href="${p.loginUrl}">
                            <#if p.iconClasses?has_content>
                                <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                            <#else>
                                <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                            </#if>
                        </a>
                    </#list>
                </ul>
            </div>
        </#if>

        <#elseif section = "info" >
            <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                <div id="kc-registration-container">
                    <div id="kc-registration">
                        <span>${msg("noAccount")} <a tabindex="6"
                                                     href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                    </div>
                </div>
            </#if>
        </#if>

</@layout.registrationLayout>