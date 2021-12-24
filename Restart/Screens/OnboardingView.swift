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
  
  @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
  @State private var buttonOffset: CGFloat = 0
  @State private var isAnimating = false
  @State private var imageOffset = CGSize.zero
  @State private var indicatorOpacity = 1.0
  @State private var textTitle = "Share."
  
  let hapticFeedback = UINotificationFeedbackGenerator()
  
  
  var body: some View {
    ZStack {
      Color("ColorBlue")
        .ignoresSafeArea(.all, edges: .all)
      
      VStack(spacing: 20) {
        // MARK: Header
        
        Spacer()
        
        VStack(spacing: 0) {
          Text(textTitle)
            .font(.system(size: 60))
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .transition(.opacity)
            .id(textTitle) // The `id()` hack!
            // SwiftUI does not consider changes to the contents of a `Text` view
            // to be a change of that view — it’s still the same view,
            // as far as SwiftUI is concerned.
            // This means that the transition doesn’t happen.
            // The `id()` method binds the identity of a view to the given value.
            // Changing `textTitle` changes the identity of the `Text` view,
            // which causes SwiftUI to consider it as having changed,
            // which in turn triggers
          
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
        
        // Apply animation to the header. The animation is made up
        // of the following changes, which happen simultaneously
        // when this screen appears:
        // - Fade in from completely invisible to completely opaque
        // - Move to the final y-position from 200 pixels above
        //
        // The `animation()` method specifies the following:
        // - The animation should take 1 second to occur
        // - It’s an “ease out” animation, which means it doesn’t
        //   happen at a constant rate, but slows down at the end
        // - It happens only if `isAnimating()` is `true`
        .opacity(isAnimating ? 1 : 0)
        .offset(y: isAnimating ? 0 : -200)
        .animation(.easeOut(duration: 1), value: isAnimating)
        
        
        // MARK: Center
        
        ZStack {
          CircleGroupView(ShapeColor: .orange, ShapeOpacity: 0.5)
            .padding(.top, 80)
            .offset(x: imageOffset.width * -1)
            .blur(radius: abs(imageOffset.width / 5))
            .animation(.easeOut(duration: 1), value: imageOffset)
          
          Image("black-accordion")
            .resizable()
            .scaledToFit()
            .padding()
            .padding(.top, 80)
          
            // Apply animation to the accordion. The animation is made up
            // of the following changes, which happen simultaneously
            // when this screen appears:
            // - Fade in from completely invisible to completely opaque
            // - Rotate from upside-down to right side up
            //
            // The `animation()` method specifies the following:
            // - The animation should take 2 seconds to occur
            // - It’s an “ease out” animation, which means it doesn’t
            //   happen at a constant rate, but slows down at the end
            // - It happens only if `isAnimating()` is `true`
            .opacity(isAnimating ? 1 : 0)
            .rotationEffect(isAnimating ? Angle(degrees: 0) : Angle(degrees: 180))
            .animation(.easeOut(duration: 2.0), value: isAnimating)
            .offset(x: imageOffset.width * 1.2, y: 0)
            .rotationEffect(.degrees(Double(imageOffset.width / 8)))
            .gesture(
              DragGesture()
                .onChanged { gesture in
                  if abs(imageOffset.width) <= 150 {
                    imageOffset = gesture.translation
                    
                    withAnimation(.linear(duration: 0.25)) {
                      indicatorOpacity = 0
                      textTitle = "Give."
                    }
                  }
                }
                .onEnded { _ in
                  imageOffset = .zero
                  
                  withAnimation(.linear(duration: 0.25)) {
                    indicatorOpacity = 1
                    textTitle = "Share."
                  }
                }
            ) // gesture()
            .animation(.easeOut(duration: 1), value: imageOffset)
        } // ZStack (Center)
        .overlay(
          Image(systemName: "arrow.left.and.right.circle")
            .font(.system(size: 44, weight: .ultraLight))
            .foregroundColor(.white)
            .offset(y: 20)
            .opacity(isAnimating ? 1 : 0)
            .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
            .opacity(indicatorOpacity)
          , alignment: .bottom
        )
        
        Spacer()
        
        // MARK: Footer
        
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
              .frame(width: buttonOffset + 80)
            
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
            .offset(x: buttonOffset)
            .gesture(
              DragGesture()
                .onChanged { gesture in
                  if gesture.translation.width > 0  && buttonOffset <= buttonWidth - 80 {
                    buttonOffset = gesture.translation.width
                  }
                } // onChanged()
                .onEnded { _ in
                  // `withAnimation()`
                  withAnimation(Animation.easeOut(duration: 1.0)) {
                    if buttonOffset > buttonWidth / 2 {
                      hapticFeedback.notificationOccurred(.success)
                      playSound(sound: "chimeup", type: "mp3")
                      buttonOffset = 0
                      isOnboardingViewActive = false
                    } else {
                      hapticFeedback.notificationOccurred(.warning)
                      buttonOffset = 0
                    }
                  }
                }
            )
            
            Spacer()
          }
          
        } // ZStack (Footer)
        .frame(width: buttonWidth, height:80, alignment: .center)
        .padding()
        
        // Apply animation to the footer. The animation is made up
        // of the following changes, which happen simultaneously
        // when this screen appears:
        // - Fade in from completely invisible to completely opaque
        // - Move to the final y-position from 200 pixels below
        //
        // The `animation()` method specifies the following:
        // - The animation should take 1 second to occur
        // - It’s an “ease out” animation, which means it doesn’t
        //   happen at a constant rate, but slows down at the end
        // - It happens only if `isAnimating()` is `true`
        .opacity(isAnimating ? 1 : 0)
        .offset(y: isAnimating ? 0 : 200)
        .animation(.easeOut(duration: 1.0), value: isAnimating)
        
      } // VStack
    } // ZStack
    .onAppear(perform: {
      isAnimating = true
    })
    .preferredColorScheme(.dark)
  }
  
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
  }
}
