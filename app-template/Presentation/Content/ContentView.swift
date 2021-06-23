//
//  ContentView.swift
//  app-template
//
//  Created by seagirl on 2021/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		TabView {
			HomeView(store: .init(
				state: .init(),
				reducer: HomeCore.reducer,
				environment: .init(
					getBuildNumberInteractor: GetBuildNumberInteractor()
				)
			))
				.tabItem {
					VStack {
						Image(systemName: "house")
						Text("HOME")
					}
				}
				.tag(1)
			SettingView()
				.tabItem {
					VStack {
						Image(systemName: "gear")
						Text("SETTING")
					}
				}
				.tag(2)
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
