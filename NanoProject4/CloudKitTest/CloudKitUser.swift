//
//  CloudKit.swift
//  NanoProject4
//
//  Created by Lucas Nascimento on 07/11/23.
//

import SwiftUI
import CloudKit

class CloudKitViewModel: ObservableObject{
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    
    init() {
        getiCloudStatus()
    }
    
    private func getiCloudStatus(){
        
        CKContainer.default().accountStatus { [weak self]returnedStatus, retornedError in
            DispatchQueue.main.async {
                switch returnedStatus {
                case .available:
                    self?.isSignedInToiCloud = true
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                default:
                    self?.error = CloudKitError.iCloudAccountUnknown.rawValue
                }
            }
        }
    }
    
    enum CloudKitError: String, LocalizedError{
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
}

struct CloudKitUser: View {
    
    @StateObject private var vm = CloudKitViewModel()
    
    var body: some View {
        Text("IS SIGNED IN: \(vm.isSignedInToiCloud.description.uppercased())")
        Text(vm.error)
    }
}

#Preview {
    CloudKitUser()
}
