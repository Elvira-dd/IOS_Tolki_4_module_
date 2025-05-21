//
//  FeedbackView.swift
//  Tolki
//
//  Created by Эльвира on 26.11.2024.
//

import SwiftUI
import MessageUI

struct FeedbackView: View {
    @State private var message = ""
    @State private var showMailComposer = false
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Обратная связь")
                    .font(.title)
                    .bold()
                
                TextEditor(text: $message)
                    .border(Color.gray, width: 1)
                    .frame(height: 150)
                    .padding()
                
                Button("Отправить Email") {
                    if MFMailComposeViewController.canSendMail() {
                        showMailComposer = true
                    } else {
                        Text("Кажется, у вас проблемы с почтой")
                            .font(.title)
                            .bold()
                    }
                }
                .sheet(isPresented: $showMailComposer) {
                    MailView(result: $mailResult, message: message)
                }
                
                Button("Отправить Telegram") {
                    sendTelegramMessage()
                }
                
                
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Обратная связь", displayMode: .inline)
        }
    }
    
    func sendTelegramMessage() {
        let text = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlStr = "https://t.me/el_desdiva\(text)"
        if let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            // Показать ошибку или редирект на Telegram Web
        }
    }
    
    func sendSMS() {
        let text = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlStr = "sms:&body=\(text)"
        if let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            // Показать ошибку
        }
    }
}

// Обертка для MFMailComposeViewController
struct MailView: UIViewControllerRepresentable {
    @Binding var result: Result<MFMailComposeResult, Error>?
    var message: String

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(result: Binding<Result<MFMailComposeResult, Error>?>) {
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer { controller.dismiss(animated: true) }
            if let error = error {
                self.result = .failure(error)
                return
            }
            self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(result: $result)
    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setToRecipients(["team@tolki.app"])
        vc.setSubject("Обратная связь Tolki")
        vc.setMessageBody(message, isHTML: false)
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
}
