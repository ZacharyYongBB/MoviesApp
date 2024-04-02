//
//  SignUpView.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var vm: AuthViewModel
    @Binding var showCreatedAlert: Bool
    @State var createdSuccess: Bool = false
    @State private var isButtonScaled = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Create an account")
                .font(.largeTitle)
            Image(systemName: "person.crop.circle.badge.plus")
                .font(.system(size: 150))
                .padding(.vertical, 80)
            TextField("Enter Email", text: $vm.email)
                .TextFieldFormat()
            SecureField("Enter Password", text: $vm.password)
                .TextFieldFormat()
            
            if !createdSuccess {
                Button {
                    Task {
                        createdSuccess = try await vm.createUser()
                        showCreatedAlert.toggle()
                    }
                } label: {
                    Text("Create Account")
                        .homeButtonFormat(color: Color.blue)
                }
                
            }
            
            if createdSuccess {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Back to Sign In")
                        .homeButtonFormat(color: Color.blue)
                        .scaleEffect(isButtonScaled ? 1 : 0.85)
                        .animation(.spring(), value: isButtonScaled)
                        .onAppear {
                            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                                withAnimation {
                                    isButtonScaled.toggle()
                                }
                            }
                        }
                }
            }
        }
        .alert(isPresented: $showCreatedAlert, content: {
            vm.accountCreatedAlert(success: createdSuccess)
        })
        .padding()
    }
}

#Preview {
    SignUpView(vm: AuthViewModel(), showCreatedAlert: .constant(false))
}
