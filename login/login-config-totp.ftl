<#import "template.ftl" as layout>
<@layout.registrationLayout displayRequiredFields=false displayMessage=!messagesPerField.existsError('totp','userLabel'); section>

    <#if section = "header">
        ${msg("loginTotpTitle")}
    <#elseif section = "form">
    <div class="form-group">
        <ol id="kc-totp-settings">
            <li>
                <p>${msg("loginTotpStep1")}</p>

                <ul id="kc-totp-supported-apps">
                    <#list totp.policy.supportedApplications as app>
                        <li>${app}</li>
                    </#list>
                </ul>
            </li>

            <#if mode?? && mode = "manual">
                <li>
                    <p>${msg("loginTotpManualStep2")}</p>
                    <p><span id="kc-totp-secret-key">${totp.totpSecretEncoded}</span></p>
                    <p><a href="${totp.qrUrl}" id="mode-barcode">${msg("loginTotpScanBarcode")}</a></p>
                </li>
                <li>
                    <p>${msg("loginTotpManualStep3")}</p>
                    <p>
                    <ul>
                        <li id="kc-totp-type">${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}</li>
                        <li id="kc-totp-algorithm">${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                        <li id="kc-totp-digits">${msg("loginTotpDigits")}: ${totp.policy.digits}</li>
                        <#if totp.policy.type = "totp">
                            <li id="kc-totp-period">${msg("loginTotpInterval")}: ${totp.policy.period}</li>
                        <#elseif totp.policy.type = "hotp">
                            <li id="kc-totp-counter">${msg("loginTotpCounter")}: ${totp.policy.initialCounter}</li>
                        </#if>
                    </ul>
                    </p>
                </li>
            <#else>
                <li>
                    <p>${msg("loginTotpStep2")}</p>
                    <img id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode"><br/>
                    <p><a href="${totp.manualUrl}" id="mode-manual">${msg("loginTotpUnableToScan")}</a></p>
                </li>
            </#if>
            <li>
                <p>${msg("loginTotpStep3")}</p>
            </li>
        </ol>

        <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-totp-settings-form" method="post">
            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcInputWrapperClass!}">
                    <label for="totp" class="control-label">${msg("authenticatorCode")}</label> <span class="required">*</span>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="totp" name="totp" placeholder="${msg("loginOtpOneTime")}" autocomplete="off" class="${properties.kcInputClass!}"
                           aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"
                    />

                    <#if messagesPerField.existsError('totp')>
                        <span id="input-error-otp-code" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                        </span>
                    </#if>

                </div>
                <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcInputWrapperClass!}">
                    <label for="userLabel" class="control-label">${msg("loginTotpDeviceName")}</label> <#if totp.otpCredentials?size gte 1><span class="required">*</span></#if>
                </div>

                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" class="${properties.kcInputClass!}" id="userLabel" name="userLabel" placeholder="${msg("loginTotpDeviceName")}" autocomplete="off"
                           aria-invalid="<#if messagesPerField.existsError('userLabel')>true</#if>"
                    />

                    <#if messagesPerField.existsError('userLabel')>
                        <span id="input-error-otp-label" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('userLabel'))?no_esc}
                        </span>
                    </#if>
                </div>
            </div>

            <#if isAppInitiatedAction??>
                <div id="kc-container-buttons" class="kc-containerButtonMargin">
                  <div id="kc-form-buttons">
                    <input class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!} ${properties.kcButtonLargeClass!}" id="cancelTOTPBtn" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}/>
                      <a id="login-form-cancel" aria-label="Cancel" title="Cancel" class="right floated button" role="button" href="/">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 36 36" style="width:auto;fill:currentColor" class="icon circled"><path fill-rule="evenodd" d="M27.899 9.515L26.485 8.101 18 16.586 9.514 8.101 8.1 9.515 16.586 18 8.1 26.486 9.514 27.9 18 19.414 26.485 27.9 27.899 26.486 19.414 18z"></path></svg>
                      </a>
                    <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" id="saveTOTPBtn" type="submit" value="${msg("doSubmit")}">
                      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 36 36" style="width:auto;fill:currentColor" class="icon circled"><path fill-rule="evenodd" d="M18.707 5.293L17.293 6.707 27.586 17 5 17 5 19 27.586 19 17.293 29.293 18.707 30.707 31.414 18z"></path></svg>
                    </button>
                  </div>

            <#else>
                  <div id="kc-container-buttons" class="kc-containerButtonMargin">
                    <div id="kc-form-buttons">
                      <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" id="saveTOTPBtn" type="submit" value="${msg("doSubmit")}">
                          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 36 36" style="width:auto;fill:currentColor" class="icon circled"><path fill-rule="evenodd" d="M18.707 5.293L17.293 6.707 27.586 17 5 17 5 19 27.586 19 17.293 29.293 18.707 30.707 31.414 18z"></path></svg>
                      </button>
                    </div>
                 </div>
            </#if>
        </form>
     </div>
    </#if>
</@layout.registrationLayout>
