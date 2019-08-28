Pod::Spec.new do |spec|

  spec.name         = "DirectCheckout"
  spec.version      = "1.0.0"
  spec.summary      = "SDK para criptografia e validação de dados do cartão de crédito para integração com a API de pagamentos da Juno/BoletoBancário."
  spec.homepage     = "http://www.juno.com.br"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  # spec.license      = "MIT (example)"
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.author             = { "Diego Trevisan Lara" => "diego@juno.com.br" }

  spec.ios.deployment_target = "11.0"
  spec.source       = { :git => "https://github.com/tamojuno/direct-checkout-ios.git", :tag => "#{spec.version}" }
  spec.source_files  = "DirectCheckout", "DirectCheckout/**/*.{h,m,swift}"
  spec.public_header_files = "DirectCheckout/**/*.h"
  # spec.exclude_files = "DirectCheckout/Exclude"

end
