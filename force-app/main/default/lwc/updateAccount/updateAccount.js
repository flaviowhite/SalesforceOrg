import { LightningElement, wire, api, track } from 'lwc';
import { CloseActionScreenEvent } from "lightning/actions";
import { getRecord } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import accountUpdate from '@salesforce/apex/AccountController.accountUpdate';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';

export default class updateAccount extends LightningElement {
    picklistOptions = [];
    @api recordId;
    @track showSuccessMessage = false;
    @track showErrorMessage = false;

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
    const accountData = {
        accountId : this.recordId,
        name : this.template.querySelector('[data-id="name"]').value,
        accountNumber : this.template.querySelector('[data-id="accountNumber"]').value,
        accountType : this.template.querySelector('[data-id="accountType"]').value
    };
    const jsonString = JSON.stringify(accountData);
    
    accountUpdate({jsonString})
        .then(result => {
            this.showSuccessMessage = true;
            this.successMessage = result;
            setTimeout(() => {
                this.closeModal();
            }, 3000);
        }) 
        .catch(error => {
            this.showErrorMessage = true;
            this.errorMessage = 'Não foi possivel alterar os dados da conta';
            setTimeout(() => {
                this.closeModal();
            }, 3000);
        });
    }

    get successMessageClass() {
        return this.showSuccessMessage ? 'success-message' : 'hidden';
    }

    get errorMessageClass() {
        return this.showErrorMessage ? 'error-message' : 'hidden';
    }


    closeModal() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }
}
