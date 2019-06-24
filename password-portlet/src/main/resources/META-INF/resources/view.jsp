
<%@page import="com.liferay.portal.kernel.exception.UserPasswordException"%>

<%@ include file="/init.jsp" %>

<liferay-ui:error exception="<%= UserPasswordException.MustBeLonger.class %>">

	<%
	UserPasswordException.MustBeLonger upe = (UserPasswordException.MustBeLonger)errorException;
	%>

	<liferay-ui:message arguments="<%= String.valueOf(upe.minLength) %>" key="that-password-is-too-short" translateArguments="<%= false %>" />
</liferay-ui:error>

<liferay-ui:error exception="<%= UserPasswordException.MustComplyWithModelListeners.class %>" message="that-password-is-invalid-please-enter-a-different-password" />

<liferay-ui:error exception="<%= UserPasswordException.MustComplyWithRegex.class %>">

	<%
	UserPasswordException.MustComplyWithRegex upe = (UserPasswordException.MustComplyWithRegex)errorException;
	%>

	<liferay-ui:message arguments="<%= upe.regex %>" key="that-password-does-not-comply-with-the-regular-expression" translateArguments="<%= false %>" />
</liferay-ui:error>

<liferay-ui:error exception="<%= UserPasswordException.MustHaveMoreAlphanumeric.class %>">

	<%
	UserPasswordException.MustHaveMoreAlphanumeric upe = (UserPasswordException.MustHaveMoreAlphanumeric)errorException;
	%>

	<liferay-ui:message arguments="<%= String.valueOf(upe.minAlphanumeric) %>" key="that-password-must-contain-at-least-x-alphanumeric-characters" translateArguments="<%= false %>" />
</liferay-ui:error>

<liferay-ui:error exception="<%= UserPasswordException.MustHaveMoreLowercase.class %>">

	<%
	UserPasswordException.MustHaveMoreLowercase upe = (UserPasswordException.MustHaveMoreLowercase)errorException;
	%>

	<liferay-ui:message arguments="<%= String.valueOf(upe.minLowercase) %>" key="that-password-must-contain-at-least-x-lowercase-characters" translateArguments="<%= false %>" />
</liferay-ui:error>

<liferay-ui:error exception="<%= UserPasswordException.MustHaveMoreNumbers.class %>">

	<%
	UserPasswordException.MustHaveMoreNumbers upe = (UserPasswordException.MustHaveMoreNumbers)errorException;
	%>

	<liferay-ui:message arguments="<%= String.valueOf(upe.minNumbers) %>" key="that-password-must-contain-at-least-x-numbers" translateArguments="<%= false %>" />
</liferay-ui:error>

<liferay-ui:error exception="<%= UserPasswordException.MustHaveMoreSymbols.class %>">

	<%
	UserPasswordException.MustHaveMoreSymbols upe = (UserPasswordException.MustHaveMoreSymbols)errorException;
	%>

	<liferay-ui:message arguments="<%= String.valueOf(upe.minSymbols) %>" key="that-password-must-contain-at-least-x-symbols" translateArguments="<%= false %>" />
</liferay-ui:error>

<liferay-ui:error exception="<%= UserPasswordException.MustHaveMoreUppercase.class %>">

	<%
	UserPasswordException.MustHaveMoreUppercase upe = (UserPasswordException.MustHaveMoreUppercase)errorException;
	%>

	<liferay-ui:message arguments="<%= String.valueOf(upe.minUppercase) %>" key="that-password-must-contain-at-least-x-uppercase-characters" translateArguments="<%= false %>" />
</liferay-ui:error>

<liferay-ui:error exception="<%= UserPasswordException.MustMatch.class %>" message="the-passwords-you-entered-do-not-match" />
<liferay-ui:error exception="<%= UserPasswordException.MustMatchCurrentPassword.class %>" message="the-password-you-entered-for-the-current-password-does-not-match-your-current-password" />
<liferay-ui:error exception="<%= UserPasswordException.MustNotBeChanged.class %>" message="passwords-may-not-be-changed-under-the-current-password-policy" />

<liferay-ui:error exception="<%= UserPasswordException.MustNotBeChangedYet.class %>">

	<%
	UserPasswordException.MustNotBeChangedYet upe = (UserPasswordException.MustNotBeChangedYet)errorException;
	%>

	<liferay-ui:message arguments="<%= String.valueOf(upe.changeableDate) %>" key="you-cannot-change-your-password-yet" translateArguments="<%= false %>" />
</liferay-ui:error>

<liferay-ui:error exception="<%= UserPasswordException.MustNotBeEqualToCurrent.class %>" message="your-new-password-cannot-be-the-same-as-your-old-password-please-enter-a-different-password" />
<liferay-ui:error exception="<%= UserPasswordException.MustNotBeNull.class %>" message="the-password-cannot-be-blank" />
<liferay-ui:error exception="<%= UserPasswordException.MustNotBeRecentlyUsed.class %>" message="that-password-has-already-been-used-please-enter-a-different-password" />
<liferay-ui:error exception="<%= UserPasswordException.MustNotBeTrivial.class %>" message="that-password-uses-common-words-please-enter-a-password-that-is-harder-to-guess-i-e-contains-a-mix-of-numbers-and-letters" />
<liferay-ui:error exception="<%= UserPasswordException.MustNotContainDictionaryWords.class %>" message="that-password-uses-common-dictionary-words" />


<liferay-portlet:actionURL name="change" var="greetURL" />

<aui:form action="<%= greetURL %>" method="post" name="fm">
	<aui:input name="p_u_i_d" type="hidden" value="<%= user.getUserId() %>" />

	<div class="sheet-section">
		<h3 class="sheet-subtitle"><liferay-ui:message key="password" /></h3>

		<aui:fieldset>

			<!-- Begin LPS-38289 and LPS-55993 and LPS-61876 -->

			<input class="hide" type="password" />
			<input class="hide" type="password" />

			<!-- End LPS-38289 and LPS-55993 and LPS-61876 -->

			<aui:input autocomplete="off" label="current-password" name="password0" required="<%= true %>" size="30" type="password" />

			<aui:input autocomplete="off" label="new-password" name="password1" required="<%= true %>" size="30" type="password" />

			<aui:input autocomplete="off" label="enter-again" name="password2" required="<%= true %>" size="30" type="password">
				<aui:validator name="equalTo">
					'#<portlet:namespace />password1'
				</aui:validator>
			</aui:input>

		</aui:fieldset>
	</div>

	<aui:button-row>
		<aui:button type="submit"></aui:button>
	</aui:button-row>
</aui:form>
