//
//  IAPIStrategy.swift
//  Core
//
//  Created by Diego Trevisan Lara on 07/11/18.
//  Copyright © 2018 Juno Pagamentos. All rights reserved.
//

protocol IAPIStrategy {
    func execute<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<T, DirectCheckoutError>) -> Void)
}
