import { LightningElement, wire, api } from 'lwc';
import accountUpdate from '@salesforce/apex/AccountController.accountUpdate';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getRecord } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import TYPE_FIELD from '@salesforce/schema/Account.Type';

export default class updateAccount extends LightningElement {
  picklistOptions = [];
  @api recordId;

  @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
  accountObjectInfo;

  @wire(getRecord, {
    recordId: '$accountObjectInfo.data.defaultRecordTypeId',
    fields: [TYPE_FIELD]
  })
  wiredRecord;

  @wire(getPicklistValues, {
    recordTypeId: '$accountObjectInfo.data.defaultRecordTypeId',
    fieldApiName: TYPE_FIELD
  })
  wiredPicklistValues({ data, error }) {
    if (data) {
      this.picklistOptions = data.values;
    } else if (error) {
      console.error(error);
    }
  }

  dataSave() {
    console.log("passei aqui ");
    const accountData = {
        accountId : this.recordId,
        name : this.template.querySelector('[data-id="name"]').value,
        accountNumber : this.template.querySelector('[data-id="accountNumber"]').value,
        accountType : this.template.querySelector('[data-id="accountType"]').value
    };
    const jsonString = JSON.stringify(accountData);
    accountUpdate({jsonString}).then();
    console.log('Teste ' + jsonString);

  }
}
