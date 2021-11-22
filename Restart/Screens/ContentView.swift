//
//  ContentView.swift
//  Restart
//
//  Created by Jose Martin de Villa on 11/21/21.
//

import SwiftUI

struct ContentView: View {

  // Set up a new "onboarding" key in app storage:
  // - `@AppStorage` is a SwiftUI property wrapper for reading and writing values to
  //   the `UserDefaults`.
  // - `onboarding` is the key corresponding to the value that we want to store.
  // - `isOnboardingViewActive` is the property name that we’ll use
  // - `true` is the value assigned to the property
  @AppStorage("onboarding") var isOnboardingViewActive = true
  
  var body: some View {
    ZStack {
      if isOnboardingViewActive {
        OnboardingView()
      } else {
        HomeView()
      } // if isOnboardingViewActive
    } // ZStack
  } // body
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
