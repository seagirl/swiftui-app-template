//
//  Store.swift
//  app-template
//
//  Created by seagirl on 2021/06/23.
//

import Foundation

final class Store<State, Action, Environment>: ObservableObject {
	@Published var state: State

	private let reducer: ((State, Action, Environment) async -> Effect<State, Action>)
	private let environment: Environment

	init (state: State, reducer: @escaping ((State, Action, Environment) async -> Effect<State, Action>), environment: Environment) {
		self.state = state
		self.reducer = reducer
		self.environment = environment
	}

	func send(action: Action) {
		async {
			let effect = await reducer(state, action, environment)
			switch effect {
			case .action(let action):
				self.send(action: action)
			case .state(let state):
				DispatchQueue.main.async { [weak self] in
					self?.state = state
				}
			case .actionWith(let state, let action):
				self.send(action: action)

				DispatchQueue.main.async { [weak self] in
					self?.state = state
				}
			}
		}
	}
}
