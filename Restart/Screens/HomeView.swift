//
//  HomeView.swift
//  Restart
//
//  Created by Jose Martin de Villa on 11/21/21.
//

import SwiftUI

struct HomeView: View {
  
  // MARK: Property
  @AppStorage("onboarding") var isOnboardingViewActive = false
  
  var body: some View {
    VStack(spacing: 20) {
      Text("Home")
        .font(.largeTitle)
      
      Button(action: {
        isOnboardingViewActive = true
      }) {
        Text("Restart")
      } // Button
    } // VStack
  }

}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
