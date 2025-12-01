//
//  ContentView.swift
//  TimeTracker
//
//  Created by Jannic Marcon on 28.11.2025.
//

import SwiftUI
import SwiftData

struct MainWorkView: View {
    @Environment(\.modelContext) private var modelContext

    @StateObject private var viewModel = MainWorkViewModel()
    @State private var tags: String = ""
    @State private var notes: String = ""

    var body: some View {
        NavigationSplitView {
            VStack(spacing: 20) {
                if let session = viewModel.activeWorksession {
                    TextField("#Tags", text: Binding(
                        get: { session.tags },
                        set: { session.tags = $0 }
                    ))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }

                TextEditor(text: $notes)
                    .frame(minHeight: 200)
                    .padding(.horizontal)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.horizontal)

                Spacer()

                if let session = viewModel.activeWorksession {
                    Text("Task started at: \(session.start)")
                }

                Button {
                    if viewModel.activeWorksession == nil {
                        viewModel.startWorkSession(tags: tags, context: modelContext)
                    } else {
                        viewModel.endWorkSession(context: modelContext)
                    }
                } label: {
                    Image(systemName: iconName())
                        .font(.system(size: 24))
                        .padding()
                }
                .background(Circle().fill(Color.accentColor))
                .foregroundColor(.white)
                .shadow(radius: 4)
                .padding(.bottom, 30)
            }
        } detail: {
            Text("Select an item")
        }
        .onAppear{
            viewModel.initData(context: modelContext)
        }
    }

    func iconName() -> String {
        viewModel.activeWorksession == nil ? "play" : "stop"
    }
}



#Preview {
    MainWorkView()
}
