<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>RecordType_Editable</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Standard</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>RecordType Editable</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RecordType_Readonly</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Read_Only</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>RecordType Readonly</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_State_CLR_Code</fullName>
        <field>State_CLR_Code__c</field>
        <formula>IF( ISPICKVAL( State__c , &quot;CA&quot;),&quot;P&quot;, 
IF( ISPICKVAL( State__c , &quot;WA&quot;),&quot;P&quot;, 
IF( ISPICKVAL( State__c , &quot;AK&quot;),&quot;P&quot;, 
IF( ISPICKVAL( State__c , &quot;HI&quot;),&quot;P&quot;, 
IF( ISPICKVAL( State__c , &quot;ID&quot;),&quot;P&quot;, 
IF( ISPICKVAL( State__c , &quot;MT&quot;),&quot;P&quot;, 
IF( ISPICKVAL( State__c , &quot;NV&quot;),&quot;P&quot;, 
IF( ISPICKVAL( State__c , &quot;OR&quot;),&quot;P&quot;, 
IF( ISPICKVAL( State__c, &quot;UT&quot;),&quot;P&quot;, 
IF( ISPICKVAL( State__c , &quot;WY&quot;),&quot;P&quot;, 
IF( ISPICKVAL( State__c , &quot;GU&quot;) , &quot;P&quot;, 
IF( ISPICKVAL( State__c, &quot;AS&quot;) , &quot;P&quot;, 
IF( ISPICKVAL( State__c , &quot;MP&quot;) , &quot;P&quot;, 
IF( ISPICKVAL( State__c , &quot;PA&quot;) , &quot;A&quot;, 
IF( ISPICKVAL( State__c , &quot;NJ&quot;) , &quot;A&quot;, 
IF( ISPICKVAL( State__c , &quot;ME&quot;) , &quot;A&quot;, 
IF( ISPICKVAL( State__c , &quot;NH&quot;) , &quot;A&quot;, 
IF( ISPICKVAL( State__c , &quot;RI&quot;) , &quot;A&quot;, 
IF( ISPICKVAL( State__c , &quot;CT&quot;) , &quot;A&quot;, 
IF( ISPICKVAL( State__c , &quot;VT&quot;) , &quot;A&quot;, 
IF( ISPICKVAL( State__c , &quot;MA&quot;) , &quot;A&quot;, 
IF( ISPICKVAL( State__c , &quot;DE&quot;) , &quot;A&quot;, 
IF( ISPICKVAL( State__c , &quot;MD&quot;),&quot;A&quot;, 
IF( ISPICKVAL( State__c , &quot;PR&quot;) , &quot;A&quot;, 
IF( ISPICKVAL( State__c , &quot;DC&quot;) , &quot;A&quot;, 
IF( ISPICKVAL( State__c , &quot;IL&quot;) , &quot;N&quot;, 
IF( ISPICKVAL( State__c , &quot;OH&quot;) , &quot;N&quot;, 
IF( ISPICKVAL( State__c, &quot;WI&quot;) , &quot;N&quot;, 
IF( ISPICKVAL( State__c , &quot;IN&quot;) , &quot;N&quot;, 
IF( ISPICKVAL( State__c , &quot;IA&quot;) , &quot;N&quot;, 
IF( ISPICKVAL( State__c , &quot;MI&quot;) , &quot;N&quot;, 
IF( ISPICKVAL( State__c , &quot;MN&quot;) , &quot;N&quot;, 
IF( ISPICKVAL( State__c , &quot;NE&quot;) , &quot;N&quot;, 
IF( ISPICKVAL( State__c , &quot;SD&quot;) , &quot;N&quot;, 
IF( ISPICKVAL( State__c , &quot;ND&quot;) , &quot;N&quot;, 
IF( ISPICKVAL( State__c , &quot;FL&quot;) , &quot;S&quot;, 
IF( ISPICKVAL( State__c , &quot;GA&quot;) , &quot;S&quot;, 
IF( ISPICKVAL( State__c , &quot;AL&quot;) , &quot;S&quot;, 
IF( ISPICKVAL( State__c , &quot;MS&quot;) , &quot;S&quot;, 
IF( ISPICKVAL( State__c , &quot;TN&quot;) , &quot;S&quot;, 
IF( ISPICKVAL( State__c , &quot;SC&quot;) , &quot;S&quot;, 
IF( ISPICKVAL( State__c , &quot;KY&quot;) , &quot;S&quot;, 
IF( ISPICKVAL( State__c , &quot;WV&quot;) , &quot;S&quot;, 
IF( ISPICKVAL( State__c , &quot;VA&quot;) , &quot;S&quot;, 
IF( ISPICKVAL( State__c, &quot;NC&quot;) , &quot;S&quot;, 
&quot;W&quot;)))))))))))))))))))))))))))))))))))))))))))))</formula>
        <name>Update State CLR Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>change_project_record_type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Read_Only</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>change project record type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>popProjId</fullName>
        <field>Legacy_Project_ID__c</field>
        <formula>VALUE( projSequence__c )</formula>
        <name>popProjId</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Project Closed and Read Only</fullName>
        <actions>
            <name>RecordType_Readonly</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Project__c.Status__c</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Project Opened and Editable</fullName>
        <actions>
            <name>RecordType_Editable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Project__c.Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>State CLR Code</fullName>
        <actions>
            <name>Update_State_CLR_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.State__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>popLegacyProjId</fullName>
        <actions>
            <name>popProjId</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Project__c.Project_Title__c</field>
            <operation>notEqual</operation>
            <value>null</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>project read only</fullName>
        <actions>
            <name>change_project_record_type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
