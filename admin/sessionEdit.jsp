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
<%@ page import="org.unitime.timetable.model.DatePattern" %>
<%@ page import="org.unitime.timetable.util.Constants" %>
<%@ page import="org.unitime.timetable.webutil.JavascriptFunctions" %>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%> 
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/timetable.tld" prefix="tt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<tt:session-context/>
<SCRIPT language="javascript">
	<!--
		<%= JavascriptFunctions.getJsConfirm(sessionContext) %>
		
		function confirmDelete() {
			if (jsConfirm!=null && !jsConfirm)
				return true;

			if(confirm('The academic session and all associated data will be deleted. Continue?')) {
				return true;
			}
			return false;
		}

		function trim(str) {
			return str.replace(/^\s*(\S*(\s+\S+)*)\s*$/, "$1");		
		}
		
		function doRefresh() {
			var ss = document.forms[0].sessionStart.value;
			var se = document.forms[0].sessionEnd.value;
			var ce = document.forms[0].classesEnd.value;
			var es = document.forms[0].examStart.value;
			var evs = document.forms[0].eventStart.value;
			var eve = document.forms[0].eventEnd.value;
			var year = document.forms[0].academicYear.value;
			
			if (ss!=null && trim(ss)!=''
				 && se!=null && trim(se)!=''
				 && ce!=null && trim(ce)!=''
				 && es!=null && trim(es)!=''
				 && evs!=null && trim(evs)!=''
				 && eve!=null && trim(eve)!=''
				 && year!=null && trim(year)!='' && !isNaN(year)) {
				document.forms[0].refresh.value='1';
				var btn = document.getElementById('save');
				btn.click();
			}
		}
		
	// -->
</SCRIPT>

