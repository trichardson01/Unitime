<%-- 
 * UniTime 3.2 (University Timetabling Application)
 * Copyright (C) 2008 - 2010, UniTime LLC
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 --%>
<%@ page language="java" pageEncoding="ISO-8859-1"%>
<%@ page import="org.unitime.timetable.form.RollForwardSessionForm"%>
<%@ page import="org.unitime.timetable.util.SessionRollForward"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tld/timetable.tld" prefix="tt" %>
 
<html> 
	<head>
		<title>Roll Forward Session</title>
	</head>
	<body>
<script language="javascript">displayLoading();</script>
	<%// Get Form 
			String frmName = "rollForwardSessionForm";
			RollForwardSessionForm frm = (RollForwardSessionForm) request.getAttribute(frmName);
	%>
		<html:form action="/rollForwardSession">
		<table width="100%" cellspacing="0" cellpadding="3">
		<logic:messagesPresent>
		<TR>
			<TD align="left" class="errorCell">
					<B><U>ERRORS</U></B><BR>
				<BLOCKQUOTE>
				<UL>
				    <html:messages id="error">
				      <LI>
						${error}
				      </LI>
				    </html:messages>
			    </UL>
			    </BLOCKQUOTE>
			</TD>
		</TR>
		</logic:messagesPresent>
	<logic:notEmpty name="table" scope="request">
		<TR><TD>
			<tt:section-header>
				<tt:section-title>Roll Forward(s) In Progress</tt:section-title>
				<html:submit property="op" accesskey="R" styleClass="btn" onclick="displayElement('loading', true);">Refresh</html:submit>
			</tt:section-header>
		</TD></TR>
		<TR><TD>
			<TABLE width="100%" border="0" cellspacing="0" cellpadding="3">
				<bean:write name="table" scope="request" filter="false"/>
			</TABLE>
		</TD></TR>
		<TR><TD>&nbsp;</TD></TR>
	</logic:notEmpty>
			
	<TR><TD>
		<tt:section-header>
			<tt:section-title>Roll Forward Actions</tt:section-title>
					<html:submit property="op" accesskey="M" styleClass="btn" onclick="displayElement('loading', true);">
					<bean:message key="button.rollForward" />
				</html:submit>
		</tt:section-header>
	</TD></TR>
		<tr>
			<td valign="middle" nowrap ><b>Session To Roll Forward To: </b>
			<html:select style="width:200px;" property="sessionToRollForwardTo" onchange="displayElement('loading', true);submit();">
			<html:optionsCollection property="toSessions" value="uniqueId" label="label"  /></html:select>
			</td>			
		</tr>
		<tr>
		<td>&nbsp;
		</td>
		</tr>
		<tr>
			<td valign="middle" nowrap ><html:checkbox name="<%=frmName%>" property="rollForwardDepartments"/> Roll Departments Forward From Session: 
			<html:select style="width:200px;" property="sessionToRollDeptsFowardFrom">
			<html:optionsCollection property="fromSessions" value="uniqueId" label="label" /></html:select>
			</td>			
		</tr>
		<tr>
			<td valign="middle" nowrap><html:checkbox name="<%=frmName%>" property="rollForwardSessionConfig" onclick="document.getElementById('configNote').style.display = (this.checked ? 'table-row' : 'none');"/> Roll Session Configuration Forward From Session: 
			<html:select style="width:200px;" property="sessionToRollSessionConfigForwardFrom">
			<html:optionsCollection property="fromSessions" value="uniqueId" label="label" /></html:select>
		</tr>
		<tr style="display:none;" id="configNote">
			<td valign="middle" style="white-space: wrap; max-width: 600px; padding-left: 20px;">
				<i>Session configuration contains application configuration, standard notes, event room notes, and break times that are applied directly to the session and/or its department(s).
				Individual room notes and break times are rolled forward with the rooms.</i>
			</td>
		</tr>
		<logic:equal name="<%=frmName%>" property="rollForwardSessionConfig" value="true">
			<script>document.getElementById('configNote').style.display = 'table-row';</script>
		</logic:equal>
		<tr>
			<td valign="middle" nowrap ><html:checkbox name="<%=frmName%>" property="rollForwardManagers"/> Roll Manager Data Forward From Session: 
			<html:select style="width:200px;" property="sessionToRollManagersForwardFrom">
			<html:optionsCollection property="fromSessions" value="uniqueId" label="label" /></html:select>
			</td>			
		</tr>
		<tr>
			<td valign="middle" nowrap ><html:checkbox name="<%=frmName%>" property="rollForwardRoomData"/> Roll Building and Room Data Forward From Session: 
			<html:select style="width:200px;" property="sessionToRollRoomDataForwardFrom">
			<html:optionsCollection property="fromSessions" value="uniqueId" label="label" /></html:select>
			</td>			
		</tr>
		<tr>
			<td valign="middle" nowrap ><html:checkbox name="<%=frmName%>" property="rollForwardDatePatterns"/> Roll Date Pattern Data Forward From Session: 
			<html:select style="width:200px;" property="sessionToRollDatePatternsForwardFrom">
			<html:optionsCollection property="fromSessions" value="uniqueId" label="label" /></html:select>
			</td>			
		</tr>
		<tr>
			<td valign="middle" nowrap ><html:checkbox name="<%=frmName%>" property="rollForwardTimePatterns"/> Roll Time Pattern Data Forward From Session: 
			<html:select style="width:200px;" property="sessionToRollTimePatternsForwardFrom">
			<html:optionsCollection property="fromSessions" value="uniqueId" label="label" /></html:select>
			</td>			
		</tr>
		<tr>
			<td valign="middle" nowrap><html:checkbox name="<%=frmName%>" property="rollForwardSubjectAreas"/> Roll Subject Areas Forward From Session: 
			<html:select style="width:200px;" property="sessionToRollSubjectAreasForwardFrom">
			<html:optionsCollection property="fromSessions" value="uniqueId" label="label" /></html:select>
			</td>			
		</tr>
		<tr>
			<td valign="middle" nowrap><html:checkbox name="<%=frmName%>" property="rollForwardInstructorData"/> Roll Instructor Data Forward From Session: 
			<html:select style="width:200px;" property="sessionToRollInstructorDataForwardFrom">
			<html:optionsCollection property="fromSessions" value="uniqueId" label="label" /></html:select>
			</td>			
		</tr>
		<tr>
			<td valign="middle" nowrap><html:checkbox name="<%=frmName%>" property="rollForwardCourseOfferings"/> Roll Course Offerings Forward From Session: 
			<html:select style="width:200px;" property="sessionToRollCourseOfferingsForwardFrom">
			<html:optionsCollection property="fromSessions" value="uniqueId" label="label" /></html:select>
			</td>			
		</tr>
		<tr>
			<td valign="middle">
			<table style="margin-left: 50px;"><tr>
			    <td valign="top">For Subject Areas:</td>
			    <td><html:select size="<%=String.valueOf(Math.min(7,frm.getSubjectAreas().size()))%>" name="<%=frmName%>" styleClass="cmb" property="rollForwardSubjectAreaIds" multiple="true" onfocus="setUp();" onkeypress="return selectSearch(event, this);" onkeydown="return checkKey(event, this);">
					<html:optionsCollection property="subjectAreas" label="subjectAreaAbbreviation" value="uniqueId" />
				</html:select>
			    </td></tr>
			<tr><td style="padding-top: 20px;" rowspan="2" valign="top">Scheduling Subpart Level Time Preference Options:</td><td style="padding-top: 20px;"><html:radio property="subpartTimePrefsAction" value="<%= SessionRollForward.ROLL_PREFS_ACTION %>"> Roll forward scheduling subpart time preferences</html:radio></td></tr>
			<tr><td><html:radio property="subpartTimePrefsAction" value="<%= SessionRollForward.DO_NOT_ROLL_ACTION %>"> Do not roll forward scheduling subpart time preferences</html:radio></td></tr>
			<tr><td style="padding-top: 20px;" rowspan="2" valign="top">Scheduling Subpart Level Location Preference Options:</td><td style="padding-top: 20px;"><html:radio property="subpartLocationPrefsAction" value="<%= SessionRollForward.ROLL_PREFS_ACTION %>"> Roll forward scheduling subpart location preferences</html:radio></td></tr>
			<tr><td><html:radio property="subpartLocationPrefsAction" value="<%= SessionRollForward.DO_NOT_ROLL_ACTION %>"> Do not roll forward scheduling subpart location preferences</html:radio></td></tr>
			<tr><td style="padding-top: 20px;" rowspan="2" valign="top">Class Level Preference Options:</td><td style="padding-top: 20px;"><html:radio property="classPrefsAction" value="<%= SessionRollForward.DO_NOT_ROLL_ACTION %>"> Ignore all class level preferences</html:radio></td></tr>
			<tr><td><html:radio property="classPrefsAction" value="<%= SessionRollForward.PUSH_UP_ACTION %>"> Promote appropriate class level preferences to subparts</html:radio></td></tr>
			<tt:propertyEquals name="unitime.rollforward.allowClassPrefs" value="true">
				<tr><td></td><td><html:radio property="classPrefsAction" value="<%= SessionRollForward.ROLL_PREFS_ACTION %>"> Roll forward class level preferences</html:radio></td></tr>
			</tt:propertyEquals>
			</table>
			</td>
		</tr>
		<tr>
			<td valign="middle">
			<table><tr>	<td valign="middle" nowrap><html:checkbox name="<%=frmName%>" property="rollForwardClassInstructors"/> Roll Forward Class Instructors For Subject Areas: 
				</td><td>
				<html:select size="<%=String.valueOf(Math.min(7,frm.getSubjectAreas().size()))%>" name="<%=frmName%>" styleClass="cmb" property="rollForwardClassInstrSubjectIds" multiple="true" onfocus="setUp();" onkeypress="return selectSearch(event, this);" onkeydown="return checkKey(event, this);">
					<html:optionsCollection property="subjectAreas" label="subjectAreaAbbreviation" value="uniqueId" />
				</html:select>
			</td></tr></table>
			</td>
		</tr>
		<tr>
			<td valign="middle">
			<table>
				<tr>
					<td valign="middle" nowrap><html:checkbox name="<%=frmName%>" property="addNewCourseOfferings"/>Add New Course Offerings For Subject Areas:
					<div style="margin-left: 20px;"><i>Note: Only use this after all existing course<br> offerings have been rolled forward to avoid<br> errors with cross lists.</i></div>
				</td><td>
				<html:select size="<%=String.valueOf(Math.min(7,frm.getSubjectAreas().size()))%>" name="<%=frmName%>" styleClass="cmb" property="addNewCourseOfferingsSubjectIds" multiple="true" onfocus="setUp();" onkeypress="return selectSearch(event, this);" onkeydown="return checkKey(event, this);">
					<html:optionsCollection property="subjectAreas" label="subjectAreaAbbreviation" value="uniqueId" />
				</html:select>
			</td></tr></table>
			</td>
		</tr>
		<tr>
			<td valign="middle" nowrap><html:checkbox name="<%=frmName%>" property="rollForwardExamConfiguration"/> Roll Exam Configuration Data Forward From Session: 
			<html:select style="width:200px;" property="sessionToRollExamConfigurationForwardFrom">
			<html:optionsCollection property="fromSessions" value="uniqueId" label="label" /></html:select>
			</td>			
		</tr>
		<tr>
			<td valign="middle" nowrap><html:checkbox name="<%=frmName%>" property="rollForwardMidtermExams"/> Roll Midterm Exams Forward
			<table style="margin-left: 50px;"><tr>
			    <tr><td rowspan="3" valign="top">Preferences:</td>
			    <td><html:radio property="midtermExamsPrefsAction" value="<%= SessionRollForward.EXAMS_ALL_PREF %>">Roll forward all midterm examination preferences</html:radio></td></tr>
			    <tr><td><html:radio property="midtermExamsPrefsAction" value="<%= SessionRollForward.EXAMS_ROOM_PREFS %>">Roll forward building, room feature and room group preferences (exclude period and individual room preferences)</html:radio></td></tr>
			    <tr><td><html:radio property="midtermExamsPrefsAction" value="<%= SessionRollForward.EXAMS_NO_PREF %>">Do not roll forward any midterm examination preferences</html:radio></td></tr>
			</table>
			</td>	
		</tr>
		<tr>
			<td valign="middle" nowrap><html:checkbox name="<%=frmName%>" property="rollForwardFinalExams"/> Roll Final Exams Forward
			<table style="margin-left: 50px;"><tr>
			    <tr><td rowspan="3" valign="top">Preferences:</td>
			    <td><html:radio property="finalExamsPrefsAction" value="<%= SessionRollForward.EXAMS_ALL_PREF %>">Roll forward all final examination preferences</html:radio></td></tr>
			    <tr><td><html:radio property="finalExamsPrefsAction" value="<%= SessionRollForward.EXAMS_ROOM_PREFS %>">Roll forward building, room feature and room group preferences (exclude period and individual room preferences)</html:radio></td></tr>
			    <tr><td><html:radio property="finalExamsPrefsAction" value="<%= SessionRollForward.EXAMS_NO_PREF %>">Do not roll forward any final examination preferences</html:radio></td></tr>
			</table>
			</td>		
		</tr>
		<tr>
			<td valign="middle" nowrap><html:checkbox name="<%=frmName%>" property="rollForwardStudents"/> Import Last-Like Course Demands
				<html:select property="rollForwardStudentsMode">
					<html:option value="0">Copy Last-like Course Demands From Previous Session</html:option>
					<html:option value="1">Import Last-like Course Demands From Student Class Enrollments Of Previous Session</html:option>
					<html:option value="2">Import Last-like Course Demands From Course Requests Of Previous Session</html:option>
				</html:select>
			</td>		
		</tr>
		<tr>
			<td valign="middle" nowrap><html:checkbox name="<%=frmName%>" property="rollForwardCurricula"/> Roll Curricula Forward From Session: 
			<html:select style="width:200px;" property="sessionToRollCurriculaForwardFrom">
			<html:optionsCollection property="fromSessions" value="uniqueId" label="label" /></html:select>
			<br/><i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This will also roll academic areas, classifications, majors, minors, and projection rules forward (if these are not already present in the target academic session).</i>
			</td>
		</tr>
		<tr>
			<td valign="middle" nowrap><html:checkbox name="<%=frmName%>" property="rollForwardReservations" onclick="document.getElementById('reservationDetail').style.display = (this.checked ? 'table-row' : 'none');"/> Roll Reservations Forward From Session: 
			<html:select style="width:200px;" property="sessionToRollReservationsForwardFrom">
			<html:optionsCollection property="fromSessions" value="uniqueId" label="label" /></html:select>
			</td>
		</tr>
		<tr style="display:none;" id="reservationDetail">
			<td valign="middle">
			<table style="margin-left: 50px;"><tr>
			    <td valign="top" nowrap width="20%">For Subject Areas:</td>
			    <td><html:select size="<%=String.valueOf(Math.min(7,frm.getSubjectAreas().size()))%>" name="<%=frmName%>" styleClass="cmb" property="rollForwardReservationsSubjectIds" multiple="true" onfocus="setUp();" onkeypress="return selectSearch(event, this);" onkeydown="return checkKey(event, this);">
					<html:optionsCollection property="subjectAreas" label="subjectAreaAbbreviation" value="uniqueId" />
				</html:select>
			    </td></tr>
			<tr><td valign="top" colspan="2">
				<html:checkbox name="<%=frmName%>" property="rollForwardCourseReservations" onclick="document.getElementById('courseReservationDetail').style.display = (this.checked ? 'table-row' : 'none');"/> Include Course Reservations
			</td></tr>
			<tr style="display:none;" id="courseReservationDetail"><td style="padding-left: 50px; vertical-align: middle;" valign="top" colspan="2">
				New Expiration Date: <html:text property="expirationCourseReservations" maxlength="10" size="10" styleId="epxiration_courses"/><img style="cursor: pointer;" src="scripts/jscalendar/calendar_1.gif" border="0" id="show_epxiration_courses">
				&nbsp;&nbsp;&nbsp;&nbsp;<i>Applies to course reservations with an expiration date filled in.</i>
			</td></tr>
			<tr><td valign="top" colspan="2">
				<html:checkbox name="<%=frmName%>" property="rollForwardCurriculumReservations" onclick="document.getElementById('curriculumReservationDetail').style.display = (this.checked ? 'table-row' : 'none');"/> Include Curriculum Reservations
			<tr style="display:none;" id="curriculumReservationDetail"><td style="padding-left: 50px; vertical-align: middle;" valign="top" colspan="2">
				New Expiration Date: <html:text property="expirationCurriculumReservations" maxlength="10" size="10" styleId="epxiration_curricula"/><img style="cursor: pointer;" src="scripts/jscalendar/calendar_1.gif" border="0" id="show_epxiration_curricula">
				&nbsp;&nbsp;&nbsp;&nbsp;<i>Applies to curriculum reservations with an expiration date filled in.</i>
			</td></tr>
			<tr><td valign="top" colspan="2">
				<html:checkbox name="<%=frmName%>" property="rollForwardGroupReservations" onclick="document.getElementById('groupReservationDetail').style.display = (this.checked ? 'table-row' : 'none');"/> Include Student Group Reservations
			<tr style="display:none;" id="groupReservationDetail"><td style="padding-left: 50px; vertical-align: middle;" valign="top" colspan="2">
				New Expiration Date: <html:text property="expirationGroupReservations" maxlength="10" size="10" styleId="epxiration_groups"/><img style="cursor: pointer;" src="scripts/jscalendar/calendar_1.gif" border="0" id="show_epxiration_groups">
				&nbsp;&nbsp;&nbsp;&nbsp;<i>Applies to student group reservations with an expiration date filled in.</i><br>
				<html:checkbox name="<%=frmName%>" property="createStudentGroupsIfNeeded"/> Create student groups that do not exist (with no students). Ignore group reservations that do not match otherwise.
			</td></tr>
			</table>
			</td>
		</tr>
		<logic:equal name="<%=frmName%>" property="rollForwardReservations" value="true">
			<script>document.getElementById('reservationDetail').style.display = 'table-row';</script>
		</logic:equal>
		<logic:equal name="<%=frmName%>" property="rollForwardCourseReservations" value="true">
			<script>document.getElementById('courseReservationDetail').style.display = 'table-row';</script>
		</logic:equal>
		<logic:equal name="<%=frmName%>" property="rollForwardCurriculumReservations" value="true">
			<script>document.getElementById('curriculumReservationDetail').style.display = 'table-row';</script>
		</logic:equal>
		<logic:equal name="<%=frmName%>" property="rollForwardGroupReservations" value="true">
			<script>document.getElementById('groupReservationDetail').style.display = 'table-row';</script>
		</logic:equal>
		<tr>
			<td class="WelcomeRowHead">
			&nbsp;
			</td>
		</tr>
		<tr>
			<td align="right">
					<html:submit property="op" accesskey="M" styleClass="btn" onclick="displayElement('loading', true);">
						<bean:message key="button.rollForward" />
					</html:submit>
			</TD>
		</TR>
		</TABLE>
		</html:form>
	<script language="javascript">displayElement('loading', false);</script>
	</body>
