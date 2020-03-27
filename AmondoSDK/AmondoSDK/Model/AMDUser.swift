//
//  AMDUser.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/27/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation

class AMDUser: NSObject, Codable {

    var username: String?
    var password: String?
    var token: String?
    var id: String?

    var email: String = ""
    var firstName: String?
    var lastName: String?
    var fullName: String?
    var refCode: String?
    var savedEvents: [String] = []
    var allEvents: [String]?
    var events_users: [String] = []
    var notifiedEvents: [String] = []
    var contributedEvents: [String] = []
    var profileImage: AMDFile?
    var photosPermitted = true
    var notificationsPermitted = true

    enum CodingKeys: String, CodingKey {
        case email
        case firstName
        case lastName
        case username
        case id
        case savedEvents
        case allEvents
        case events_users = "events_users"
        case notifiedEvents = "events_users_notified"
        case contributedEvents = "events_users_contributed"
        case photosPermitted = "cameraroll_permitted"
        case notificationsPermitted = "notifications_permitted"
        case profileImage = "profile_image"
    }

    convenience init(username: String, password: String) {
        self.init()
        self.username = username
        self.password = password
    }

    override init() {
        super.init()
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.email = try container.decode(String.self, forKey: .email)

        if let userName = try? container.decode(String.self, forKey: .username) {
            self.username = userName
        } else {
            self.username = self.email
        }

        self.username = self.email
        if let events = try? container.decode([AMDEventsUsers].self, forKey: .events_users) {
            self.events_users = events.map { "\($0.eventId)" }
        }

        let id = try container.decode(Int.self, forKey: .id)
        self.id = "\(id)"

        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)

        fullName = firstName! + " " + lastName!
        self.savedEvents = try container.decode([String].self, forKey: .savedEvents)
        self.allEvents = try container.decode([String].self, forKey: .allEvents)
        
        if let eventsLiked = try? container.decode([AMDEventsUsers].self, forKey: .events_users) {
            self.events_users = eventsLiked.map { "\($0.eventId)" }
        }

        if let eventsNotified = try? container.decode([AMDEventsUsers].self, forKey: .notifiedEvents) {
            self.notifiedEvents = eventsNotified.map { "\($0.eventId)" }
        }

        if let contributedEvents = try? container.decode([AMDEventsUsers].self, forKey: .contributedEvents) {
            self.contributedEvents = contributedEvents.map { "\($0.eventId)" }
        }

        if let photosPermitted = try? container.decode(Bool.self, forKey: .photosPermitted) {
            self.photosPermitted = photosPermitted
        }

        if let notificationsPermitted = try? container.decode(Bool.self, forKey: .notificationsPermitted) {
            self.notificationsPermitted = notificationsPermitted
        }

        if let profileImage = try? container.decode(AMDFile.self, forKey: .profileImage) {
            profileImage.type = AMDFileType(rawValue: "photo")
            self.profileImage = profileImage
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username, forKey: .username)
        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(savedEvents, forKey: .savedEvents)
        try container.encode(allEvents, forKey: .allEvents)

        let eventsUsers = events_users.map { id -> AMDEventsUsers in
            let eventUser = AMDEventsUsers(eventId: Int(id)!, userId: Int(self.id!)!)
            return eventUser
        }

        try container.encode(eventsUsers, forKey: .events_users)

        let notifiedEvents = self.notifiedEvents.map { id -> AMDEventsUsers in
            let eventUser = AMDEventsUsers(eventId: Int(id)!, userId: Int(self.id!)!)
            return eventUser
        }

        try container.encode(notifiedEvents, forKey: .notifiedEvents)

        let contributedEvents = self.contributedEvents.map { id -> AMDEventsUsers in
            let eventUser = AMDEventsUsers(eventId: Int(id)!, userId: Int(self.id!)!)
            return eventUser
        }

        try container.encode(contributedEvents, forKey: .contributedEvents)

        try container.encode(photosPermitted, forKey: .photosPermitted)
        if let image = profileImage {
            try container.encode(image, forKey: .profileImage)
        }

        try container.encode(notificationsPermitted, forKey: .notificationsPermitted)
    }

    var dictionary: [String: Any] {
        var root = [String: Any]()

        root[CodingKeys.email.rawValue] = self.email
        root[CodingKeys.firstName.rawValue] = self.firstName
        root[CodingKeys.lastName.rawValue] = self.lastName
        root[CodingKeys.username.rawValue] = self.username
        root[CodingKeys.id.rawValue] = self.id
        root[CodingKeys.savedEvents.rawValue] = self.savedEvents
        root[CodingKeys.allEvents.rawValue] = self.allEvents
        root[CodingKeys.events_users.rawValue] = self.events_users.map { eventId -> [String: Any] in
            let event = AMDEventsUsers(eventId: Int(eventId)!, userId: Int(self.id!)!)

            return event.dictionary
        }
        root[CodingKeys.notifiedEvents.rawValue] = self.notifiedEvents.map { eventId -> [String: Any] in
            let event = AMDEventsUsers(eventId: Int(eventId)!, userId: Int(self.id!)!)

            return event.dictionary
        }
        root[CodingKeys.contributedEvents.rawValue] = self.contributedEvents.map { eventId -> [String: Any] in
            let event = AMDEventsUsers(eventId: Int(eventId)!, userId: Int(self.id!)!)

            return event.dictionary
        }
        root[CodingKeys.photosPermitted.rawValue] = self.photosPermitted
        root[CodingKeys.notificationsPermitted.rawValue] = self.notificationsPermitted
        if let image = self.profileImage {
            root[CodingKeys.profileImage.rawValue] = image.dictionary
        }

        return root
    }
}
