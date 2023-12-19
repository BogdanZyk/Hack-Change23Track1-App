// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class UpdateRoomMutation: GraphQLMutation {
  static let operationName: String = "UpdateRoom"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateRoom($roomId: String!, $name: String!, $private: Boolean, $type: RoomType, $image: String) { UpdateRoom( RoomId: $roomId Name: $name Private: $private Type: $type Image: $image ) { __typename ...RoomAttrs } }"#,
      fragments: [RoomAttrs.self, MediaInfoAttrs.self, SourceAttrs.self]
    ))

  public var roomId: String
  public var name: String
  public var `private`: GraphQLNullable<Bool>
  public var type: GraphQLNullable<GraphQLEnum<SchemaAPI.RoomType>>
  public var image: GraphQLNullable<String>

  public init(
    roomId: String,
    name: String,
    `private`: GraphQLNullable<Bool>,
    type: GraphQLNullable<GraphQLEnum<SchemaAPI.RoomType>>,
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

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("UpdateRoom", UpdateRoom?.self, arguments: [
        "RoomId": .variable("roomId"),
        "Name": .variable("name"),
        "Private": .variable("private"),
        "Type": .variable("type"),
        "Image": .variable("image")
      ]),
    ] }

    var updateRoom: UpdateRoom? { __data["UpdateRoom"] }

    init(
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
    struct UpdateRoom: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Room }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(RoomAttrs.self),
      ] }

      var mediaInfo: MediaInfo? { __data["MediaInfo"] }
      var id: String? { __data["Id"] }
      var likes: Int? { __data["Likes"] }
      var `private`: Bool? { __data["Private"] }
      var image: String? { __data["Image"] }
      var key: String? { __data["Key"] }
      var name: String? { __data["Name"] }
      var owner: RoomAttrs.Owner? { __data["Owner"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var roomAttrs: RoomAttrs { _toFragment() }
      }

      init(
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
      struct MediaInfo: SchemaAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.MediaInfo }

        var currentTimeSeconds: Double? { __data["CurrentTimeSeconds"] }
        var durationSeconds: Double? { __data["DurationSeconds"] }
        var source: Source? { __data["Source"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var mediaInfoAttrs: MediaInfoAttrs { _toFragment() }
        }

        init(
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
        struct Source: SchemaAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }

          var id: String { __data["Id"] }
          var cover: String { __data["Cover"] }
          var name: String { __data["Name"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            var sourceAttrs: SourceAttrs { _toFragment() }
          }

          init(
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
