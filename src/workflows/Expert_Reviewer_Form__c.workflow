<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Pre_Confirmation_Email</fullName>
        <description>Pre-Confirmation Email</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Pre_Confirmation_Email_Vetting</template>
    </alerts>
    <alerts>
        <fullName>Pre_confirmed_email_alert</fullName>
        <description>Pre-confirmed email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>avasili@plan-sys.com.state</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Pre_Confirmation_Email_Vetting</template>
    </alerts>
    <fieldUpdates>
        <fullName>Copy_Email</fullName>
        <field>Email__c</field>
        <formula>Save_the_date__r.Expert_Reviewer__r.Email</formula>
        <name>Copy Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_update</fullName>
        <field>test__c</field>
        <literalValue>1</literalValue>
        <name>Field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Vetting Questions Not Submitted</fullName>
        <actions>
            <name>Pre_Confirmation_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Copy_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Expert_Reviewer_Form__c.Status__c</field>
            <operation>equals</operation>
            <value>Vetting Questions Not Submitted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Vetting Questions Submitted</fullName>
        <actions>
            <name>Pre_Confirmation_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Copy_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Expert_Reviewer_Form__c.Status__c</field>
            <operation>equals</operation>
            <value>Vetting Questions Submitted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
