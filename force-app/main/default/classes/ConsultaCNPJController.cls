public with sharing class ConsultaCNPJController {
   
    @AuraEnabled(cacheable=true)
    public static String consultaJSON(String cnpj) {

        //Não esquecer de cadastrar o receitaws como site remoto
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://www.receitaws.com.br/v1/cnpj/' + cnpj);
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');
        req.setTimeout(120000);
        try {
            Http h = new Http();
            HttpResponse res = h.send(req);
            system.debug(res.getBody());
            if (res.getStatusCode() == 200) {
                PessoaJuridica dados = PessoaJuridica.parse(res.getBody());
                if (dados.status == 'ERROR') {
                    return 'erro';
                }                

                // Incluir persistência do obj PessoaJuridica (dados)

                System.debug(dados);

                return res.getBody();
            }
        } catch (Exception e) {
            system.debug('erro' + e.getMessage());
            return 'erro';

        }

        return null;
    }
}
