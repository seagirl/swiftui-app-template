//
//  HomeView.swift
//  app-template
//
//  Created by seagirl on 2021/06/23.
//

import SwiftUI

enum HomeCore {
	struct State: Equatable {
		var isLoading = false
		var buildNumber = "--"
		var count: Int = 0
	}

	enum Action: Equatable {
		case load
		case getBuildNumber
		case didLoad(String)
		case incrementCounter
		case decrementCounter
	}

	struct Environment {
		let getBuildNumberInteractor: GetBuildNumberUsecase
	}

	static let reducer = { (state: State, action: Action, environment: Environment) async -> Effect<State, Action> in
		var state = state
		switch action {
		case .load:
			state.isLoading = true
			return .actionWith(state, .getBuildNumber)
		case .getBuildNumber:
			let buildNumber = await environment.getBuildNumberInteractor.execute(.init())
			return .action(.didLoad(buildNumber))
		case .didLoad(let buildNumber):
			state.buildNumber = buildNumber
			state.isLoading = false
			return .state(state)
		case .incrementCounter:
			state.count += 1
			return .state(state)
		case .decrementCounter:
			state.count -= 1
			return .state(state)
		}
	}
}

struct HomeView: View {
	@ObservedObject var store: Store<HomeCore.State, HomeCore.Action, HomeCore.Environment>

    var body: some View {
		VStack {
			Text("HomeView")

			Text("buildNumber: \(store.state.isLoading ? "loading..." : store.state.buildNumber)")

			HStack {
				Text("count: \(store.state.count)")

				Button(action: {
					store.send(action: .decrementCounter)
				}) {
					Image(systemName: "minus.circle")
						.foregroundColor(.primary)
				}

				Button(action: {
					store.send(action: .incrementCounter)
				}) {
					Image(systemName: "plus.circle")
						.foregroundColor(.primary)
				}
			}

		}
		.onAppear {
			store.send(action: .load)
		}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
		HomeView(store: .init(
			state: .init(),
			reducer: HomeCore.reducer,
			environment: .init(
				getBuildNumberInteractor: MockGetBuildNumberInteractor()
			)
		))
    }
}
