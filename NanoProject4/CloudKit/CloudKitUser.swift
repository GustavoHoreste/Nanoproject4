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
        
        CKContainer.default().accountStatus { returnedStatus, retornedError in
            DispatchQueue.main.async {
                switch returnedStatus {
                case .available:
                    break
                case .noAccount:
                    break
                case .couldNotDetermine:
                    break
                case .restricted:
                    break
                case .temporarilyUnavailable:
                    break
                default:
                    break
                }
            }
        }
    }
    
    enum CloudKitError: LocalizedError{
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
