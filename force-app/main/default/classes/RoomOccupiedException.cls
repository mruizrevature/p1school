public with sharing class RoomOccupiedException extends Exception {
    public override string getMessage(){
        return 'Error: Room Occupation limit reached';
    }
}