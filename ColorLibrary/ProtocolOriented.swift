//
//  ProtocolOriented.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 11/05/2023.
//

import Foundation
import SwiftUI

// MARK: - Trackable

protocol Trackable {
    var action: String { get }
    
    func trackView()
    func trackAction()
}

extension Trackable {
    func trackView() { }
    func trackAction() { }
}

// MARK: - ScreenAlertAction

protocol ScreenAlertAction: Identifiable {
    var localizedTitle: String { get }
}

// MARK: - ScreenViewModel

protocol ScreenViewModel: ObservableObject {
    associatedtype AlertAction: ScreenAlertAction
    
    var state: Int { get set }
    var alertActions: [AlertAction] { get }
    var alertMessage: String { get }
    
    func alertAction(for action: AlertAction)
}

// MARK: - Screen

protocol Screen: View {
    associatedtype ViewModel: ScreenViewModel
    
    var viewModel: ViewModel { get }
}

// MARK: - ScreenView

struct ScreenView<Content>: View where Content : Screen {
    let screen: Content
    let onAppear: () -> Void
    @ObservedObject private var viewModel: Content.ViewModel
    
    init(_ screen: Content) {
        self.screen = screen
        self.onAppear = {}
        self.viewModel = screen.viewModel
    }
    
    init(_ screen: Content) where Content : Trackable {
        self.screen = screen
        self.onAppear = { screen.trackAction() }
        self.viewModel = screen.viewModel
    }
    
    private var viewModelStateBinding: Binding<Bool> {
        Binding(get: { viewModel.state == 0 },
                set: { viewModel.state = $0 ? 0 : 1 })
    }
    
    var body: some View {
        ZStack {
            if screen.viewModel.state == 0 {
                screen.body
                    .onAppear(perform: onAppear)
                    .alert("Alert", isPresented: viewModelStateBinding) {
                        ForEach(viewModel.alertActions) { action in
                            Button {
                                viewModel.alertAction(for: action)
                            } label: {
                                Text(action.localizedTitle)
                            }
                        }
                    } message: {
                        Text(viewModel.alertMessage)
                    }
                
            } else {
                Text("Waiting")
            }
        }
    }
}

// MARK: - Implementation

// MARK: Settings

enum Alert: ScreenAlertAction {
    case ok, cancel
    
    var id: Alert { self }
    
    var localizedTitle: String {
        String(describing: self)
    }
}

final class SettingsViewModel: ObservableObject, ScreenViewModel {
    var state: Int = 0
    
    var alertMessage: String = "Un truc"
    
    var alertActions: [Alert] {
        [.cancel]
    }
    
    func alertAction(for action: Alert) {
        print(action)
    }
}

struct SettingsScreen: Screen, Trackable {
    var action: String = "Settings"
    
    let viewModel = SettingsViewModel()
    
    var body: some View {
        Text("Settings")
    }
}

// MARK: Login

final class LogginViewModel: ObservableObject, ScreenViewModel {
    enum Alert: ScreenAlertAction {
        case ok, cancel
        
        var id: Alert { self }
        
        var localizedTitle: String {
            String(describing: self)
        }
    }
    
    var state: Int = 0
    
    var alertMessage: String = "Un truc"
    
    var alertActions: [LogginViewModel.Alert] {
        [.cancel]
    }
    
    func alertAction(for action: Alert) {
        print(action)
    }
}

struct LoginScreen: Screen {
    let viewModel = LogginViewModel()
    
    var body: some View {
        Text("Login")
    }
}
