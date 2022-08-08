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

    var body: some View {
        ZStack {
            MapView().edgesIgnoringSafeArea([.top, .bottom])
            ZStack {
                Button {
                    session.sheetVisible = true
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
        .sheet(isPresented: $session.sheetVisible) {
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

                if session.selectedSheetDetent != session.sheetDetents.first {
                    Divider()
                    settingsBox.padding(20)

                    if session.selectedSheetDetent != session.sheetDetents.second {
                        Divider()
                    }
                }
                Spacer()
            }
            .presentationDetents(Set(session.sheetDetents), selection: $session.selectedSheetDetent)
        }
    }

    var settingsBox: some View {
        Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 12) {
            GridRow {
                dot(color: .blue)
                    .overlay(
                        dot(color: Color(uiColor: .systemGreen))
                            .offset(x: 8)
                    )
                Toggle(isOn: $session.showMovingStateDebug) {
                    Text("MovingState").fixedSize()
                }
                .disabled(session.showTimelineItems)
            }
            GridRow {
                dot(color: .blue)
                    .overlay(
                        dot(color: Color(uiColor: .systemGreen))
                            .offset(x: 8)
                    )
                Toggle(isOn: $session.showLocomotionSamples) {
                    Text("LocomotionSamples").fixedSize()
                }
                .disabled(session.showTimelineItems)
            }
            GridRow {
                dot(color: .purple)
                Toggle(isOn: $session.showFilteredLocations) {
                    Text("Filtered CLLocations").fixedSize()
                }
                .disabled(session.showTimelineItems)
            }
            GridRow {
                dot(color: .red)
                Toggle(isOn: $session.showRawLocations) {
                    Text("Raw CLLocations").fixedSize()
                }
                .disabled(session.showTimelineItems)
            }
            GridRow {
                dot(color: .orange)
                    .overlay(
                        dot(color: .brown).offset(x: 8)
                    )
                Toggle(isOn: $session.showTimelineItems) {
                    Text("TimelineItems").fixedSize()
                }
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
