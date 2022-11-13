//
//  APIError.swift
//  _idx_Custom_A1498718_ios_min11.0
//
//  Created by Alexey Yakushev on 10.11.2022.
//

import Foundation

public enum APIError: Error {
	case error(Error)
	case httpResponseError
	case incorrectURL
	case emptyData
	
	init?(error: Error?) {
		if let error = error {
			self = .error(error)
		} else {
			return nil
		}
	}
	
	public var description: String {
		switch self {
		case let .error(errorValue): return errorValue.localizedDescription
		case .httpResponseError: return "Ошибка сети"
		case .incorrectURL: return "Неверный url"
		case .emptyData: return "Нет данных"
		}
	}
}
