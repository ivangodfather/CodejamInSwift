//
//  main.swift
//  ParentingPartnering
//
//  Created by Ivan Ruiz Monjo on 27/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

struct Job {
    let time: ClosedRange<Int>
    let isCameron: Bool

    var duration: Int { return time.upperBound - time.lowerBound }
}

func readSchedules() -> [Job] {
    let both = readLine()!.split(separator: " ").map { Int($0)! }
    let cameron = both[0]
    let jamie = both[1]
    var cameronJobs = [Job]()
    var jamieJobs = [Job]()
    for _ in 0..<cameron {
        let bounds = readLine()!.split(separator: " ").map { Int($0)! }
        cameronJobs.append(Job(time: bounds[0]...bounds[1], isCameron: true))
    }
    for _ in 0..<jamie {
        let bounds = readLine()!.split(separator: " ").map { Int($0)! }
        jamieJobs.append(Job(time: bounds[0]...bounds[1], isCameron: false))
    }

    return (cameronJobs + jamieJobs).sorted { $0.time.lowerBound < $1.time.upperBound }
}

func totalTimeBusy(shchedule: [ClosedRange<Int>]) -> Int {
    var time = 0
    for activity in shchedule {
        time += activity.upperBound - activity.lowerBound
    }
    return time
}

func solve(caseNumber: Int) {
    let schedule = readSchedules()
    var cameronFreeTime = 720
    var jamieFreeTime = 720

    schedule.forEach { job in
        if job.isCameron {
            jamieFreeTime -= job.time.upperBound - job.time.lowerBound
        } else {
            cameronFreeTime -= job.time.upperBound - job.time.lowerBound
        }
    }

    var alternate = 0
    var gapsJamie = [Job]()
    var gapsCameron = [Job]()
    if schedule.count > 1 {
        for i in 1...schedule.count - 1 {
            if schedule[i].isCameron == schedule[i - 1].isCameron {
                if schedule[i].isCameron {
                    gapsJamie.append(Job(time: schedule[i - 1].time.upperBound...schedule[i].time.lowerBound, isCameron: false))
                } else {
                    gapsCameron.append(Job(time: schedule[i - 1].time.upperBound...schedule[i].time.lowerBound, isCameron: false))
                }
            } else {
                alternate += 1
            }
        }
    }
    var pendingGaps = [Job]()
    for i in 0..<gapsJamie.count {
        let gap = gapsJamie[i]
        if gap.duration <= jamieFreeTime {
            jamieFreeTime -= gap.duration
        } else {
            pendingGaps.append(gap)
        }
    }
    for i in 0..<gapsCameron.count {
        let gap = gapsCameron[i]
        if gap.duration <= cameronFreeTime {
            cameronFreeTime -= gap.duration
        } else {
            pendingGaps.append(gap)
        }
    }

    if let first = schedule.first, let last = schedule.last {
        let duration = (1440 - last.time.upperBound) + first.time.lowerBound
        if first.isCameron == last.isCameron && first.isCameron == true {
            if duration > jamieFreeTime {
                alternate += 2
            }
        }
        if first.isCameron == last.isCameron && first.isCameron == false {
            if duration > cameronFreeTime {
                alternate += 2
            }
        }
        if first.isCameron != last.isCameron {
            alternate += 1
        }
    }
    print("Case #\(caseNumber): \(alternate + 2 * pendingGaps.count)")
}



for caseNumber in 1...Int(readLine()!)! {
    solve(caseNumber: caseNumber)
}
