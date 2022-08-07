//
//  File.swift
//  LocoKit Demo
//
//  Created by Matt Greenfield on 4/8/22.
//

import Combine
import SwiftUI
import MapKit
import LocoKit

class Session: ObservableObject {

    static let highlander = Session()
    let recorder = TimelineRecorder(store: TimelineStore(), classifier: TimelineClassifier.highlander)
    var loco: LocomotionManager { return LocomotionManager.highlander }

    @Published var isRecording = false
    @Published var showTimelineItems = false
    @Published var showRawLocations = true
    @Published var showFilteredLocations = true
    @Published var showLocomotionSamples = true
    @Published var selectedSheetDetent: PresentationDetent = .height(220)

    var timelineSegment: TimelineSegment { didSet { addSegmentObserver() } }
    private var segmentObserver: AnyCancellable?

    // MARK: -

    init() {
        timelineSegment = recorder.store.segment(
            where: "deleted = 0 AND endDate > datetime('now','-24 hours') ORDER BY startDate DESC"
        )
        addSegmentObserver()
    }

    private func addSegmentObserver() {
        segmentObserver = timelineSegment.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }

    // MARK: -

    func startRecording() {
        loco.locationManager.requestWhenInUseAuthorization()
        recorder.startRecording()
        isRecording = recorder.isRecording

        timelineSegment = recorder.store.segment(
            where: "deleted = 0 AND endDate >= ? ORDER BY startDate DESC", arguments: [Date()]
        )
    }

    func stopRecording() {
        recorder.stopRecording()
        isRecording = recorder.isRecording
    }

}
