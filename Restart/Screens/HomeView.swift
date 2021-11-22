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
      // MARK: Header
      
      Spacer()
      
      Image("character-2")
        .resizable()
        .scaledToFit()
        .padding()
      
      // MARK: Center
      
      Text("The time that leads to mastery is dependent on the intensity of our focus.")
        .font(.title3)
        .fontWeight(.light)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
        .padding()
      
      // Mark: Footer
      
      Spacer()
      
      Button(action: {
        isOnboardingViewActive = true
      }) {
        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
          .imageScale(.large)
        
        Text("Restart")
          .font(.system(.title3, design: .rounded))
          .fontWeight(.bold)
      } // Button
      .buttonStyle(.borderedProminent)
      .buttonBorderShape(.capsule)
      .controlSize(.large)
      
    } // VStack
  }

}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
