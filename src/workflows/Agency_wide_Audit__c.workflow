<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notification_60days_before_the_Due_Date_for_Notice_of_Final_Action</fullName>
        <description>Notification 60days before the Due Date for Notice of Final Action</description>
        <protected>false</protected>
        <recipients>
            <recipient>avasili@plan-sys.com.state</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notification_60days_before_the_Due_Date_for_Notice_of_Final_Action</template>
    </alerts>
    <alerts>
        <fullName>Notification_when_current_date_is_15_days_less_than_Due_Date_for_Management_Deci</fullName>
        <description>Notification when current date is 15 days less than Due Date for Management Decision.</description>
        <protected>false</protected>
        <recipients>
            <recipient>avasili@plan-sys.com.state</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notification_when_current_date_is_15_days_less_than_the_date_entered_in_the_Due</template>
    </alerts>
    <alerts>
        <fullName>Notification_when_current_date_is_15_days_less_than_the_date_entered_in_the_Due</fullName>
        <description>Notification when current date is 15 days less than the date entered in the Due</description>
        <protected>false</protected>
        <recipients>
            <recipient>avasili@plan-sys.com.state</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notification_when_current_date_is_15_days_less_than_the_date_entered_in_the_Due</template>
    </alerts>
    <alerts>
        <fullName>Notification_when_current_date_is_30_days_less_than_Due_Date_for_Management_Deci</fullName>
        <description>Notification when current date is 30 days less than Due Date for Management Decision.</description>
        <protected>false</protected>
        <recipients>
            <recipient>avasili@plan-sys.com.state</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notification_30days_before_the_Due_Date_for_Management_Decision</template>
    </alerts>
    <fieldUpdates>
        <fullName>Date_OIG_should_respond_to_PMD</fullName>
        <field>Date_OIG_should_respond_to_PMD__c</field>
        <formula>Date_of_Proposed_Management_Decision__c + 30</formula>
        <name>Date OIG should respond to PMD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_OIG_should_respond_to_PMD_update</fullName>
        <description>Update Date OIG should respond to PMD field with Date of Proposed Management Decision + 30days</description>
        <field>Date_OIG_responded_to_PMD__c</field>
        <formula>Date_of_Proposed_Management_Decision__c + 30</formula>
        <name>Date OIG should respond to PMD  update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Due_Date_Management_Decision_update</fullName>
        <description>Due Date for Management Decision should be updated with Date Final Report Issued + 180days</description>
        <field>Due_Date_for_Management_Decision__c</field>
        <formula>Date_Final_Report_Issued__c + 180</formula>
        <name>Due Date Management Decision update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Email</fullName>
        <field>Assigned_Audit_Resolution_Manager_Email__c</field>
        <formula>Assigned_Audit_Resolution_Manager__r.Email</formula>
        <name>Update Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Date OIG should respond to PMD</fullName>
        <actions>
            <name>Date_OIG_should_respond_to_PMD</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Due_Date_Management_Decision_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Agency_wide_Audit__c.Proposed_Management_Decision_sent_to_OIG__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Date OIG should respond to PMD – dependent on “Proposed Management Decision sent to OIG” value of “TRUE,” optional, date field, formula, should populate “Date of Proposed Management Decision” plus 30 days.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification when current date is less than the date entered in the Due Date for Management Decision</fullName>
        <actions>
            <name>Update_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Agency_wide_Audit__c.Name</field>
            <operation>notEqual</operation>
            <value>null</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Notification_when_current_date_is_30_days_less_than_Due_Date_for_Management_Deci</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Agency_wide_Audit__c.Due_Date_for_Management_Decision__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Notification_when_current_date_is_15_days_less_than_the_date_entered_in_the_Due</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Agency_wide_Audit__c.Due_Date_for_Management_Decision__c</offsetFromField>
            <timeLength>-15</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Notification_60days_before_the_Due_Date_for_Notice_of_Final_Action</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Agency_wide_Audit__c.Due_Date_for_Notice_of_Final_Action__c</offsetFromField>
            <timeLength>-60</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