<html:form method="post" action="sessionEdit.do">
	<INPUT type="hidden" name="refresh" value="">
	
	<TABLE width="100%" border="0" cellspacing="0" cellpadding="3">

		<TR>
			<TD colspan="3">
				<tt:section-header>
					<tt:section-title>
						
					</tt:section-title>
					<logic:equal name="sessionEditForm" property="sessionId"	value="">
						<html:submit styleClass="btn" property="doit" accesskey="S" titleKey="title.saveSession">
							<bean:message key="button.saveSession" />
						</html:submit>
					</logic:equal>
	
					<logic:notEqual name="sessionEditForm" property="sessionId"	value="">
						<html:submit styleClass="btn" property="doit" accesskey="U" titleKey="title.updateSession">
							<bean:message key="button.updateSession" />
						</html:submit>

						<sec:authorize access="hasPermission(#sessionEditForm.sessionId, 'Session', 'AcademicSessionDelete')">
							<html:submit styleClass="btn" property="doit" accesskey="D" titleKey="title.deleteSession" onclick="return (confirmDelete());">
								<bean:message key="button.deleteSession" />
							</html:submit>
						</sec:authorize>
					</logic:notEqual>
				
					<html:submit styleClass="btn" property="doit" accesskey="B" titleKey="title.cancelSessionEdit" >
						<bean:message key="button.cancelSessionEdit" />
					</html:submit>
				</tt:section-header>			
			</TD>
		</TR>
		
		<logic:messagesPresent>
		<TR>
			<TD colspan="3" align="left" class="errorCell">
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

		<TR>
			<TD>Academic Initiative:</TD>
			<TD colspan='2'>
				<html:text property="academicInitiative" maxlength="20" size="20"/>
			</TD>
		</TR>

		<TR>
			<TD>Academic Term:</TD>
			<TD colspan='2'>
				<html:text property="academicTerm" maxlength="20" size="20"/>
			</TD>
		</TR>
		
		<TR>
			<TD>Academic Year:</TD>
			<TD colspan='2'>
				<html:text property="academicYear" onchange="doRefresh();" maxlength="4" size="4"/>
			</TD>
		</TR>
		
		<logic:notEqual name="sessionEditForm" property="sessionId"	value="">
		<TR>
			<TD>Default Date Pattern:</TD>
			<TD colspan='2'>
				<logic:empty name="<%=DatePattern.DATE_PATTERN_LIST_ATTR %>">
					No date patterns are available for this academic session
					<html:hidden property="defaultDatePatternId" />
				</logic:empty>
				
				<logic:notEmpty name="<%=DatePattern.DATE_PATTERN_LIST_ATTR %>">
					<html:select property="defaultDatePatternId">
						<html:optionsCollection name="<%=DatePattern.DATE_PATTERN_LIST_ATTR %>" value="id" label="value" />
					</html:select>
				</logic:notEmpty>
				<!--  A href="datePatternEdit.do"><I>Edit</I></A -->
			</TD>
		</TR>
		</logic:notEqual>
		
		<TR>
			<TD>Session Start Date:</TD>
			<TD colspan='2'>
				<html:text property="sessionStart" onchange="doRefresh();" style="border: #660000 2px solid;" styleId="session_start" maxlength="10" size="10"/>
				<img style="cursor: pointer;" src="scripts/jscalendar/calendar_1.gif" border="0" id="show_session_start">
			</TD>
		</TR>
		<TR>
			<TD>Classes End Date:</TD>
			<TD colspan='2'>
				<html:text property="classesEnd" onchange="doRefresh();" style="border: #339933 2px solid;" styleId="classes_end" maxlength="10" size="10"/>
				<img style="cursor: pointer;" src="scripts/jscalendar/calendar_1.gif" border="0" id="show_classes_end">
			</TD>
		</TR>
		<TR>
			<TD>Examination Start Date:</TD>
			<TD colspan='2'>
				<html:text property="examStart" onchange="doRefresh();" style="border: #999933 2px solid;" styleId="exam_start" maxlength="10" size="10"/>
				<img style="cursor: pointer;" src="scripts/jscalendar/calendar_1.gif" border="0" id="show_exam_start">
			</TD>
		</TR>
		<TR>
			<TD>Session End Date:</TD>
			<TD colspan='2'>
				<html:text property="sessionEnd" onchange="doRefresh();" style="border: #333399 2px solid;" styleId="session_end" maxlength="10" size="10"/>
				<img style="cursor: pointer;" src="scripts/jscalendar/calendar_1.gif" border="0" id="show_session_end">
			</TD>
		</TR>
		<TR>
			<TD>Event Start Date:</TD>
			<TD colspan='2'>
				<html:text property="eventStart" onchange="doRefresh();" style="border: yellow 2px solid;" styleId="event_start" maxlength="10" size="10"/>
				<img style="cursor: pointer;" src="scripts/jscalendar/calendar_1.gif" border="0" id="show_event_start">
			</TD>
		</TR>
		<TR>
			<TD>Event End Date:</TD>
			<TD colspan='2'>
				<html:text property="eventEnd" onchange="doRefresh();" style="border: red 2px solid;" styleId="event_end" maxlength="10" size="10"/>
				<img style="cursor: pointer;" src="scripts/jscalendar/calendar_1.gif" border="0" id="show_event_end">
			</TD>
		</TR>

		<TR>
			<TD>Session Status:</TD>
			<TD colspan='2'>
				<html:select property="status">
					<html:option value="<%= Constants.BLANK_OPTION_VALUE %>"><%= Constants.BLANK_OPTION_LABEL %></html:option>
					<html:optionsCollection property="statusOptions" value="reference" label="label" />
				</html:select>
			</TD>
		</TR>
		
		<% if (request.getAttribute("Sessions.holidays")!=null) { %>
			<TR>
				<TD>Holidays:</TD><TD colspan='2'></TD>
			</TR><TR>
				<TD colspan='3'><%=request.getAttribute("Sessions.holidays")%></TD>
			</TR>
		<% } %>

		<TR>
			<TD colspan='3'>
				<tt:section-title><br>Online Student Scheduling Default Settings</tt:section-title>
			</TD>
		</TR>
		
		<TR>
			<TD valign="top">New Enrollment Deadline:</TD>
			<TD valign="top">
				<html:text property="wkEnroll" maxlength="4" size="4"/>
			</TD><TD>
				<i>Number of weeks during which students are allowed to enroll to a new course.<br>
				Weeks start on the day of session start date, number of weeks is relative to class start.<br>
				For instance, 1 means that new enrollments will be allowed during the first week of classes.</i>
			</TD>
		</TR>
		<TR>
			<TD valign="top">Class Changes Deadline:</TD>
			<TD valign="top">
				<html:text property="wkChange" maxlength="4" size="4"/>
			</TD><TD>
				<i>Number of weeks during which students are allowed to change existing enrollments.<br>
				If smaller than new enrollment deadline, they will not be able to add a new course to their schedule during the weeks between the two.</i>
			</TD>
		</TR>
		<TR>
			<TD valign="top">Course Drop Deadline:</TD>
			<TD valign="top">
				<html:text property="wkDrop" maxlength="4" size="4"/>
			</TD><TD>
				<i>Number of weeks during which students are allowed to drop from courses they are enrolled into.<br>
			</TD>
		</TR>
		<TR>
			<TD>Deafult Student Scheduling Status:</TD>
			<TD colspan="2">
				<html:select property="sectStatus">
					<html:option value="-1">System Default (No Restrictions)</html:option>
					<html:optionsCollection property="sectStates" value="id" label="value" />
				</html:select>
			</TD>
		</TR>
		
		</TR>
			<TD colspan="3">
			<DIV class="WelcomeRowHeadBlank">&nbsp;</DIV>
			</TD>
		</TR>
		
		<TR>
			<TD colspan="3" align="right">

			<TABLE>
				<TR>
					<TD align="right" nowrap>
						<logic:equal name="sessionEditForm" property="sessionId" value="">
							<html:submit styleClass="btn" property="doit" styleId="save" accesskey="S" titleKey="title.saveSession">
								<bean:message key="button.saveSession" />
							</html:submit>
						</logic:equal>
		
						<logic:notEqual name="sessionEditForm" property="sessionId"	value="">
							<html:submit styleClass="btn" property="doit" styleId="save" accesskey="U" titleKey="title.updateSession">
								<bean:message key="button.updateSession" />
							</html:submit>
	
							<sec:authorize access="hasPermission(#sessionEditForm.sessionId, 'Session', 'AcademicSessionDelete')">
								<html:submit styleClass="btn" property="doit" accesskey="D" titleKey="title.deleteSession" onclick="return (confirmDelete());">
									<bean:message key="button.deleteSession" />
								</html:submit>
							</sec:authorize>
						</logic:notEqual>
					
					<html:submit styleClass="btn" property="doit" accesskey="B" titleKey="title.cancelSessionEdit" >
						<bean:message key="button.cancelSessionEdit" />
					</html:submit>
					</TD>
				</TR>
				
			</TABLE>
			
			</TD>
		</TR>
	</TABLE>
	
	<html:hidden property="sessionId" />
