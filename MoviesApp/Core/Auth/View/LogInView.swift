//
//  LogInView.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import SwiftUI

struct LogInView: View {
    
    @StateObject private var vm = AuthViewModel()
    @State private var isShowingCreateUser = false
    @Binding var showSignInView: Bool
    @State private var showAlertWrongSignIn: Bool = false
    @State  var showCreatedAlert: Bool = false
    @State  var showCreatedFailAlert:Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "person.and.background.dotted")
                .font(.system(size: 200))
            TextField("Enter Email, or VVVBB (ensure uppercase)", text: $vm.email)
                .TextFieldFormat()
            SecureField("Enter Password or @bcd1234", text: $vm.password)
                .TextFieldFormat()
            Button {
                Task {
                    if vm.email == "VVVBB" && vm.password == "@bcd1234" {
                        showSignInView = false
                    } else {
                        let success = try await vm.signIn()
                        if success {
                            showSignInView = false
                        } else {
                            showAlertWrongSignIn.toggle()
                        }
                    }
                    
                }
                
            } label: {
                Text("Sign In")
                    .homeButtonFormat(color: Color.blue)
            }
            
            Button("Dont have an account? Create one!") {
                isShowingCreateUser.toggle()
            }
        }
        .alert(isPresented: $showAlertWrongSignIn, content: {
            vm.wrongSignInCredentialsAlert()
        })
        .padding()
        .navigationTitle("Sign In")
        .sheet(isPresented: $isShowingCreateUser) {
            SignUpView(vm: vm, showCreatedAlert: $showCreatedAlert)
        }
    }
}

#Preview {
    LogInView(showSignInView: .constant(false))
}
