//
//  ContentView.swift
//  Tolki
//
//  Created by Эльвира on 26.02.2025.
//


import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State var password_confirmation: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State private var showPassword: Bool = false
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        for family in UIFont.familyNames {
            print("Family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("  Font name: \(name)")
            }
        }
    }

    var body: some View {
        VStack {
            if viewModel.gotToken {
                MainTabView()
            } else {
                ZStack {
                    Color(.background)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("С возвращением!")
                            
                            .customTextStyle(.h1)
                            .foregroundColor(Color(.mainLight))
                            .padding(.bottom, 6.0)
                        Text("Чтобы учавствовать в обсуждениях, оставлять отзывы, тебе нужно войти в аккаунт!")
                            .multilineTextAlignment(.center)
                         
                            .frame(width: 350.0)
                            .customTextStyle(.text)
                            .foregroundColor(Color(.mainLight2))
                        
                        ZStack(alignment: .leading) {
                            if email.isEmpty {
                                Text("Логин")
                                    .customTextStyle(.h3)
                                    .foregroundColor(Color(.mainLight4))
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 16)
                            }

                            TextField("", text: $email)
                                .customTextStyle(.h3)
                                .foregroundColor(Color(.mainLight5))
                                .padding(.horizontal, 24)
                                .padding(.vertical, 16)
                        }
                        .background(Color(.mainLight))
                        .cornerRadius(8)
                        .padding(.bottom, -20)
                        .padding()
                        
                        ZStack(alignment: .leading) {
                            if password.isEmpty {
                                Text("Пароль")
                                    .customTextStyle(.h3)
                                    .foregroundColor(Color(.mainLight4))
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 16)
                            }

                            HStack {
                                if showPassword {
                                    TextField("", text: $password)
                                        .customTextStyle(.h3)
                                        .foregroundColor(Color(.mainLight5))
                                } else {
                                    SecureField("", text: $password)
                                        .customTextStyle(.h3)
                                        .foregroundColor(Color(.mainLight5))
                                }

                                Button(action: {
                                    showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(Color(.mainLight4))
                                }
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 16)
                        }
                        .background(Color(.mainLight))
                        .cornerRadius(8)
                        .padding()
                        
                        Button(action: {
                            viewModel.signIn(email: email, password: password)
                        }) {
                            Text("Войти")
                                .customTextStyle(.h2)
                                .foregroundColor(Color(.mainLight5))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 24)
                                .background(Color(.mainGreen))
                                .cornerRadius(8)
                        }
                        .padding()

                        VStack(spacing: 4) {
                            Text("Упс! Если вас ещё нет на нашем сервисе, срочно")
                                .foregroundColor(Color(.mainLight2))
                                .customTextStyle(.text)
                                .multilineTextAlignment(.center)
                            
                            NavigationLink(destination: RegView(viewModel: viewModel)) {
                                Text("зарегистрируйтесь")
                                    .foregroundColor(Color(.mainLight2))
                                    .underline()
                                    .customTextStyle(.text)
                            }
                        }
                        .padding(.top, 20)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct RegView: View {
    @ObservedObject var viewModel: ViewModel
    @State var password_confirmation: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State private var showPassword: Bool = false

    var body: some View {
        VStack {
            if viewModel.gotToken {
                MainTabView()
            } else {
                ZStack {
                    Color(.background)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("Приветствуем!")
                            
                            .customTextStyle(.h1)
                            .foregroundColor(Color(.mainLight))
                            .padding(.bottom, 6.0)
                        Text("Чтобы учавствовать в обсуждениях, оставлять отзывы, тебе нужно зарегистрироваться!")
                            .multilineTextAlignment(.center)
                         
                            .padding(.bottom, 32.0)
                            .frame(width: 350.0)
                            .customTextStyle(.text)
                            .foregroundColor(Color(.mainLight2))
                        
                        

                        ZStack(alignment: .leading) {
                            if email.isEmpty {
                                Text("Email")
                                    .customTextStyle(.h3)
                                    .foregroundColor(Color(.mainLight4))
                                    .padding(.vertical, 16)
                                    .padding(.horizontal, 24)
                            }

                            TextField("", text: $email)
                                .customTextStyle(.h3)
                                .foregroundColor(Color(.mainLight5))
                                .padding(.vertical, 16)
                                .padding(.horizontal, 24)
                        }
                        .background(Color(.mainLight))
                        .cornerRadius(8)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 16)

                        ZStack(alignment: .leading) {
                            if password.isEmpty {
                                Text("Пароль")
                                    .customTextStyle(.h3)
                                    .foregroundColor(Color(.mainLight4))
                                    .padding(.vertical, 16)
                                    .padding(.horizontal, 24)
                            }

                            HStack {
                                if showPassword {
                                    TextField("", text: $password)
                                        .customTextStyle(.h3)
                                        .foregroundColor(Color(.mainLight5))
                                } else {
                                    SecureField("", text: $password)
                                        .customTextStyle(.h3)
                                        .foregroundColor(Color(.mainLight5))
                                }

                                Button(action: {
                                    showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(Color(.mainLight4))
                                }
                            }
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                        }
                        .background(Color(.mainLight))
                        .cornerRadius(8)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 16)

                        ZStack(alignment: .leading) {
                            if password_confirmation.isEmpty {
                                Text("Подтвердите пароль")
                                    .customTextStyle(.h3)
                                    .foregroundColor(Color(.mainLight4))
                                    .padding(.vertical, 16)
                                    .padding(.horizontal, 24)
                            }

                            HStack {
                                if showPassword {
                                    TextField("", text: $password_confirmation)
                                        .customTextStyle(.h3)
                                        .foregroundColor(Color(.mainLight5))
                                } else {
                                    SecureField("", text: $password_confirmation)
                                        .customTextStyle(.h3)
                                        .foregroundColor(Color(.mainLight5))
                                }

                                Button(action: {
                                    showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(Color(.mainLight4))
                                }
                            }
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                        }
                        .background(Color(.mainLight))
                        .cornerRadius(8)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)

                        Button(action: {
                            viewModel.signUp(email: email, password: password, passwordConfirmation: password_confirmation)
                        }) {
                            Text("Зарегистрироваться")
                                .customTextStyle(.h2)
                                .foregroundColor(Color(.mainLight5))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 24)
                                .background(Color(.mainGreen))
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 20)
                        VStack(spacing: 4) {
                            Text("Если у тебя уже есть аккаунт, не стесняйся —")
                                .foregroundColor(Color(.mainLight2))
                                .customTextStyle(.text)
                                .multilineTextAlignment(.center)
                            
                            NavigationLink(destination:  ContentView(viewModel: viewModel)) {
                                Text("заходи!")
                                    .foregroundColor(Color(.mainLight2))
                                    .underline()
                                    .customTextStyle(.text)
                            }
                        }
                        .padding(.top, 20)
                        
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}




#Preview {
    RegView(viewModel: ViewModel())
}



