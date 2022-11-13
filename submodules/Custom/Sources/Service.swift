//
//  Service.swift
//  _idx_Custom_A1498718_ios_min11.0
//
//  Created by Alexey Yakushev on 10.11.2022.
//

import Foundation

public class Service {
	func getData(for url: URL,
				 completion: @escaping (Data?, APIError?) -> Void)
	{
		let session = URLSession(configuration: .default)
		let request = URLRequest(url: url)
		let dataTask = session.dataTask(with: request) { data, response, error in
			guard let httpResponse = response as? HTTPURLResponse,
				  200...299 ~= httpResponse.statusCode else {
				completion(nil, APIError.httpResponseError)
				return
			}
			
			completion(data, APIError(error: error))
		}
		dataTask.resume()
	}
}
