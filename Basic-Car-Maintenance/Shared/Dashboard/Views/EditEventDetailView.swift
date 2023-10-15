//
//  EditMaintenanceEventView.swift
//  Basic-Car-Maintenance
//
//  Created by Aaron Wilson on 10/5/23.
//

import SwiftUI

struct EditMaintenanceEventView: View {
    @Binding var selectedEvent: MaintenanceEvent?
    var viewModel: DashboardViewModel
    @State private var title = ""
    @State private var date = Date()
    @State private var selectedVehicle: Vehicle?
    @State private var notes = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                } header: {
                    Text("Title")
                }
                
                Section {
                    Picker(selection: $selectedVehicle) {
                        ForEach(viewModel.vehicles) { vehicle in
                            Text(vehicle.name).tag(vehicle as Vehicle)
                        }
                    } label: {
                        Text("Select a vehicle",
                             comment: "Maintenance event vehicle picker label")
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("Vehicle",
                         comment: "Maintenance event vehicle picker header")
                }
                
                DatePicker(selection: $date, displayedComponents: .date) {
                    Text("Date")
                }
                
                Section {
                    TextField("Notes", text: $notes, prompt: Text("Additional Notes"), axis: .vertical)
                } header: {
                    Text("Notes")
                }
            }
            .onAppear {
                guard let selectedEvent = selectedEvent else { return }
                setMaintenanceEventValues(event: selectedEvent)
            }
            .navigationTitle(Text("Update Maintenance"))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
<<<<<<< HEAD
                        var event = MaintenanceEvent(title: title, date: date, notes: notes)
                        guard let selectedEvent = selectedEvent else { return }
                        event.id = selectedEvent.id
                        Task {
                            await viewModel.updateEvent(event)
                            dismiss()
                            // Log the maintenance updated event to Firebase Analytics
                            AnalyticsManager.shared.logEvent(.maintenanceEventUpdated,
                                parameters: ["analyticsView": AnalyticsView.editEventDetailView])
=======
                        if let selectedVehicle, let selectedEvent {
                            var event = MaintenanceEvent(title: title,
                                                         date: date,
                                                         notes: notes,
                                                         vehicle: selectedVehicle)
                            event.id = selectedEvent.id
                            Task {
                                await viewModel.updateEvent(event)
                                dismiss()
                            }
>>>>>>> 35bb98e0259833f80d4b028253b6aea474461f12
                        }
                    } label: {
                        Text("Update")
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    func setMaintenanceEventValues(event: MaintenanceEvent) {
        self.title = event.title
        self.date = event.date
        self.notes = event.notes
        self.selectedVehicle = event.vehicle
    }
}

#Preview {
    EditMaintenanceEventView(selectedEvent:
            .constant(MaintenanceEvent(title: "", date: Date(), notes: "",
                                       vehicle: Vehicle(name: "", make: "", model: ""))),
                             viewModel:
                                DashboardViewModel(authenticationViewModel: AuthenticationViewModel())
    )
}
