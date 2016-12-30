<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Confirmation_Message_sent_to_the_peer_reviewer</fullName>
        <description>Confirmation Message sent to the peer reviewer</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Eligibilty_Email</template>
    </alerts>
    <alerts>
        <fullName>Pre_Confirmation_Email</fullName>
        <ccEmails>smandra@plan-sys.com</ccEmails>
        <description>Pre-Confirmation Email</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Pre_Confirmation_Email_Vetting</template>
    </alerts>
    <alerts>
        <fullName>SaveTheDateEmailAlert</fullName>
        <description>SaveTheDateEmailAlert</description>
        <protected>false</protected>
        <recipients>
            <field>Expert_Reviewer__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Save_the_Date_notification</template>
    </alerts>
    <rules>
        <fullName>Eligibility Confirmation Email</fullName>
        <actions>
            <name>Confirmation_Message_sent_to_the_peer_reviewer</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Save_the_Date__c.Status__c</field>
            <operation>equals</operation>
            <value>Eligible</value>
        </criteriaItems>
        <description>Confirmation message sent to the peer reviewer.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Pre Confirmation Email</fullName>
        <actions>
            <name>Pre_Confirmation_Email</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Save_the_Date__c.Status__c</field>
            <operation>equals</operation>
            <value>Pre-Confirmed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Save the Date Created</fullName>
        <actions>
            <name>SaveTheDateEmailAlert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Save_the_Date__c.CreatedDate</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
