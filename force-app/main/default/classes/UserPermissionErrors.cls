/**
    Contains common user errors
 */
public with sharing class UserPermissionErrors {
    public static final String CANNOT_READ_ASSESSMENTS = 'You do not have access to see Assessment records. Please contact System Administrator for more details.';
    public static final String CANNOT_CREATE_ASSESSMENTS = 'You do not have permission to create Assessments. Please contact System Administrator if this is unexpected.';
    public static final String CANNOT_READ_CLASSES = 'You do not have access to see Class records. Please contact System Administrator for more details.';
}