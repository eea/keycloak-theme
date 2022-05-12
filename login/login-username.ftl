<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username') displayInfo=(realm.password && realm.registrationAllowed && !registrationDisabled??); section>
    <#if section = "header">
      ${msg("loginAccountTitle")}
    <#elseif section = "form">
    <div id="kc-form">
      <div id="kc-form-wrapper">
        <#if realm.password>
          <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                <#if !usernameHidden??>
                    <div class="${properties.kcFormGroupClass!}">
                            <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}
                            <#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>

                            <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}" placeholder="${msg("usernameOrEmailInput")}" type="text" autofocus autocomplete="off"
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
                                        <p><a tabindex="5" href="${msg("loginResetCredentialsUrl")}">${msg("doForgotPassword")}</a></p>
                                    </#if>
                                </div>
                          </div>

                          <div id="kc-container-buttons">
                            <div id="kc-form-buttons">
                              <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                              <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} button" name="login" id="kc-login" type="submit" aria-label="Log in" title="Log in">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 36 36" style="width:auto;fill:currentColor" class="icon circled"><path fill-rule="evenodd" d="M18.707 5.293L17.293 6.707 27.586 17 5 17 5 19 27.586 19 17.293 29.293 18.707 30.707 31.414 18z"></path></svg>
                              </button>
                            </div>
                          </div>
          </form>
        </#if>
      </div>

    </div>
    <#elseif section = "info">
      <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="6"
                                                 href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
      </#if>

      <#elseif section = "socialProviders">
          <h4 class="alternative-login-socialProviders">${msg("identity-provider-login-label")}</h4>
          <#if realm.password && social.providers??>
                  <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                      <h1>${msg("alternative-login-socialProviders")}</h1>
                      <p class="kc-social-description">${msg("social_description")}</p>
                          <div id="kc-container-buttons">
                            <div id="kc-form-buttons">
                              <ul>
                                <#list social.providers as p>
                                  <a href="${p.loginUrl}">
                                    <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} button" name="login" id="kc-login" type="submit" aria-label="EEA Office 365 Login" title="EEA Office 365 Login">
                                      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 36 36" style="width:auto;fill:currentColor" class="icon circled"><path fill-rule="evenodd" d="M18.707 5.293L17.293 6.707 27.586 17 5 17 5 19 27.586 19 17.293 29.293 18.707 30.707 31.414 18z"></path></svg>
                                    </button>
                                  </a>
                                </#list>
                              </ul>
                            </div>
                          </div>
                  </div>
          </#if>
    </#if>
</@layout.registrationLayout>
