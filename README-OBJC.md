# DirectCheckout iOS

![CocoaPods Compatible](https://img.shields.io/cocoapods/v/DirectCheckout.svg)
![Platforms](https://img.shields.io/badge/platforms-iOS-333333.svg)
![Languages](https://img.shields.io/badge/languages-Swift%20%7C%20ObjC-333333.svg)

>_Caso necessite, [confira a documentação para Swift](https://github.com/tamojuno/direct-checkout-ios/blob/master/README.md)._

SDK para criptografia e validação de dados de cartão de crédito para integração com a API de pagamentos da Juno/BoletoBancário.

Visando garantir a segurança das transações realizadas em nossa plataforma, a API da Juno adota uma política de criptografia dos dados de cartão de crédito de ponta-a-ponta.

Para mais informações acesse nossa página de integração:

[Integração via API](https://www.boletobancario.com/boletofacil/integration/integration.html)

## Instalação

### Cocoapods

Adicione o SDK nas dependências do seu aplicativo inserindo a seguinte linha no arquivo `Podfile`:

```
pod 'DirectCheckout'
```

Em seguida, instale as dependências pelo comando:

```bash
pod install
```

Na inicialização do aplicativo, preferencialmente na classe `AppDelegate`, faça a inicialização do SDK passando como parâmetro o seu token público, que pode ser obtido em nossa [página de integração](https://www.boletobancario.com/boletofacil/integration/integration.html):

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [DirectCheckout initializeWithPublicToken:@"AC2261A2ECC7FD90D205502092571F5C1C0831935E35073AA95AEBEB68D7E5C5"];

    return YES;
}
```

Opcionalmente também é possível escolher o ambiente de testes (Sandbox):

```objective-c
[DirectCheckout initializeWithPublicToken:@"AC2261A2ECC7FD90D205502092571F5C1C0831935E35073AA95AEBEB68D7E5C5" environment:APIEnvionmentSandbox];
```

## Utilização

Detalhamos a seguir um exemplo de utilização de nossa biblioteca de como obter o hash do cartão de crédito:

```objective-c
Card *card = [[Card alloc] initWithCardNumber:@"5448280000000007"
                                   holderName:@"Antônio"
                                 securityCode:@"123"
                              expirationMonth:@"01"
                               expirationYear:@"2020"];

[DirectCheckout getCardHash:card success:^(NSString *hash) {

   /* Sucesso - A variável hash conterá o hash do cartão de crédito */

} failure:^(NSError *error) {

   /* Erro - A variável error conterá o erro ocorrido ao obter o hash */

}];
```

## Funções Auxiliares

A biblioteca disponibilizada também possui uma série de métodos auxiliares para a validação de dados do cartão de crédito, conforme demonstrado a seguir:

```objective-c
/* isValidCardNumber: Valida número do cartão de crédito (retorna true se for válido) */
[DirectCheckout isValidCardNumber:@"9999999999999999"];

/* isValidSecurityCode: Valida código de segurança do cartão de crédito (retorna true se for válido) */
[DirectCheckout isValidSecurityCode:@"111" cardNumber:@"9999999999999999"];

/* isValidExpireDate: Valida data de expiração do cartão de crédito (retorna true se for válido) */
[DirectCheckout isValidExpireDateMonth:@"05" year:@"2021"];
```

Algumas funções também podem ser acessadas diretamente da classe Card:

```objective-c
Card *card = [[Card alloc] initWithCardNumber:@"5448280000000007"
                                   holderName:@"Antônio"
                                 securityCode:@"123"
                              expirationMonth:@"01"
                               expirationYear:@"2020"];

/* validateNumber: Valida número do cartão de crédito (retorna true se for válido) */
[card validateNumber];

/* validateCVC: Valida código de segurança do cartão de crédito (retorna true se for válido) */
[card validateCVC];

/* validateExpireDate: Valida data de expiração do cartão de crédito (retorna true se for válido) */
[card validateExpireDate];

/* validate: Realiza todas as validações do cartão de crédito (executando bloco success se for válido ou bloco failure com um erro especificando a falha) */
[card validateWithSuccess:^(Card *card) {

    /* Sucesso */

} failure:^(NSError *error) {

    /* Erro */

}];

```

## Contato

Para mais informações entre em contato com a Juno:

* https://juno.com.br/contato.html
