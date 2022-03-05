import { createElement } from 'lwc';
import CaseInfo from 'c/caseInfo';
import getOpenCaseCount from '@salesforce/apex/CaseService.getOpenCaseCount';

// Test data simulating an open case count.
const mockGetOpenCaseCount = require('./data/getOpenCaseCount.json');

describe('c-case-info', () => {
    // Clear the DOM and any saved mock data between tests.
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        jest.clearAllMocks();
    });
    
    it('Displays the correct open case count', () => {
        const element = createElement('c-case-info', {
            is: CaseInfo
        });
        document.body.appendChild(element);
            
        // Emit the test data using the Apex wire adapter.
        getOpenCaseCount.emit(mockGetOpenCaseCount);
            
        return Promise.resolve().then(() => {
            // Validate that the correct open case count is displayed.
            const openCaseCountReceived = element.shadowRoot.querySelector("p").textContent;
            const openCaseCountExpected = mockGetOpenCaseCount;
            expect(openCaseCountReceived).toBe("Number of Open Cases: " + openCaseCountExpected);
        });
    });
});