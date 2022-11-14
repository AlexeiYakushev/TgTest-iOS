//
//  AccountService.swift
//  _idx_AccountContext_A3EBD410_ios_min11.0
//
//  Created by Alexey Yakushev on 09.11.2022.
//

import Foundation

public typealias IntCompletion = (DateInfo?, APIError?) -> Void

public protocol AccountService {
	func fetchServerDate(completion: @escaping IntCompletion)
}

public final class AccountServiceImpl: Service {
	public static let shared = AccountServiceImpl()
	
	private let baseURLString = "http://worldtimeapi.org/api"
	
	private enum AccountServiceType {
		case serverDate
		
		var path: String {
			switch self {
			case .serverDate: return "timezone/Europe/Moscow"
			}
		}
	}
	
	private var baseURL: URL? {
		URL(string: baseURLString)
	}
	
	private func url(for type: AccountServiceType) -> URL? {
		baseURL?.appendingPathComponent(type.path)
	}
}

extension AccountServiceImpl: AccountService {
	public func fetchServerDate(completion: @escaping IntCompletion) {
		guard let url = url(for: .serverDate) else {
			completion(nil, .incorrectURL)
			return
		}
		
		getData(for: url) { data, error in
			if let error = error {
				completion(nil, error)
			} else if let data = data {
				do {
					let value = try JSONDecoder().decode(DateInfo.self, from: data)
					completion(value, nil)
				} catch {
					completion(nil, APIError(error: error))
				}
			} else {
				completion(nil, .emptyData)
			}
		}
	}
}



