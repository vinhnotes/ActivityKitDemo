//
//  APIServiceProtocol.swift
//  ActivityKit-Demo
//
//  Created by vinhvd on 27/09/2022.
//

import Foundation

protocol APIServiceProtocol {
    func getLiveScore(url: URL?, completion: @escaping(Result<[Match], APIError>) -> Void)
}
