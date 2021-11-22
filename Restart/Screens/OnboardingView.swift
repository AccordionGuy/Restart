//
//  OnboardingView.swift
//  Restart
//
//  Created by Jose Martin de Villa on 11/21/21.
//

import SwiftUI

struct OnboardingView: View {
  
  // MARK: Property
  
  // This `true` value is assigned to the property if and only if
  // the program doesn’t find the `onboarding` key in the device’s
  // permanent storage.
  // If there’s an `onboarding` key already in permanent storage,
  // this assignment is ignored.
  @AppStorage("onboarding") var isOnboardingViewActive = true
  
  var body: some View {
    ZStack {
      Color("ColorBlue")
        .ignoresSafeArea(.all, edges: .all)
      
      VStack(spacing: 20) {
        // MARK: Header
        
        Spacer()
        
        VStack(spacing: 0) {
          Text("Accordion!")
            .font(.system(size: 60))
            .fontWeight(.heavy)
            .foregroundColor(.white)
          
          Text("""
          Ain’t no party like
          an accordion party!
          """)
            .font(.title3)
            .fontWeight(.light)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 10)
        } // VStack (Header)
        
        // MARK: Center
        
        ZStack {
          ZStack {
            Circle()
              .stroke(.white.opacity(0.2), lineWidth: 40)
              .frame(width: 260, height: 260, alignment: .center)
            Circle()
              .stroke(.white.opacity(0.2), lineWidth: 80)
              .frame(width: 260, height: 260, alignment: .center)
          } // ZStack
          
          Image("black-accordion")
            .resizable()
            .scaledToFit()
            .padding(25)
        } // ZStack (Center)
        
        Spacer()
        
        // Mark: Footer
        
        ZStack {
          
          // Parts of the custom button
          
          // 1. Background (static)
          Capsule()
            .fill(Color.white.opacity(0.2))
          
          Capsule()
            .fill(Color.white.opacity(0.2))
            .padding(8)
          
          // 2. Call to action (static)
          
          Text("Let’s rock!")
            .font(.system(.title3, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .offset(x: 20) // Make the text “centered” while accounting for the sliding circle
          
          // 3. Capsule (dynmaic width)
          
          HStack {
            Capsule()
              .fill(Color("ColorRed"))
              .frame(width: 80)
            
            Spacer()
          }
          
          // 4. Circle (draggable)
          
          HStack {
            ZStack {
              Circle()
                .fill(Color("ColorRed"))
              Circle()
                .fill(.black.opacity(0.15))
                .padding(8)
              Image(systemName: "chevron.right.2")
                .font(.system(size:24, weight: .bold))
            }
            .foregroundColor(.white)
            .frame(width: 80, height: 80, alignment: .center)
            .onTapGesture {
              isOnboardingViewActive = false
            }
            
            Spacer()
          }
          
        } // ZStack (Footer)
        .frame(height:80, alignment: .center)
        .padding()
        
      } // VStack
    } // ZStack
  }
  
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
  }
}
