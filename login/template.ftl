<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}">

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
</head>

<body class="${properties.kcBodyClass!}">
<div class="${properties.kcLoginClass!}">
    <div id="kc-header" class="${properties.kcHeaderClass!} loginPage-container">
        <div id="kc-header-wrapper"
             class="${properties.kcHeaderWrapperClass!}">
             <a href="https://www.eea.europa.eu/" title="Site"><img title="European Environment Agency" src="${url.resourcesPath}/img/eeaLogo.png" alt="European Environment Agency" height="64" class="ui image eea-logo"></a>
             <a href="https://europa.eu/european-union/about-eu_en" title="The EEA is an agency of the European Union" target="_blank" rel="noreferrer"><img title="The EEA is an agency of the European Union" src="${url.resourcesPath}/img/europe-flag.svg" alt="The EEA is an agency of the European Union" height="64" class="ui image eu-flag"></a>
        </div>
    </div>
    <h2 id="kc-title">${msg("loginTitle")}</h2>
    <div class="${properties.kcMainContentClass!}">
      <div class="${properties.kcFormCardClass!}">
        <header class="${properties.kcFormHeaderClass!}">
            <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                <div class="${properties.kcLocaleMainClass!}" id="kc-locale">
                    <div id="kc-locale-wrapper" class="${properties.kcLocaleWrapperClass!}">
                        <div id="kc-locale-dropdown" class="${properties.kcLocaleDropDownClass!}">
                            <a href="#" id="kc-current-locale-link">${locale.current}</a>
                            <ul class="${properties.kcLocaleListClass!}">
                                <#list locale.supported as l>
                                    <li class="${properties.kcLocaleListItemClass!}">
                                        <a class="${properties.kcLocaleItemClass!}" href="${l.url}">${l.label}</a>
                                    </li>
                                </#list>
                            </ul>
                        </div>
                    </div>
                </div>
            </#if>
        <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
            <#if displayRequiredFields>
                <div class="${properties.kcContentWrapperClass!}">
                    <div class="${properties.kcLabelWrapperClass!} subtitle">
                        <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
                    </div>
                    <div class="col-md-10">
                        <h1 id="kc-page-title"><#nested "header"></h1>
                    </div>
                </div>
            <#else>
                <h1 id="kc-page-title"><#nested "header"></h1>
            </#if>
        <#else>
            <#if displayRequiredFields>
                <div class="${properties.kcContentWrapperClass!}">
                    <div class="${properties.kcLabelWrapperClass!} subtitle">
                        <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
                    </div>
                    <div class="col-md-10">
                        <#nested "show-username">
                        <div id="kc-username" class="${properties.kcFormGroupClass!}">
                            <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                            <a id="reset-login" href="${url.loginRestartFlowUrl}">
                                <div class="kc-login-tooltip">
                                    <i class="${properties.kcResetFlowIcon!}"></i>
                                    <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            <#else>
                <#nested "show-username">
                <div id="kc-username" class="${properties.kcFormGroupClass!}">
                    <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                    <a id="reset-login" href="${url.loginRestartFlowUrl}">
                        <div class="kc-login-tooltip">
                            <i class="${properties.kcResetFlowIcon!}"></i>
                            <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                        </div>
                    </a>
                </div>
            </#if>
        </#if>
      </header>
      <div id="kc-content">
        <div id="kc-content-wrapper">

          <#-- App-initiated actions should not see warning messages about the need to complete the action -->
          <#-- during login.                                                                               -->
          <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
              <div class="alert-${message.type} ${properties.kcAlertClass!} pf-m-<#if message.type = 'error'>danger<#else>${message.type}</#if>">
                  <div class="pf-c-alert__icon">
                      <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                      <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                      <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                      <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                  </div>
                      <span class="${properties.kcAlertTitleClass!}">${kcSanitize(message.summary)?no_esc}</span>
              </div>
          </#if>

          <#nested "form">

            <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
                <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                    <div id="kc-form-tryAnotherWay" class="${properties.kcFormGroupClass!}">
                        <input type="hidden" name="tryAnotherWay" value="on"/>
                        <a href="#" id="try-another-way"
                           onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                    </div>
                </form>
            </#if>

          <#if displayInfo>
              <div id="kc-info" class="${properties.kcSignUpClass!}">
                  <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                      <#nested "info">
                  </div>
              </div>
          </#if>
        </div>
      </div>
    </div>
      <#nested "socialProviders">
  </div>
  <div id="kc-footer" class="${properties.kcFooterClass!}">
           <div class="kc-footer-one">
             <div class="kc-footer-portal-footer">
                 <div class="section-centered">
                   <p class="media-centered"><b>${msg("sectionOne_itemOne_1")}</b></p>
                   <p class="media-centered">
                       ${msg("sectionOne_itemOne_2")}&nbsp;
                       <a href="${msg("sectionOne_itemURL")}" title="${msg("sectionOne_itemOne3")}">${msg("sectionOne_itemOne3")}</a> &nbsp;
                       ${msg("sectionOne_itemOne_4")}
                   </p>
                 </div>
             </div>
           </div>
           <div class="kc-footer-two">
             <div class="portal-colophon">
               <div class="colophon-section eu-section">
                 <a href="${msg("sectionTwo_URLEEA")}"><span class="europe-agency-text"><img title="European Union Flag" src="${url.resourcesPath}/img/europe-flag.svg" alt="European Union Flag" height="64" class="ui image eu-flag"><span>${msg("sectionTwo_titleEEA")}</span></span></a>
               </div>
             </div>
             <div class="portal-colophon">
               <div class="colophon-section eea-software-info">
                   <p class="colophon-links"><i aria-hidden="true" class="fa fa-database icon"></i>${msg("sectionTwo_titleOne")}&nbsp;<a href="${msg("sectionTwo_urlOne")}">${msg("sectionTwo_titleUrlOne")}</a></p>
                   <p class="colophon-links"><a href="${msg("sectionTwo_urlTwo")}" title="${msg("sectionTwo_titleUrlTwo")}">${msg("sectionTwo_titleUrlTwo")}</a></p>
                   <p class="colophon-links"><a href="${msg("sectionTwo_urlThree")}" title="${msg("sectionTwo_titleUrlThree")}">${msg("sectionTwo_titleUrlThree")}</a></p>
                   <p class="colophon-links"><a href="${msg("sectionTwo_urlFour")}">${msg("sectionTwo_titleUrlFour")}</a></p>
                   <p class="colophon-links"><a rel="license" href="${msg("sectionTwo_urlFive")}" title="${msg("sectionTwo_titleUrlFive")}"><i aria-hidden="true" class="fa fa-creative-commons icon"></i><span>${msg("sectionTwo_titleUrlFive")}</span></a></p>
               </div>
           </div>
           </div>
  </div>

</div>
</body>
</html>
</#macro>
