//
//  WelcomeView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 13/02/24.
//

import SwiftUI


enum FormTextField {
    case focus
}

struct WelcomeView: View {
    
    @ObservedObject var vm: AppViewModel
    
    @State var didTapStart = false
    @FocusState var focusedTextField: FormTextField?
    
    var body: some View {
        VStack {
            Image("welcomelogo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .padding(.top, 210)
            
            Spacer()
            
            VStack {
                if !didTapStart {
                    Button(action: {
                        didTapStart = true
                        focusedTextField = .focus
                    }, label: {
                        TapToStartButton()
                    })
                    .modifier(TapToStartButtonModifier())
                    
                    Button(action: {
                        vm.isShowingMonsters = false
                        vm.isShowingWelcomeView = false
                    }, label: {
                        LeaderboardButton()
                    })
                    .padding(.trailing, 20)
                    .offset(y: 150)
                    
                } else {
                    
                    // TEXTFIELD & CHECKMARK
                    HStack {
                        TextField("Your name here!", text: $vm.username)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .focused($focusedTextField, equals: .focus)
                            .onSubmit {
                                focusedTextField = nil
                            }
                            .modifier(TextFieldModifier())
                        
                        Button(action: {
                            vm.onTapCheckMark {
                                focusedTextField = nil
                                vm.isShowingWelcomeView = false
                                vm.isShowingMonsters = true
                            }
                        }, label: {
                            CheckMarkButton()
                        })
                        .padding(.leading, 2)
                    }
                    .frame(width: 310, height: 75)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 14, height: 10)))
                    .padding(.top, 50)
                    
                    // BACK BUTTON
                    Button(action: {
                        didTapStart = false
                        focusedTextField = nil
                    }, label: {
                        BackButton()
                    })
                    .padding(.top, 10)
                }
            }
            .padding(.bottom, 250)
        }
    }
}

#Preview {
    WelcomeView(vm: AppViewModel())
}
