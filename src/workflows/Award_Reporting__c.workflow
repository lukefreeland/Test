<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Alert_FFR</fullName>
        <description>Email Alert-FFR</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Test_Award_Reporting</template>
    </alerts>
    <alerts>
        <fullName>Email_to_notify_Authorized_Representative_Project_Director_and_Financial_POC</fullName>
        <description>Email to notify Authorized Representative,Project Director and Financial POC</description>
        <protected>false</protected>
        <recipients>
            <recipient>Administrator</recipient>
            <type>role</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/Email_template_for_FFR_notification</template>
    </alerts>
    <alerts>
        <fullName>Email_to_notify_Authorized_Representative_Project_Director_and_Financial_POC1</fullName>
        <description>Email to notify Authorized Representative,Project Director and Financial POC1</description>
        <protected>false</protected>
        <recipients>
            <recipient>pmungamuri@plan-sys.com.state</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_template_for_FFR_notification1</template>
    </alerts>
    <alerts>
        <fullName>Email_to_notify_Authorized_Representative_Project_Director_and_Financial_POC2</fullName>
        <description>Email to notify Authorized Representative,Project Director and Financial POC2</description>
        <protected>false</protected>
        <recipients>
            <recipient>pmungamuri@plan-sys.com.state</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_template_for_FFR_notification1</template>
    </alerts>
    <alerts>
        <fullName>Email_to_notify_Authorized_Representative_Project_Director_and_Financial_POC3</fullName>
        <description>Email to notify Authorized Representative,Project Director and Financial POC3</description>
        <protected>false</protected>
        <recipients>
            <recipient>pmungamuri@plan-sys.com.state</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_template_for_FFR_notification2</template>
    </alerts>
    <alerts>
        <fullName>FFR_Due_Date_Alert</fullName>
        <description>FFR Due Date Alert</description>
        <protected>false</protected>
        <recipients>
            <field>GO_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Award_Awaiting_GO_Certification</template>
    </alerts>
    <alerts>
        <fullName>FFR_Notifications</fullName>
        <description>FFR Notifications</description>
        <protected>false</protected>
        <recipients>
            <field>GO_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Due_Date_Notification</template>
    </alerts>
    <alerts>
        <fullName>FFR_Notifications2</fullName>
        <description>FFR Notifications2</description>
        <protected>false</protected>
        <recipients>
            <field>GO_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>kyama@plan-sys.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Due_Date_Notification1</template>
    </alerts>
    <alerts>
        <fullName>FFR_Notifications3</fullName>
        <description>FFR Notifications3</description>
        <protected>false</protected>
        <recipients>
            <field>GO_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Due_Date_Notification2</template>
    </alerts>
    <alerts>
        <fullName>FFR_Notifications4</fullName>
        <description>FFR Notifications4</description>
        <protected>false</protected>
        <recipients>
            <recipient>pmungamuri@plan-sys.com.state</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_template_for_FFR_notification</template>
    </alerts>
    <alerts>
        <fullName>FFR_Notifications_5</fullName>
        <description>FFR Notifications 5</description>
        <protected>false</protected>
        <recipients>
            <recipient>pmungamuri@plan-sys.com.state</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_template_for_FFR_notification1</template>
    </alerts>
    <alerts>
        <fullName>FFR_Notifications_6</fullName>
        <description>FFR Notifications 6</description>
        <protected>false</protected>
        <recipients>
            <recipient>pmungamuri@plan-sys.com.state</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_template_for_FFR_notification2</template>
    </alerts>
    <alerts>
        <fullName>Notification_sent_to_grantee_after_report_is_submitted</fullName>
        <description>Notification sent to grantee after report is submitted</description>
        <protected>false</protected>
        <recipients>
            <field>GranteeAuthorizedRepresentativeEmail__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_Template_if_FFR_status_is_submitted</template>
    </alerts>
    <alerts>
        <fullName>Report_to_CNCS</fullName>
        <description>Report to CNCS</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <recipients>
            <field>Authorized_Representative__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Program_Director__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Report_Template</template>
    </alerts>
    <alerts>
        <fullName>Send_an_email_for_PO_when_the_Award_is_Submitted</fullName>
        <description>Send an email for PO when the Award is  Submitted</description>
        <protected>false</protected>
        <recipients>
            <field>PO_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Award_Submit</template>
    </alerts>
    <fieldUpdates>
        <fullName>AR</fullName>
        <field>Authorized_Representative__c</field>
        <formula>Award__r.Application_ID__r.Authorized_Representative__r.Email</formula>
        <name>AR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Report_Submitted</fullName>
        <field>Date_report_submitted__c</field>
        <formula>IF(ISPICKVAL(Status__c,&apos;Submitted&apos;),TODAY(),NULL)</formula>
        <name>Date Report Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FFR_Layout_Draft_status</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Federal_Financial_Reports</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>FFR Layout Draft status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FFR_Layout_for_Grantee</fullName>
        <field>RecordTypeId</field>
        <lookupValue>FFR_Submitted_Status</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>FFR Layout for Grantee</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PD</fullName>
        <field>Program_Director__c</field>
        <formula>Award__r.Application_ID__r.Project_Director__r.Email__c</formula>
        <name>PD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Resubmission_Date</fullName>
        <field>Resubmission_Date_Received__c</field>
        <formula>IF(ISPICKVAL(Status__c,&apos;Re-submitted&apos;),TODAY(),NULL)</formula>
        <name>Resubmission Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Return_for_rework_field_update</fullName>
        <description>When the Status = Return for Rework update the Resubmission Due Date to TODAY + 5 days</description>
        <field>Resubmission_Due_Date__c</field>
        <formula>TODAY() + 5</formula>
        <name>Return for rework field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submitted_by</fullName>
        <description>Submitted By</description>
        <field>Submitted_By__c</field>
        <formula>LastModifiedBy.LastName + &quot; &quot; + LastModifiedBy.FirstName</formula>
        <name>Submitted by</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateField</fullName>
        <description>updates the previous field with this period</description>
        <field>Federal_Share_of_expenditures__c</field>
        <formula>PRIORVALUE(Fed_Share_of_expenditures_This_Period__c )</formula>
        <name>UpdateField</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateGranteeEmail</fullName>
        <field>GranteeAuthorizedRepresentativeEmail__c</field>
        <formula>Award__r.Application_ID__r.Authorized_Representative__r.Emails__c</formula>
        <name>UpdateGranteeEmail</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdatePOEmail</fullName>
        <field>PO_Email__c</field>
        <formula>Award__r.POs__r.Email</formula>
        <name>UpdatePOEmail</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Award Submit Email for PO</fullName>
        <actions>
            <name>Send_an_email_for_PO_when_the_Award_is_Submitted</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>UpdatePOEmail</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Award_Reporting__c.Status__c</field>
            <operation>equals</operation>
            <value>Submitted,Re-submitted</value>
        </criteriaItems>
        <description>Send an email for PO when the Award is Submitted to PO.
