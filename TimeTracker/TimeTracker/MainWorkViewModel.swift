//
//  MainWorkViewModel.swift
//  TimeTracker
//
//  Created by Jannic Marcon on 28.11.2025.
//
import Foundation
import SwiftUI
import Combine
import SwiftData

final class MainWorkViewModel: ObservableObject {
    @Published var activeWorksession: WorkSession?
    @Published var allWorksessionsCount: Int = 0
    
    init() { }
    
    func initData(context: ModelContext){
        loadActiveWorkSession(context: context)
        updateWorkSessionCount(context: context)
    }
    
    func updateWorkSessionCount(context: ModelContext){
        let fetchDescriptor = FetchDescriptor<WorkSession>()
        
        do {
            let count = try context.fetchCount(fetchDescriptor)
            allWorksessionsCount = count
        } catch { }
    }
    
    func loadActiveWorkSession(context: ModelContext) {
        let fetchDescriptor = FetchDescriptor<WorkSession>(
            predicate: #Predicate { $0.end == nil }
        )
        
        do {
            let sessions = try context.fetch(fetchDescriptor)
            
           /*
             // delete all sessions:
             for sess in sessions {
             context.delete(sess)
             }
             try context.save()
             */
            
            assert(sessions.count <= 1, "only one session can be active")
            if let session = sessions.first {
                self.activeWorksession = session
            }
        } catch { }
    }
        
    func startWorkSession(tags: String, context: ModelContext){
        let session = WorkSession(start: .now)
        context.insert(session)
        try? context.save()
        activeWorksession = session
        updateWorkSessionCount(context: context)
    }
    
    func modifyNotes(note: String, context: ModelContext){
        guard let activeWorksession else { return }
        activeWorksession.notes = note
    }
    
    func endWorkSession(context: ModelContext){
        guard let activeWorksession else { return }
        activeWorksession.end = .now
    }
}
