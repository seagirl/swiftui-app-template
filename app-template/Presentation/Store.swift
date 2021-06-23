//
//  Store.swift
//  app-template
//
//  Created by seagirl on 2021/06/23.
//

import Foundation

final class Store<State, Action, Environment>: ObservableObject {
	@Published var state: State

	private let reducer: ((State, Action, Environment) async -> (State?, Action?))
	private let environment: Environment

	init (state: State, reducer: @escaping ((State, Action, Environment) async -> (State?, Action?)), environment: Environment) {
		self.state = state
		self.reducer = reducer
		self.environment = environment
	}

	func send(action: Action) {
		async {
			let (newState, nextAction) = await reducer(state, action, environment)
			if let action = nextAction {
				self.send(action: action)
			}

			if let state = newState {
				DispatchQueue.main.async { [weak self] in
					self?.state = state
				}
			}
		}
	}
}
