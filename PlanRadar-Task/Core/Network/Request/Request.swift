//
//  Request.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 17/07/2021.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Request {
    var path: String { get }
    var parameters: [String: Any]? { get }
    var httpMethod: HttpMethod { get }
    var httpHeaders: [String: Any]? { get }
}
