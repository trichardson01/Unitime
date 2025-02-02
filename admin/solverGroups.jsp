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
<%@ page language="java" autoFlush="true"%>
<%@ page import="org.unitime.timetable.util.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tld/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/tld/timetable.tld" prefix="tt" %>

<tiles:importAttribute />

<tt:confirm name="confirmDelete">The solver group will be deleted. Continue?</tt:confirm>
<tt:confirm name="confirmDeleteAll">All solver groups that have no solutions saved will be deleted. Continue?</tt:confirm>
<tt:confirm name="confirmAutoSetup">New solver groups may be created. Continue?</tt:confirm>
<tt:session-context/>
<html:form action="/solverGroupEdit">
<html:hidden property="uniqueId"/><html:errors property="uniqueId"/>
<html:hidden property="departmentsEditable"/><html:errors property="departmentsEditable"/>

<logic:notEqual name="solverGroupEditForm" property="op" value="List">
	<TABLE width="100%" border="0" cellspacing="0" cellpadding="3">
		<TR>
			<TD colspan="2">
				<tt:section-header>
					<tt:section-title>
						<logic:equal name="solverGroupEditForm" property="op" value="Save">
						Add
						</logic:equal>
						<logic:notEqual name="solverGroupEditForm" property="op" value="Save">
						Edit
						</logic:notEqual>
						Solver Group
					</tt:section-title>
					<logic:equal name="solverGroupEditForm" property="op" value="Save">
						<html:submit property="op" value="Save" accesskey="S" title="Save Solver Group (Alt+S)"/>
					</logic:equal>
					<logic:notEqual name="solverGroupEditForm" property="op" value="Save">
						<html:submit property="op" value="Update" accesskey="U" title="Update Solver Group (Alt+U)"/>
						<logic:equal name="solverGroupEditForm" property="departmentsEditable" value="true">
							<html:submit property="op" value="Delete" onclick="return confirmDelete();" accesskey="D" title="Delete Solver Group (Alt+D)"/>
						</logic:equal> 
					</logic:notEqual>
					<html:submit property="op" value="Back" title="Return to Solver Groups (Alt+B)" accesskey="B"/>
				</tt:section-header>
			</TD>
		</TR>

		<TR>
			<TD>Abbreviation:</TD>
			<TD>
				<html:text property="abbv" size="10" maxlength="100"/>
				&nbsp;<html:errors property="abbv"/>
			</TD>
		</TR>

		<TR>
			<TD>Name:</TD>
			<TD>
				<html:text property="name" size="50" maxlength="100"/>
				&nbsp;<html:errors property="name"/>
			</TD>
		</TR>
		
		<logic:equal name="solverGroupEditForm" property="departmentsEditable" value="false">
			<TR><TD colspan='2'>&nbsp;</TD></TR>
			<TR><TD colspan='2'><tt:section-header title="Departments"/></TD></TR>
			<logic:iterate name="solverGroupEditForm" property="departmentIds" id="departmentId" indexId="ctr">
				<logic:equal name="solverGroupEditForm" property='<%="assignedDepartments["+ctr+"]"%>' value="true">
					<TR><TD colspan='2'>&nbsp;&nbsp;&nbsp;&nbsp;
							<html:hidden property='<%="departmentIds["+ctr+"]"%>'/>
							<html:hidden property='<%="departmentNames["+ctr+"]"%>'/>
							<html:hidden property='<%="assignedDepartments["+ctr+"]"%>'/>
							<bean:write name="solverGroupEditForm" property='<%="departmentNames["+ctr+"]"%>'/>
					</TD></TR>
				</logic:equal>
			</logic:iterate>
		</logic:equal>
		
		<logic:equal name="solverGroupEditForm" property="departmentsEditable" value="true">
			<logic:notEqual name="solverGroupEditForm" property="op" value="Save">
				<TR><TD colspan='2'>&nbsp;</TD></TR>
				<TR><TD colspan='2'><tt:section-header title="Assigned Departments"/></TD></TR>
				<logic:iterate name="solverGroupEditForm" property="departmentIds" id="departmentId" indexId="ctr">
					<logic:equal name="solverGroupEditForm" property='<%="assignedDepartments["+ctr+"]"%>' value="true">
						<TR><TD colspan='2'>&nbsp;&nbsp;&nbsp;&nbsp;
							<html:hidden property='<%="departmentIds["+ctr+"]"%>'/>
							<html:hidden property='<%="departmentNames["+ctr+"]"%>'/>
							<html:checkbox property='<%="assignedDepartments["+ctr+"]"%>'/>
							<bean:write name="solverGroupEditForm" property='<%="departmentNames["+ctr+"]"%>'/>
						</TD></TR>
					</logic:equal>
				</logic:iterate>
			</logic:notEqual>
		</logic:equal>

		<logic:notEqual name="solverGroupEditForm" property="op" value="Save">
			<TR><TD colspan='2'>&nbsp;</TD></TR>
			<TR><TD colspan='2'><tt:section-header title="Assigned Managers"/></TD></TR>
			<logic:iterate name="solverGroupEditForm" property="managerIds" id="managerId" indexId="ctr">
				<logic:equal name="solverGroupEditForm" property='<%="assignedManagers["+ctr+"]"%>' value="true">
					<TR><TD colspan='2'>&nbsp;&nbsp;&nbsp;&nbsp;
						<html:hidden property='<%="managerIds["+ctr+"]"%>'/>
						<html:hidden property='<%="managerNames["+ctr+"]"%>'/>
						<html:checkbox property='<%="assignedManagers["+ctr+"]"%>'/>
						<bean:write name="solverGroupEditForm" property='<%="managerNames["+ctr+"]"%>' filter="false"/>
					</TD></TR>
				</logic:equal>
			</logic:iterate>
		</logic:notEqual>

		<logic:equal name="solverGroupEditForm" property="departmentsEditable" value="true">
			<TR><TD colspan='2'>&nbsp;</TD></TR>
			<TR><TD colspan='2'><tt:section-header title="Not Assigned Departments"/></TD></TR>
			<logic:iterate name="solverGroupEditForm" property="departmentIds" id="departmentId" indexId="ctr">
				<logic:equal name="solverGroupEditForm" property='<%="assignedDepartments["+ctr+"]"%>' value="false">
					<TR><TD colspan='2'>&nbsp;&nbsp;&nbsp;&nbsp;
						<html:hidden property='<%="departmentIds["+ctr+"]"%>'/>
						<html:hidden property='<%="departmentNames["+ctr+"]"%>'/>
						<html:checkbox property='<%="assignedDepartments["+ctr+"]"%>'/>
						<bean:write name="solverGroupEditForm" property='<%="departmentNames["+ctr+"]"%>'/>
					</TD></TR>
				</logic:equal>
			</logic:iterate>
		</logic:equal>
		
		<TR><TD colspan='2'>&nbsp;</TD></TR>
		<TR><TD colspan='2'><tt:section-header title="Not Assigned Managers"/></TD></TR>
		<logic:iterate name="solverGroupEditForm" property="managerIds" id="managerId" indexId="ctr">
			<logic:equal name="solverGroupEditForm" property='<%="assignedManagers["+ctr+"]"%>' value="false">
				<TR><TD colspan='2'>&nbsp;&nbsp;&nbsp;&nbsp;
					<html:hidden property='<%="managerIds["+ctr+"]"%>'/>
					<html:hidden property='<%="managerNames["+ctr+"]"%>'/>
					<html:checkbox property='<%="assignedManagers["+ctr+"]"%>'/>
					<bean:write name="solverGroupEditForm" property='<%="managerNames["+ctr+"]"%>' filter="false"/>
				</TD></TR>
			</logic:equal>
		</logic:iterate>

		<TR><TD colspan='2'><tt:section-header/></TD></TR>
		<TR>
			<TD align="right" colspan="2">
				<logic:equal name="solverGroupEditForm" property="op" value="Save">
					<html:submit property="op" value="Save" accesskey="S" title="Save Solver Group (Alt+S)"/>
				</logic:equal>
				<logic:notEqual name="solverGroupEditForm" property="op" value="Save">
					<html:submit property="op" value="Update" accesskey="U" title="Update Solver Group (Alt+U)"/>
					<logic:equal name="solverGroupEditForm" property="departmentsEditable" value="true">
						<html:submit property="op" value="Delete" onclick="return confirmDelete();" accesskey="D" title="Delete Solver Group (Alt+D)"/>
					</logic:equal> 
				</logic:notEqual>
				<html:submit property="op" value="Back" title="Return to Solver Groups (Alt+B)" accesskey="B"/>
			</TD>
		</TR>
	</TABLE>
