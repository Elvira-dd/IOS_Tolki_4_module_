//
//  IssuePage.swift
//  Tolki
//
//  Created by Эльвира on 21.05.2025.
//

import SwiftUI


struct IssueView: View {
        @State private var issues: [Issue] = []
        
        var body: some View {
            NavigationView {
                List(issues) { issue in
                    NavigationLink(destination: IssueDetailView(issue: issue)) {
                        HStack {
                            AsyncImage(url: URL(string: issue.coverURL)) { image in
                                image.resizable().scaledToFit().frame(width: 50, height: 50)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(issue.name)
                                .font(.headline)
                        }
                    }
                }
                .navigationTitle("Выпуски")
                .onAppear {
                    IssueAllService.shared.fetchIssues { issues in
                            if let issues = issues {
                                print("Получено выпусков: \(issues.count)")
                                DispatchQueue.main.async {
                                    self.issues = issues
                                }
                            } else {
                                print("Ошибка: не удалось получить выпуски")
                            }
                        }
                }
            }
        }
    }


#Preview {
    IssueView()
}
