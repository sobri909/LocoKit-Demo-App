//
//  RootView.swift
//  LocoKit Demo
//
//  Created by Matt Greenfield on 4/8/22.
//

import SwiftUI
import MapKit
import LocoKit

struct RootView: View {

    @EnvironmentObject var session: Session
    @State var sheetVisible = true

    var sheetDetents: Array<PresentationDetent> = [.height(100), .height(220), .medium, .large]

    var body: some View {
        ZStack {
            MapView().edgesIgnoringSafeArea([.top, .bottom])
            ZStack {
                Button {
                    sheetVisible = true
                } label: {
                    Image(systemName: "arrow.up")
                        .imageScale(.large)
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(.borderedProminent).controlSize(.large)
                .padding(20)
                .alignBottom()
            }
        }
        .sheet(isPresented: $sheetVisible) {
            VStack(spacing: 0) {
                Button {
                    tappedStartStop()
                } label: {
                    Text(session.isRecording ? "Stop recording" : "Start recording")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent).controlSize(.large)
                .tint(session.isRecording ? .red : .blue)
                .padding(20)

                if session.selectedSheetDetent != sheetDetents.first {
                    Divider()
                    settingsBox.padding(20)

                    if session.selectedSheetDetent != sheetDetents.second {
                        Divider()
                    }
                }
                Spacer()
            }
            .presentationDetents(Set(sheetDetents), selection: $session.selectedSheetDetent)
        }
    }

    var settingsBox: some View {
        Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 10) {
            GridRow {
                dot(color: .brown)
                    .overlay(
                        dot(color: .orange).offset(x: 8)
                    )
                Toggle(isOn: $session.showTimelineItems) {
                    Text("Timeline").fixedSize()
                }

                dot(color: .purple)
                    .padding(.leading, 10)
                Toggle(isOn: $session.showFilteredLocations) {
                    Text("Filtered").fixedSize()
                }
                .disabled(session.showTimelineItems)
            }
            GridRow {
                dot(color: .blue)
                    .overlay(
                        dot(color: Color(uiColor: .magenta))
                            .offset(x: 8)
                    )
                Toggle(isOn: $session.showLocomotionSamples) {
                    Text("Samples").fixedSize()
                }
                .disabled(session.showTimelineItems)

                dot(color: .red)
                    .padding(.leading, 10)
                Toggle(isOn: $session.showRawLocations) {
                    Text("Raw").fixedSize()
                }
                .disabled(session.showTimelineItems)
            }
        }
    }

    func dot(color fillColor: Color) -> some View {
        return Circle()
            .strokeBorder(Color(uiColor: .systemBackground), lineWidth: 2)
            .background(Circle().fill(fillColor).frame(width: 14))
            .frame(width: 16, height: 16)
    }

    // MARK: - Actions

    func tappedStartStop() {
        if session.isRecording {
            session.stopRecording()
        } else {
            session.startRecording()
        }
    }

}
