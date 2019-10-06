@isTest
public with sharing class RoomCreator {
    public static void createRoom() {
        Room__c newRoom = new Room__c();
        insert newRoom;
    }
}