</html:form>

<script type="text/javascript" language="javascript">
	
	Calendar.setup( {
		cache      : true, 					// Single object used for all calendars
		electric   : false, 				// Changes date only when calendar is closed
		inputField : "session_start",		// ID of the input field
	    ifFormat   : "%m/%d/%Y", 			// Format of the input field
	    showOthers : true,					// Show overlap of dates from other months	    
	    date		: <%=request.getParameter("sessionStart") != null && request.getParameter("sessionStart").length() >= 10 ? request.getParameter("sessionStart") : null%>,
		button     : "show_session_start"	// ID of the button
	} );

	Calendar.setup( {
		cache      : true, 					// Single object used for all calendars
		electric   : false, 				// Changes date only when calendar is closed
		inputField : "session_end",			// ID of the input field
	    ifFormat   : "%m/%d/%Y", 			// Format of the input field
	    showOthers : true,					// Show overlap of dates from other months	    
	    date		: <%=request.getParameter("sessionEnd") != null && request.getParameter("sessionEnd").length() >= 10 ? request.getParameter("sessionEnd") : null%>,
		button     : "show_session_end" 	// ID of the button
	} );
	
	Calendar.setup( {
		cache      : true, 					// Single object used for all calendars
		electric   : false, 				// Changes date only when calendar is closed
		inputField : "classes_end",			// ID of the input field
	    ifFormat   : "%m/%d/%Y", 			// Format of the input field
	    showOthers : true,					// Show overlap of dates from other months	    
	    date		: <%=request.getParameter("classesEnd") != null && request.getParameter("classesEnd").length() >= 10 ? request.getParameter("classesEnd") : null%>,
		button     : "show_classes_end" 	// ID of the button
	} );

	Calendar.setup( {
		cache      : true, 					// Single object used for all calendars
		electric   : false, 				// Changes date only when calendar is closed
		inputField : "exam_start",		// ID of the input field
	    ifFormat   : "%m/%d/%Y", 			// Format of the input field
	    showOthers : true,					// Show overlap of dates from other months	    
	    date		: <%=request.getParameter("examStart") != null && request.getParameter("examStart").length() >= 10 ? request.getParameter("examStart") : null%>,
		button     : "show_exam_start"	// ID of the button
	} );

	Calendar.setup( {
		cache      : true, 					// Single object used for all calendars
		electric   : false, 				// Changes date only when calendar is closed
		inputField : "event_start",		// ID of the input field
	    ifFormat   : "%m/%d/%Y", 			// Format of the input field
	    showOthers : true,					// Show overlap of dates from other months	    
	    date		: <%=request.getParameter("eventStart") != null && request.getParameter("eventStart").length() >= 10 ? request.getParameter("eventStart") : null%>,
		button     : "show_event_start"	// ID of the button
	} );

	Calendar.setup( {
		cache      : true, 					// Single object used for all calendars
		electric   : false, 				// Changes date only when calendar is closed
		inputField : "event_end",		// ID of the input field
	    ifFormat   : "%m/%d/%Y", 			// Format of the input field
	    showOthers : true,					// Show overlap of dates from other months	    
	    date		: <%=request.getParameter("eventEnd") != null && request.getParameter("eventEnd").length() >= 10 ? request.getParameter("eventEnd") : null%>,
		button     : "show_event_end"	// ID of the button
	} );

</script>
