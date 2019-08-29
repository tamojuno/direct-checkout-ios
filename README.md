
# DirectCheckout iOS

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

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

    DirectCheckout.initialize(publicToken: "AF2261A2ECC7FD90D205502092571F5C1C0831935E35073AA95AEBEB68D7E5C5")
    
    return true
}
```

Opcionalmente também é possível escolher o ambiente de testes (Sandbox):

```swift
DirectCheckout.initialize(publicToken: "AF2261A2ECC7FD90D205502092571F5C1C0831935E35073AA95AEBEB68D7E5C5", environment: .sandbox)
```

## Utilização

Detalhamos a seguir um exemplo de utilização de nossa biblioteca de como obter o hash do cartão de crédito:

```swift
let card = Card(cardNumber: "5448280000000007",
                holderName: "Antônio",
                securityCode: "123",
                expirationMonth: "01",
                expirationYear: "2020")
                
DirectCheckout.getCardHash(card) { result in
    do {
        let hash = try result.get()
        /* Sucesso - A variável hash conterá o hash do cartão de crédito */
        
    } catch let error {
        /* Erro - A variável error conterá o erro ocorrido ao obter o hash */
    }
}
```

## Funções Auxiliares

A biblioteca disponibilizada também possui uma série de métodos auxiliares para a validação de dados do cartão de crédito, conforme demonstrado a seguir:

```swift
/* isValidSecurityCode: Valida número do cartão de crédito (retorna true se for válido) */
DirectCheckout.isValidCardNumber("9999999999999999")

/* isValidSecurityCode: Valida código de segurança do cartão de crédito (retorna true se for válido) */
DirectCheckout.isValidSecurityCode("9999999999999999", "111")

/* isValidExpireDate: Valida data de expiração do cartão de crédito (retorna true se for válido) */
DirectCheckout.isValidExpireDate(month: "05", year: "2021")

/* getCardType: Obtém o tipo de cartão de crédito (bandeira) */
DirectCheckout.getCardType("9999999999999999")
```

Algumas funções também podem ser acessadas diretamente da classe Card:

```swift
let card = Card(cardNumber: "5448280000000007",
                holderName: "Antônio",
                securityCode: "123",
                expirationMonth: "01",
                expirationYear: "2020")
                
/* getType: Obtém o tipo de cartão de crédito (bandeira) */
card.getType()

/* validateNumber: Valida número do cartão de crédito (retorna true se for válido) */
card.validateNumber()

/* validateCVC: Valida código de segurança do cartão de crédito (retorna true se for válido) */
card.validateCVC()

/* validateExpireDate: Valida data de expiração do cartão de crédito (retorna true se for válido) */
card.validateExpireDate()

/* validate: Realiza todas as validações do cartão de crédito (retorna true se for válido ou lança um CardError especificando a falha) */
card.validate()

```

## Contato 

Para mais informações entre em contato com a Juno:

* https://juno.com.br/contato.html


