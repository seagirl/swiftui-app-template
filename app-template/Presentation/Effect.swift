//
//  Effect.swift
//  app-template
//
//  Created by seagirl on 2021/06/28.
//

import Foundation

enum Effect<State, Action> {
	case state(State)
	case action(Action)
	case actionWith(State, Action)
}
