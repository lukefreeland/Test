<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Consesus_Approach_NA</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Not_Applicable</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Consesus Approach NA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Consesus_Approch</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Consensus_Bands</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Consesus Approch</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Consesus_Approch_Scores</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Consensus_Scores</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Consesus Approch - Scores</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Consesus Approach NA</fullName>
        <actions>
            <name>Consesus_Approach_NA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Paneling__c.Consensus_Approach__c</field>
            <operation>equals</operation>
            <value>Not Applicable</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Consesus Approch</fullName>
        <actions>
            <name>Consesus_Approch</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Paneling__c.Consensus_Approach__c</field>
            <operation>equals</operation>
            <value>Consensus Bands</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Consesus Approch - Scores</fullName>
        <actions>
            <name>Consesus_Approch_Scores</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Paneling__c.Consensus_Approach__c</field>
            <operation>equals</operation>
            <value>Consensus Scores</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
