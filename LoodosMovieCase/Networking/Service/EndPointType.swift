//
//  EndPointType.swift
//  LoodosMovieCase
//
//  Created by Abdülbaki Kaplan on 13.06.2020.
//  Copyright © 2020 Baki. All rights reserved.
//

import Foundation
protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
