import { LightningElement, wire } from 'lwc';
import consultaJSON from '@salesforce/apex/ConsultaCNPJController.consultaJSON';
const DELAY = 350;
export default class ConsultaCNPJ extends LightningElement {
    // @wire( consultaJSON , {cnpj: '$currCNPJ'} ) jsonCNPJ;
    
    cnpj = '';

    @wire(consultaJSON, { cnpj: '$cnpj' })
    jsonCNPJ;

    handleKeyChange(event) {
        if ((event.target.value.length == 14) && (event.target.value != this.cnpj)) {
            window.clearTimeout(this.delayTimeout);
            const cnpj = event.target.value;
            this.delayTimeout = setTimeout(() => {
                this.cnpj = cnpj;
            }, DELAY);
        }
    } 
}