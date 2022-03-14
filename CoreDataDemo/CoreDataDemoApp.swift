//
//  CoreDataDemoApp.swift
//  CoreDataDemo
//
//  Created by Shubham Kumar on 01/02/22.
//

import SwiftUI

@main
struct CoreDataDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}
