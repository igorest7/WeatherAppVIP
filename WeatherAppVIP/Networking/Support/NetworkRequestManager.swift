//
//  NetworkRequestManager.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 22/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

import Foundation

typealias NetworkRequestManagerCompletion = (Either<Data, Error>) -> Void

protocol NetworkRequestManager: class {
	func request(_ router: URLRequestConvertible, completion: @escaping NetworkRequestManagerCompletion)
	func cancel()
}

class NetworkRequestManagerImplementation: NetworkRequestManager {
	private var task: URLSessionTask?

	func request(_ router: URLRequestConvertible, completion: @escaping NetworkRequestManagerCompletion) {
		let session = URLSession.shared
		do {
			let request = try router.asURLRequest()
			task = session.dataTask(with: request, completionHandler: { [weak self] data, response, error in
				guard let self = self else { return }
				let responseResult = self.handleNetworkResponse(response)
				switch responseResult {
				case .success:
					guard  let data = data else {
						completion(.right("network.response.empty.response".localized))
						return
					}
					completion(.left(data))
				case .failure(let error):
					completion(.right(error))
				}
			})
		}catch {
			completion(.right(error))
		}
		task?.resume()
	}

	func cancel() {
		task?.cancel()
		task = nil
	}
}

// MARK: - Private
private extension NetworkRequestManagerImplementation {
	func handleNetworkResponse(_ response: URLResponse?) -> NetworkRequestResult {
		guard let response = response as? HTTPURLResponse else {
			return .failure("network.response.unknown".localized)
		}

		switch response.statusCode {
		case 200...299: return .success
		case 400...499: return .failure("network.response.bad.request".localized)
		case 500...599: return .failure("network.response.server.error".localized)
		default: return .failure("network.response.request.failed".localized)
		}
	}
}
