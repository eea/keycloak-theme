<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp'); section>
    <#if section="header">
        ${msg("doLogIn")}
    <#elseif section="form">
        <form id="kc-otp-login-form" class="${properties.kcFormClass!}" action="${url.loginAction}"
            method="post">
            <#if otpLogin.userOtpCredentials?size gt 1>
                <div class="${properties.kcFormGroupClass!}">
                    <div class="${properties.kcInputWrapperClass!}">
                        <#list otpLogin.userOtpCredentials as otpCredential>
                            <input id="kc-otp-credential-${otpCredential?index}" class="${properties.kcLoginOTPListInputClass!}" type="radio" name="selectedCredentialId" value="${otpCredential.id}" <#if otpCredential.id == otpLogin.selectedCredentialId>checked="checked"</#if>>
                            <label for="kc-otp-credential-${otpCredential?index}" class="${properties.kcLoginOTPListClass!}" tabindex="${otpCredential?index}">
                                <span class="${properties.kcLoginOTPListItemHeaderClass!}">
                                    <span class="${properties.kcLoginOTPListItemIconBodyClass!}">
                                      <i class="${properties.kcLoginOTPListItemIconClass!}" aria-hidden="true"></i>
                                    </span>
                                    <span class="${properties.kcLoginOTPListItemTitleClass!}">${otpCredential.userLabel}</span>
                                </span>
                            </label>
                        </#list>
                    </div>
                </div>
            </#if>

            <div id ="kc-header" class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="otp" class="${properties.kcLabelClass!}">${msg("loginOtpOneTime")}</label>
                </div>

            <div class="${properties.kcInputWrapperClass!}">
                <input id="otp" name="otp" autocomplete="off" type="text" class="${properties.kcInputClass!}"
                       placeholder="${msg("loginOtpOneTime")}" autofocus aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"/>

                <#if messagesPerField.existsError('totp')>
                    <span id="input-error-otp-code" class="${properties.kcInputErrorMessageClass!}"
                          aria-live="polite">
                        ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                    </span>
                </#if>
            </div>

            <div>
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                       <div class="${properties.kcFormOptionsWrapperClass!}">
                       </div>
                </div>

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!} noPaddingRight">
                    <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} button" name="login" id="kc-login" type="submit" aria-label="Log in" title="Log in" value="${msg("doLogIn")}">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 36 36" style="width:auto;fill:currentColor" class="icon circled"><path fill-rule="evenodd" d="M18.707 5.293L17.293 6.707 27.586 17 5 17 5 19 27.586 19 17.293 29.293 18.707 30.707 31.414 18z"></path></svg>
                    </button>
                </div>
            </div>
        </div>
        </form>
    </#if>
</@layout.registrationLayout>
