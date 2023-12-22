// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateRoomMutation: GraphQLMutation {
  public static let operationName: String = "UpdateRoom"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateRoom($roomId: String!, $name: String!, $private: Boolean, $type: RoomType, $image: String) { UpdateRoom( RoomId: $roomId Name: $name Private: $private Type: $type Image: $image ) { __typename ...RoomAttrs } }"#,
      fragments: [MediaInfoAttrs.self, RoomAttrs.self, SourceAttrs.self]
    ))

  public var roomId: String
  public var name: String
  public var `private`: GraphQLNullable<Bool>
  public var type: GraphQLNullable<GraphQLEnum<RoomType>>
  public var image: GraphQLNullable<String>

  public init(
    roomId: String,
    name: String,
    `private`: GraphQLNullable<Bool>,
    type: GraphQLNullable<GraphQLEnum<RoomType>>,
    image: GraphQLNullable<String>
  ) {
    self.roomId = roomId
    self.name = name
    self.`private` = `private`
    self.type = type
    self.image = image
  }

  public var __variables: Variables? { [
    "roomId": roomId,
    "name": name,
    "private": `private`,
    "type": type,
    "image": image
  ] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("UpdateRoom", UpdateRoom?.self, arguments: [
        "RoomId": .variable("roomId"),
        "Name": .variable("name"),
        "Private": .variable("private"),
        "Type": .variable("type"),
        "Image": .variable("image")
      ]),
    ] }

    public var updateRoom: UpdateRoom? { __data["UpdateRoom"] }

    public init(
      updateRoom: UpdateRoom? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "UpdateRoom": updateRoom._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(UpdateRoomMutation.Data.self)
        ]
      ))
    }

    /// UpdateRoom
    ///
    /// Parent Type: `Room`
    public struct UpdateRoom: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Room }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(RoomAttrs.self),
      ] }

      public var mediaInfo: MediaInfo? { __data["MediaInfo"] }
      public var id: String? { __data["Id"] }
      public var likes: Int? { __data["Likes"] }
      public var `private`: Bool? { __data["Private"] }
      public var image: String? { __data["Image"] }
      public var key: String? { __data["Key"] }
      public var name: String? { __data["Name"] }
      public var owner: RoomAttrs.Owner? { __data["Owner"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var roomAttrs: RoomAttrs { _toFragment() }
      }

      public init(
        mediaInfo: MediaInfo? = nil,
        id: String? = nil,
        likes: Int? = nil,
        `private`: Bool? = nil,
        image: String? = nil,
        key: String? = nil,
        name: String? = nil,
        owner: RoomAttrs.Owner? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.Room.typename,
            "MediaInfo": mediaInfo._fieldData,
            "Id": id,
            "Likes": likes,
            "Private": `private`,
            "Image": image,
            "Key": key,
            "Name": name,
            "Owner": owner._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(UpdateRoomMutation.Data.UpdateRoom.self),
            ObjectIdentifier(RoomAttrs.self)
          ]
        ))
      }

      /// UpdateRoom.MediaInfo
      ///
      /// Parent Type: `MediaInfo`
      public struct MediaInfo: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.MediaInfo }

        public var currentTimeSeconds: Double? { __data["CurrentTimeSeconds"] }
        public var durationSeconds: Double? { __data["DurationSeconds"] }
        public var source: Source? { __data["Source"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var mediaInfoAttrs: MediaInfoAttrs { _toFragment() }
        }

        public init(
          currentTimeSeconds: Double? = nil,
          durationSeconds: Double? = nil,
          source: Source? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.MediaInfo.typename,
              "CurrentTimeSeconds": currentTimeSeconds,
              "DurationSeconds": durationSeconds,
              "Source": source._fieldData,
            ],
            fulfilledFragments: [
              ObjectIdentifier(UpdateRoomMutation.Data.UpdateRoom.MediaInfo.self),
              ObjectIdentifier(MediaInfoAttrs.self),
              ObjectIdentifier(RoomAttrs.MediaInfo.self)
            ]
          ))
        }

        /// UpdateRoom.MediaInfo.Source
        ///
        /// Parent Type: `Source`
        public struct Source: SchemaAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }

          public var id: String { __data["Id"] }
          public var cover: String { __data["Cover"] }
          public var name: String { __data["Name"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var sourceAttrs: SourceAttrs { _toFragment() }
          }

          public init(
            id: String,
            cover: String,
            name: String
          ) {
            self.init(_dataDict: DataDict(
              data: [
                "__typename": SchemaAPI.Objects.Source.typename,
                "Id": id,
                "Cover": cover,
                "Name": name,
              ],
              fulfilledFragments: [
                ObjectIdentifier(UpdateRoomMutation.Data.UpdateRoom.MediaInfo.Source.self),
                ObjectIdentifier(SourceAttrs.self),
                ObjectIdentifier(MediaInfoAttrs.Source.self)
              ]
            ))
          }
        }
      }
    }
  }
}
