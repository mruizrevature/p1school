@isTest
public with sharing class TopicCreator {
    public static void createTopic() {
        Topic__c newTopic = new Topic__c();
        newTopic.Name = 'MockExistingTopic';
        insert newTopic;
    }
}
