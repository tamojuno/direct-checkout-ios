Pod::Spec.new do |spec|

  spec.name         = "DirectCheckout"
  spec.version      = "1.0.0"
  spec.summary      = "SDK para criptografia e validação de dados do cartão de crédito para integração com a API de pagamentos da Juno/BoletoBancário."
  spec.homepage     = "http://www.juno.com.br"
  spec.author             = { "Diego Trevisan Lara" => "diego@juno.com.br" }

  spec.ios.deployment_target = "11.0"
  spec.source       = { :git => "https://github.com/tamojuno/direct-checkout-ios.git", :tag => "#{spec.version}" }
  spec.source_files  = "DirectCheckout", "DirectCheckout/**/*.{h,m,swift}"
  spec.public_header_files = "DirectCheckout/**/*.h"
  spec.swift_version = "5.0"
  # spec.exclude_files = "DirectCheckout/Exclude"

end
