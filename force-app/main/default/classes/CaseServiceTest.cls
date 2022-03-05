@isTest
private class CaseServiceTest {

    @isTest static void getOpenCaseCountPositiveTest1() {

        // Create and insert a test user with a random, unique username.
        String username =
            'TestUser' +
            DateTime.now().getTime() +
            Integer.valueof((Math.random() * 10000)) +
            '@example.com';
        String firstName = 'Inaya';
        String lastName = 'Hough';
        Profile p = [
            SELECT Id
            FROM Profile
            WHERE Name = 'Standard User'
            LIMIT 1];
        User testUser = new User (
            Alias = 'tstusr',
            Email = username,
            EmailEncodingKey = 'UTF-8',
            FirstName = firstName,
            LanguageLocaleKey = 'en_US',
            LastName = lastName,
            LocaleSidKey = 'en_GB',
            ProfileId = p.Id,
            TimeZoneSidKey = 'Europe/London',
            UserName = username);
        insert testUser;

        // Create and insert a test account owned by the test user.
        Account testAccount = new Account(Name = 'TestAccount', OwnerId = testUser.Id);
        insert testAccount;

        // Query for a valid open and closed case status to use when creating the test cases. We're assuming
        // that the org's support process includes at least one of each, which is the expected situation.
        String openStatus = [
            SELECT MasterLabel
            FROM CaseStatus
            WHERE IsClosed = false
            LIMIT 1].MasterLabel;
        String closedStatus = [
            SELECT MasterLabel
            FROM CaseStatus
            WHERE IsClosed = true
            LIMIT 1].MasterLabel;

        // Query for a valid case origin picklist value to use when creating the test cases.
        Schema.SObjectType caseToken = Schema.getGlobalDescribe().get('Case');
        Schema.DescribeSObjectResult caseDescribe = caseToken.getDescribe();
        Map<String, Schema.SObjectField> caseFields = caseDescribe.fields.getMap();
        Schema.DescribeFieldResult originDescribe = caseFields.get('Origin').getDescribe();
        List<Schema.PicklistEntry> originPicklistEntries = originDescribe.getPicklistValues();
        String caseOrigin = originPicklistEntries[0].getValue();

        // The number of open and closed test cases to create and relate to the test account.
        Integer numOpenCases = 6;
        Integer numClosedCases = 10;

        // Create and insert some open and closed test cases. Relate the cases to the test account and
        // make the test user the owner.
        List<Case> testCases = new List<Case>();
        for (Integer i = 0; i < numOpenCases; i++) {
            testCases.add(new Case(AccountId = testAccount.Id, OwnerId = testUser.Id, Status = openStatus, Origin = caseOrigin));
        }
        for (Integer i = 0; i < numClosedCases; i++) {
            testCases.add(new Case(AccountId = testAccount.Id, OwnerId = testUser.Id, Status = closedStatus, Origin = caseOrigin));
        }
        insert testCases;
                
        // Run as the test user, and get the number of open cases related to the test account.
        Integer openCaseCount;
        System.runAs(testUser) {
            Test.startTest();
            openCaseCount = CaseService.getOpenCaseCount(testAccount.Id);
            Test.stopTest();
        }
        
        // Verify that the number of open cases related to the test account is as expected.
        System.assertEquals(numOpenCases, openCaseCount);
    }
}