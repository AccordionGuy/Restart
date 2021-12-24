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
  @State private var isAnimating = false
  
  var body: some View {
    ZStack {
      Color("ColorRed")
        .ignoresSafeArea(.all, edges: .all)
      
      VStack(spacing: 20) {
        
        // MARK: Header
        
        Spacer()
        
        ZStack {
          CircleGroupView(ShapeColor: .blue, ShapeOpacity: 0.2)
          
          Image("joey-and-accordion")
            .resizable()
            .scaledToFit()
            .padding()
            .offset(y: isAnimating ? 35 : -35)
            .animation(
              .easeInOut(duration: 4)
                .repeatForever()
              , value: isAnimating
            )
        }
        
        // MARK: Center
        
        Text("""
        Joey deVilla
        works like Harold
        and plays like Kumar.
        """)
          .font(.title3)
          .fontWeight(.light)
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 10)
        
        // Mark: Footer
        
        Spacer()
        
        Button(action: {
          withAnimation {
            playSound(sound: "success", type: "m4a")
            isOnboardingViewActive = true
          }
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
        
      }
    } // VStack
    .onAppear(perform: {
      // Start bobbing the photo a half-second after the page appears
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
        isAnimating = true
      })
    })
  }

}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
