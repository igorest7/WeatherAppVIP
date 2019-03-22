//
//  NetworkRequestManager.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import Foundation

public typealias NetworkRequestManagerCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> Void

protocol NetworkRequestManagerProtocol: class {
	associatedtype Router: URLRequestConvertible
	func request(_ router: Router, completion: @escaping NetworkRequestManagerCompletion)
	func cancel()
}

class RemoteRequestManager<Router: URLRequestConvertible>: NetworkRequestManagerProtocol {
	private var task: URLSessionTask?

	func request(_ router: Router, completion: @escaping NetworkRequestManagerCompletion) {
		let session = URLSession.shared
		do {
			let request = try router.asURLRequest()
			task = session.dataTask(with: request, completionHandler: { data, response, error in
				completion(data, response, error)
			})
		}catch {
			completion(nil, nil, error)
		}
		task?.resume()
	}

	func cancel() {
		task?.cancel()
		task = nil
	}
}
