//
//  FetchAPIManager.swift
//  _idx_AccountContext_A3EBD410_ios_min11.0
//
//  Created by Alexey Yakushev on 09.11.2022.
//

import Foundation
import SwiftSignalKit

public typealias ApiDateInfo = (DateInfo?, APIError?)

public enum FetchAPIManagerCategory {
	case date
}

public protocol FetchAPIManager {
	var service: AccountService { get }
	func fetch(category: FetchAPIManagerCategory) -> Signal<ApiDateInfo, NoError>
}

public final class FetchAPIManagerImpl: FetchAPIManager {
	public var service: AccountService
	
	public init(service: AccountService) {
		self.service = service
	}
	
	public func fetch(category: FetchAPIManagerCategory) -> Signal<ApiDateInfo, NoError> {
		let promise = Promise<ApiDateInfo>((nil ,nil))
		service.fetchServerDate(completion: { value, error in
			promise.set(Signal { subscriber in
				subscriber.putNext((value, error))
				subscriber.putCompletion()
				return EmptyDisposable
			})
		})
		
		return promise.get()
	}
}
