//
//  IScreamAppView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 13/02/24.
//

import SwiftUI

struct IScreamAppView: View {
    
    @StateObject var vm = AppViewModel()
    
    var body: some View {
        ZStack {
            if vm.isShowingWelcomeView {
                ZStack {
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    
                    WelcomeView(vm: vm)
                }
            } else if vm.isShowingMonsters {
                ZStack {
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    
                    MonsterView(vm: vm)
                }
            } else {
                LeaderBoardView(vm: vm)
            }
        }
        .alert(item: $vm.alertItem) { alertItem in
            if alertItem.title.contains("surrender") {
                vm.stopRecording()
                vm.cancelTimer()
                
                return Alert(
                    title: Text("Are you sure to quit?"),
                    primaryButton: .destructive(Text("Surrender"), action: {
                        vm.isShowingWelcomeView = true
                        vm.isShowingMonsters = false
                        
                        vm.setResetState()
                    }),
                    secondaryButton: .default(Text("Cancel"), action: {
                        vm.startRecording()
                        Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
                            .sink { [self] _ in
                                vm.runTimer()
                            }
                            .store(in: &vm.cancellables)
                    })
                )
            } else {
                return Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
            }
        }
    }
}

#Preview {
    IScreamAppView()
}