</logic:notEqual>
<logic:equal name="solverGroupEditForm" property="op" value="List">
	<TABLE width="100%" border="0" cellspacing="0" cellpadding="3">
		<TR>
			<TD align="right" colspan="5">
				<tt:section-header>
					<tt:section-title>
						Solver Groups - <%= sessionContext.getUser().getCurrentAuthority().getQualifiers("Session").get(0).getQualifierLabel() %>
					</tt:section-title>
				<html:submit property="op" value="Add Solver Group" title="Create a new solver group (Alt+A)." accesskey="A"/> 
				<html:submit property="op" onclick="return confirmDeleteAll();" value="Delete All" title="Delete all solver groups that have no solutions saved."/> 
				<html:submit property="op" onclick="return confirmAutoSetup();" value="Auto Setup" title="Automatically setup solver groups."/> 
				<html:submit property="op" value="Export PDF" title="Export PDF (Alt+P)" accesskey="P"/> 
				</tt:section-header>
			</TD>
		</TR>
		<%= request.getAttribute("SolverGroups.table") %> 
		<TR>
			<TD align="right" class="WelcomeRowHead" colspan="5">&nbsp;</TD>
		</TR>
		<TR>
			<TD align="right" colspan="5">
				<html:submit property="op" value="Add Solver Group" title="Create a new solver group (Alt+A)." accesskey="A"/> 
				<html:submit property="op" onclick="return confirmDeleteAll();" value="Delete All" title="Delete all solver groups that have no solutions saved."/> 
				<html:submit property="op" onclick="return confirmAutoSetup();" value="Auto Setup" title="Automatically setup solver groups."/> 
				<html:submit property="op" value="Export PDF" title="Export PDF (Alt+P)" accesskey="P"/> 
			</TD>
		</TR>
	</TABLE>
	<% if (request.getAttribute("hash") != null) { %>
		<SCRIPT type="text/javascript" language="javascript">
			location.hash = '<%=request.getAttribute("hash")%>';
		</SCRIPT>
	<% } %>
</logic:equal>

</html:form>
