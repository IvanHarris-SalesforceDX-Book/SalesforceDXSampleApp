public with sharing class CaseService {
    @AuraEnabled(cacheable=true)
    public static Integer getOpenCaseCount(Id accountId) {
        // Return the number of open cases related to the account.
        return [
            SELECT COUNT()
            FROM Case
            WHERE AccountId = :accountId AND IsClosed = false
            WITH SECURITY_ENFORCED
       ];
    }
}