As per #2695</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Closeout Report not Submitted</fullName>
        <actions>
            <name>Report_to_CNCS</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2 AND (3 OR 4 OR 5)</booleanFilter>
        <criteriaItems>
            <field>Award_Reporting__c.Submission_Due_Date__c</field>
            <operation>lessThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Award_Reporting__c.Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <criteriaItems>
            <field>Award_Reporting__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Equipment Inventory</value>
        </criteriaItems>
        <criteriaItems>
            <field>Award_Reporting__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Equipment Inventory,Inventory of Unused or Residual Supplies</value>
        </criteriaItems>
        <criteriaItems>
            <field>Award_Reporting__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Subgrantee Certification</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Due Date Notification</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Award_Reporting__c.Name</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>FFR_Notifications_5</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Award_Reporting__c.Due_Date__c</offsetFromField>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>FFR_Notifications_6</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Award_Reporting__c.Due_Date__c</offsetFromField>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <offsetFromField>Award_Reporting__c.Due_Date__c</offsetFromField>
            <timeLength>45</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>FFR_Notifications4</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Award_Reporting__c.Due_Date__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Email Notifications regarding FFR%27s</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Award_Reporting__c.Name</field>
            <operation>equals</operation>
            <value>NULL</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>FFR_Notifications2</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Award_Reporting__c.Due_Date__c</offsetFromField>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>FFR_Notifications3</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Award_Reporting__c.Due_Date__c</offsetFromField>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>FFR_Notifications</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Award_Reporting__c.Due_Date__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>FFR Draft Status Record Type</fullName>
        <actions>
            <name>FFR_Layout_Draft_status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2 ) AND (3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>Award_Reporting__c.Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <criteriaItems>
            <field>Award_Reporting__c.Status__c</field>
            <operation>equals</operation>
            <value>Returned for Re-work</value>
        </criteriaItems>
        <criteriaItems>
            <field>Award_Reporting__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Federal Financial Reports</value>
        </criteriaItems>
        <criteriaItems>
            <field>Award_Reporting__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>FFR Submitted Status</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>FFR Due Date Notification</fullName>
        <active>true</active>
        <description># As per #892</description>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>FFR_Due_Date_Alert</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Award_Reporting__c.Due_Date__c</offsetFromField>
            <timeLength>45</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>FFR Submitted Status Record Type</fullName>
        <actions>
            <name>FFR_Layout_for_Grantee</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2 OR 3 OR 4) AND (5 OR 6)</booleanFilter>
        <criteriaItems>
            <field>Award_Reporting__c.Status__c</field>
            <operation>equals</operation>
            <value>Submitted</value>
        </criteriaItems>
        <criteriaItems>
            <field>Award_Reporting__c.Status__c</field>
            <operation>equals</operation>
            <value>Re-submitted</value>
        </criteriaItems>
        <criteriaItems>
            <field>Award_Reporting__c.Status__c</field>
            <operation>equals</operation>
            <value>Disabled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Award_Reporting__c.Status__c</field>
            <operation>equals</operation>
            <value>Reviewed and Accepted</value>
        </criteriaItems>
        <criteriaItems>
            <field>Award_Reporting__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Federal Financial Reports</value>
        </criteriaItems>
        <criteriaItems>
            <field>Award_Reporting__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>FFR Submitted Status</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification to Authorized Rep</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Award_Reporting__c.Name</field>
            <operation>equals</operation>
            <value>NULL</value>
        </criteriaItems>
        <description>Send FFR Notifications to Authorized Rep, Project Director, Financial POC</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_to_notify_Authorized_Representative_Project_Director_and_Financial_POC3</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Award_Reporting__c.Due_Date__c</offsetFromField>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Email_to_notify_Authorized_Representative_Project_Director_and_Financial_POC</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Award_Reporting__c.Due_Date__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Email_to_notify_Authorized_Representative_Project_Director_and_Financial_POC2</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Award_Reporting__c.Due_Date__c</offsetFromField>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Notification to be sent if FFR is submitted</fullName>
        <actions>
            <name>Notification_sent_to_grantee_after_report_is_submitted</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>UpdateGranteeEmail</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Award_Reporting__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Federal Financial Reports</value>
        </criteriaItems>
        <criteriaItems>
            <field>Award_Reporting__c.Status__c</field>
            <operation>equals</operation>
            <value>Submitted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Progress Report Type Value Based on Record Type</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Award_Reporting__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Progress Reports</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Re submission Due Date</fullName>
        <actions>
            <name>Review_Award_Reporting_Resubmission</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Award_Reporting__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Federal Financial Reports</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Resubmission Date Received</fullName>
        <actions>
            <name>Resubmission_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Award_Reporting__c.Status__c</field>
            <operation>equals</operation>
            <value>Re-submitted</value>
        </criteriaItems>
        <description>Resubmission Date Received</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Return for rework field update</fullName>
        <actions>
            <name>Return_for_rework_field_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Award_Reporting__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Federal Financial Reports</value>
        </criteriaItems>
        <criteriaItems>
            <field>Award_Reporting__c.Status__c</field>
            <operation>equals</operation>
            <value>Returned for Re-work</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Submitted by</fullName>
        <actions>
            <name>Email_Alert_FFR</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Date_Report_Submitted</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Submitted_by</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Award_Reporting__c.Status__c</field>
            <operation>equals</operation>
            <value>Submitted</value>
        </criteriaItems>
        <description>Submitted By</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>nn</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Award_Reporting__c.of_add_l_activities_completed_Disaste__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <tasks>
        <fullName>Review_Award_Reporting_Resubmission</fullName>
        <assignedTo>avasili@plan-sys.com.state</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>5</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Award_Reporting__c.Resubmission_Date_Received__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Award Reporting Resubmission</subject>
    </tasks>
</Workflow>
