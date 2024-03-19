//
//  EnterEntry.swift
//  BabyStat
//
//  Created by KeithC on 2023-06-23.
//

import SwiftUI

struct EnterEntry: View {
    
    // CoreData
    @Environment(\.managedObjectContext) private var viewContext

    // Var
    @Binding var isPresented: Bool
    @State var entryType: EntryType = .feeding
    @State var feedingType: FeedingType = .milk
    @State var diaperType: DiaperType = .wet
    @State var hygieneType: HygieneType = .shower
    @State var sleepType: SleepType = .awake
    @State var date: Date = Date()
    @State var value: Double = 0
    
    enum Mode: String {
        case add = "Add"
        case update = "Update"
    }
    private var mode: EnterEntry.Mode
    private var baby: CDBaby
    
    //Init
    init(mode: EnterEntry.Mode, baby: CDBaby, isPresented: Binding<Bool>) {
        self.mode = mode
        self.baby = baby
        _isPresented = isPresented
    }

    //View
    var body: some View {
        NavigationView {
                Form {
                    Section {
                        Picker("Type", selection: $entryType) {
                            ForEach(EntryType.allCases, id: \.self) { type in
                                Text(type.rawValue)
                            }
                        }
                        .onChange(of: entryType) { _ in
                            entryType == .feeding
                            ? resetValue()
                            : enableButton()
                        }
                    }
                    if entryType == .feeding {
                        Section {
                            Picker("Food type", selection: $feedingType) {
                                ForEach(FeedingType.allCases, id: \.self) { type in
                                    Text(type.rawValue).tag(type)
                                }
                            }
                            .pickerStyle(.segmented)
                            .onChange(of: feedingType) { _ in
                                resetValue()
                            }
                            Text("\(Int(value)) \(feedingType.unit)")
                                .font(.footnote)
                            HStack {
                                Text("0")
                                Slider(value: $value, in: 0...feedingType.maxValue,
                                       step: feedingType.step
                                )
                                Text("\(Int(feedingType.maxValue))")
                            }
                        }
                    } else if entryType == .diaper {
                        Section {
                            Picker("Diaper type", selection: $diaperType) {
                                ForEach(DiaperType.allCases, id: \.self) { type in
                                    Text(type.rawValue).tag(type)
                                }
                            }
                            .pickerStyle(.segmented)
                            .onChange(of: diaperType) { _ in
                                enableButton()
                            }
                        }
                    } else if entryType == .sleeping {
                        Section {
                            Picker("Sleep type", selection: $sleepType) {
                                ForEach(SleepType.allCases, id: \.self) { type in
                                    Text(type.rawValue).tag(type)
                                }
                            }
                            .pickerStyle(.segmented)
                            .onChange(of: sleepType) { _ in
                                enableButton()
                            }
                        }
                    } else if entryType == .hygiene {
                        Section {
                            Picker("Hygiene type", selection: $hygieneType) {
                                ForEach(HygieneType.allCases, id: \.self) { type in
                                    Text(type.rawValue).tag(type)
                                }
                            }
                            .pickerStyle(.segmented)
                            .onChange(of: hygieneType) { _ in
                                enableButton()
                            }
                        }
                    }
                    DatePicker("Time", selection: $date, displayedComponents:
                                [.date, .hourAndMinute]
                    )
            }
            .navigationTitle("\(mode.rawValue) Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button(action: enterEntry) {
                        Text("Add")
                    }
                    .disabled(value == 0)
                }
            }
        }
    }
    
    // Method
    private func enterEntry() {
        let subtypeString = getSubtypeString()
        CDEntry.createWith(type: entryType.rawValue, subtype: subtypeString,
                         timestamp: date, value: value, baby: baby,
                         using: viewContext)
        isPresented = false 
    }
    
    private func getSubtypeString() -> String {
        switch entryType {
        case .feeding:
            return feedingType.rawValue
        case .diaper:
            return diaperType.rawValue
        case .sleeping:
            return sleepType.rawValue
        case .hygiene:
            return hygieneType.rawValue
        }
    }
    
    private func resetValue() {
        value = 0
    }
    
    private func enableButton() {
        value = 1
    }
}
