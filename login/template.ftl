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
  </div>
    <div id="kc-footer" class="${properties.kcFooterClass!}">
             <!-- div class="kc-footer-one">
               <div class="kc-footer-portal-footer">
                 <div class="colophon-section">
                   <div class="section-centered">
                     <h2 class="section-header"><a href="${msg("sectionOne_url")}">${msg("sectionOne_title")}</a></h2>
                     <p class="media-centered">${msg("sectionOne_description")}</p>
                   </div>
                 </div>
                 <div class="colophon-section">
                   <div class="section-centered">
                     <h2 class="section-header">${msg("sectionTwo_title")}</h2>
                     <div class="two-tables">
                       <table class="left-table"><tbody>
                           <tr>
                             <td class="table-link-title"><a href="${msg("sectionTwo_tableUrlOne")}">${msg("sectionTwo_tableTitleOne")}</a></td>
                             <td class="table-link-description"><a href="${msg("sectionTwo_tableUrlOne")}">${msg("sectionTwo_tableDescriptionOne")}</a></td>
                           </tr>
                           <tr>
                             <td class="table-link-title"><a href="${msg("sectionTwo_tableUrlTwo")}">${msg("sectionTwo_tableTitleTwo")}</a></td>
                             <td class="table-link-description"><a href="${msg("sectionTwo_tableUrlTwo")}">${msg("sectionTwo_tableDescriptionTwo")}</a></td>
                           </tr>
                           <tr>
                             <td class="table-link-title"><a href="${msg("sectionTwo_tableUrlThree")}">${msg("sectionTwo_tableTitleThree")}</a></td>
                             <td class="table-link-description"><a href="${msg("sectionTwo_tableUrlThree")}">${msg("sectionTwo_tableDescriptionThree")}</a></td>
                           </tr>
                           <tr>
                             <td class="table-link-title"><a href="${msg("sectionTwo_tableUrlFour")}">${msg("sectionTwo_tableTitleFour")}</a></td>
                             <td class="table-link-description"><a href="${msg("sectionTwo_tableUrlFour")}">${msg("sectionTwo_tableDescriptionFour")}</a></td>
                           </tr>
                           <tr class="">
                             <td class="table-link-title"><a href="${msg("sectionTwo_tableUrlFive")}">${msg("sectionTwo_tableTitleFive")}</a></td>
                             <td class="table-link-description"><a href="${msg("sectionTwo_tableUrlFive")}">${msg("sectionTwo_tableDescriptionFive")}</a></td>
                           </tr>
                         </tbody></table>

                         <table class="right-table"><tbody>
                             <tr>
                               <td class="table-link-description"><a href="${msg("sectionTwo_tableUrlSix")}">${msg("sectionTwo_tableDescriptionSix")}</a></td>
                               <td class="table-link-title"><a href="${msg("sectionTwo_tableUrlSix")}">${msg("sectionTwo_tableTitleSix")}</a></td>
                             </tr>
                             <tr>
                               <td class="table-link-description"><a href="${msg("sectionTwo_tableUrlSeven")}">${msg("sectionTwo_tableDescriptionSeven")}</a></td>
                               <td class="table-link-title"><a href="${msg("sectionTwo_tableUrlSeven")}">${msg("sectionTwo_tableTitleSeven")}</a></td>
                             </tr>
                             <tr>
                               <td class="table-link-description"><a href="${msg("sectionTwo_tableUrlEight")}">${msg("sectionTwo_tableDescriptionEight")}</a></td>
                               <td class="table-link-title"><a href="${msg("sectionTwo_tableUrlEight")}">${msg("sectionTwo_tableTitleEight")}</a></td>
                             </tr>
                             <tr>
                               <td class="table-link-description"><a href="${msg("sectionTwo_tableUrlNine")}">${msg("sectionTwo_tableDescriptionNine")}</a></td>
                               <td class="table-link-title"><a href="${msg("sectionTwo_tableUrlNine")}">${msg("sectionTwo_tableTitleNine")}</a></td>
                             </tr>
                             <tr>
                               <td class="table-link-description"><a href="${msg("sectionTwo_tableUrlTen")}">${msg("sectionTwo_tableDescriptionTen")}</a></td>
                               <td class="table-link-title"><a href="${msg("sectionTwo_tableUrlTen")}">${msg("sectionTwo_tableTitleTen")}</a></td>
                             </tr>
                           </tbody></table>
                     </div>
                   </div>
                 </div>
                 <div class="colophon-section">
                   <div class="section-centered">
                     <h2 class="section-header">${msg("sectionThree_title")}</h2>
                     <div class="media-centered">
                       <div class="social-media">
                         <a class="link-plain media" title="Follow us on Twitter" href="https://twitter.com/euenvironment"><i aria-hidden="true" class="fa fa-twitter-square icon"></i></a>
                         <a class="link-plain media" title="Follow us on Facebook" href="https://www.facebook.com/European.Environment.Agency"><i aria-hidden="true" class="fa fa-facebook-square icon"></i></a>
                         <a class="link-plain media" title="Follow us on LinkedIn" href="https://www.linkedin.com/company/european-environment-agency"><i aria-hidden="true" class="fa fa-linkedin-square icon"></i></a>
                         <a class="link-plain media" title="Follow us on YouTube" href="https://www.youtube.com/user/EEAvideos"><i aria-hidden="true" class="fa fa-youtube-square icon"></i></a>
                         <a class="link-plain media" title="Subscribe to RSS Feed" href="/subscription/news-feeds"><i aria-hidden="true" class="fa fa-rss-square icon"></i></a>
                       </div>
                       <a class="media" title="Subscribe by email" href="/subscription/targeted-subscription"><i aria-hidden="true" class="fa fa-newspaper-o icon"></i>
                         <div class="media-body"><span>${msg("sectionThree_descriptionOne")}</span></br><span>${msg("sectionThree_descriptionTwo")}</span></div>
                       </a>
                     </div>
                   </div>
                 </div>
                 <div class="colophon-section">
                   <div class="section-centered">
                     <h2 class="section-header">${msg("sectionFour_title")}</h2>
                     <div class="media-centered">
                       <div class="mx-2"><i aria-hidden="true" class="fa fa-map-marker icon"></i><span>${msg("sectionFour_locationLineOne")}</br>${msg("sectionFour_locationLineTwo")}</span></div>
                       <div class="mx-2"><i aria-hidden="true" class="fa fa-phone icon"></i><span>${msg("sectionFour_phoneLineOne")}</br><a href="${msg("sectionFour_phoneUrlLineTwo")}">${msg("sectionFour_phoneLineTwo")}</a></span></div>
                       <div class="mx-2"><i aria-hidden="true" class="fa fa-comment icon"></i><span><a href="${msg("sectionFour_messageUrlLineOne")}">${msg("sectionFour_messageLineOne")}</a></br><a href="${msg("sectionFour_messageUrlLineTwo")}">${msg("sectionFour_messageLineTwo")}</a></span></div>
                     </div>
                   </div>
                 </div>
               </div>
             </div -->
             <div class="kc-footer-two">
               <div class="portal-colophon">
                 <div class="colophon-section eu-section">
                   <a href="${msg("sectionFive_url")}"><span class="europe-agency-text"><img title="European Union Flag" src="${url.resourcesPath}/img/europe-flag.svg" alt="European Union Flag" height="64" class="ui image eu-flag"><span>${msg("sectionFive_title")}</span></span></a>
                 </div>
               </div>
               <div class="portal-colophon">
                 <div class="colophon-section eea-software-info">
                     <p class="colophon-links"><i aria-hidden="true" class="fa fa-database icon"></i>${msg("sectionSix_titleOne")}&nbsp;<a href="${msg("sectionSix_urlOne")}">${msg("sectionSix_titleUrlOne")}</a></p>
                     <p class="colophon-links"><a href="${msg("sectionSix_urlTwo")}" title="${msg("sectionSix_titleUrlTwo")}">${msg("sectionSix_titleUrlTwo")}</a></p>
                     <p class="colophon-links"><a href="${msg("sectionSix_urlThree")}" title="${msg("sectionSix_titleUrlThree")}">${msg("sectionSix_titleUrlThree")}</a></p>
                     <p class="colophon-links"><a href="${msg("sectionSix_urlFour")}">${msg("sectionSix_titleUrlFour")}</a></p>
                     <p class="colophon-links"><a rel="license" href="${msg("sectionSix_urlFive")}" title="${msg("sectionSix_titleUrlFive")}"><i aria-hidden="true" class="fa fa-creative-commons icon"></i><span>${msg("sectionSix_titleUrlFive")}</span></a></p>
                 </div>
             </div>
             </div>
    </div>

</div>
</body>
</html>
</#macro>
