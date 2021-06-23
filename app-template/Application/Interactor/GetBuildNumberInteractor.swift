//
//  GetBuildNumberInteractor.swift
//  app-template
//
//  Created by seagirl on 2021/06/23.
//

import Foundation

protocol GetBuildNumberUsecase {
	typealias Input = GetBuildNumberInteractor.Input
	typealias Output = GetBuildNumberInteractor.Output

	func execute(_ input: Input) async -> Output
}

struct GetBuildNumberInteractor: GetBuildNumberUsecase {
	struct Input {
	}

	typealias Output = String

	func execute(_ input: Input) async -> Output {
		sleep(2)
		
		if let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
			return buildNumber
		} else {
			return ""
		}
	}
}

struct MockGetBuildNumberInteractor: GetBuildNumberUsecase {
	func execute(_ input: Input) async -> Output {
		return "137"
	}
}