</html>

<script type="text/javascript" language="javascript">
	
	Calendar.setup( {
		cache      : true, 					// Single object used for all calendars
		electric   : false, 				// Changes date only when calendar is closed
		inputField : "epxiration_courses",		// ID of the input field
	    ifFormat   : "%m/%d/%Y", 			// Format of the input field
	    showOthers : true,					// Show overlap of dates from other months	    
	    date		: <%=request.getParameter("expirationCourseReservations") != null && request.getParameter("expirationCourseReservations").length() >= 10 ? request.getParameter("expirationCourseReservations") : null%>,
		button     : "show_epxiration_courses"	// ID of the button
	} );

	Calendar.setup( {
		cache      : true, 					// Single object used for all calendars
		electric   : false, 				// Changes date only when calendar is closed
		inputField : "epxiration_curricula",			// ID of the input field
	    ifFormat   : "%m/%d/%Y", 			// Format of the input field
	    showOthers : true,					// Show overlap of dates from other months	    
	    date		: <%=request.getParameter("expirationCurriculumReservations") != null && request.getParameter("expirationCurriculumReservations").length() >= 10 ? request.getParameter("expirationCurriculumReservations") : null%>,
		button     : "show_epxiration_curricula" 	// ID of the button
	} );
	
	Calendar.setup( {
		cache      : true, 					// Single object used for all calendars
		electric   : false, 				// Changes date only when calendar is closed
		inputField : "epxiration_groups",			// ID of the input field
	    ifFormat   : "%m/%d/%Y", 			// Format of the input field
	    showOthers : true,					// Show overlap of dates from other months	    
	    date		: <%=request.getParameter("expirationGroupReservations") != null && request.getParameter("expirationGroupReservations").length() >= 10 ? request.getParameter("expirationGroupReservations") : null%>,
		button     : "show_epxiration_groups" 	// ID of the button
	} );

</script>