import { LightningElement, api, wire } from 'lwc';

import getOpenCaseCount from '@salesforce/apex/CaseService.getOpenCaseCount';

export default class WireApexProperty extends LightningElement {
    @api recordId;
    @wire(getOpenCaseCount, { accountId: '$recordId' })
    openCaseCount;
}