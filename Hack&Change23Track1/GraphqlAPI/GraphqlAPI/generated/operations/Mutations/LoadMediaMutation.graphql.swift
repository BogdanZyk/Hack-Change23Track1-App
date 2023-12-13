// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class LoadMediaMutation: GraphQLMutation {
  static let operationName: String = "LoadMedia"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation LoadMedia($sourceId: String!, $roomId: String!) { LoadMedia(SourceId: $sourceId, RoomId: $roomId) { __typename ...RoomAttrs } }"#,
      fragments: [RoomAttrs.self, MediaInfoAttrs.self, UserAttrs.self]
    ))

  public var sourceId: String
  public var roomId: String

  public init(
    sourceId: String,
    roomId: String
  ) {
    self.sourceId = sourceId
    self.roomId = roomId
  }

  public var __variables: Variables? { [
    "sourceId": sourceId,
    "roomId": roomId
  ] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("LoadMedia", LoadMedia?.self, arguments: [
        "SourceId": .variable("sourceId"),
        "RoomId": .variable("roomId")
      ]),
    ] }

    var loadMedia: LoadMedia? { __data["LoadMedia"] }

    init(
      loadMedia: LoadMedia? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "LoadMedia": loadMedia._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(LoadMediaMutation.Data.self)
        ]
      ))
    }

    /// LoadMedia
    ///
    /// Parent Type: `Room`
    struct LoadMedia: SchemaAPI.SelectionSet {
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
      var members: [Member?]? { __data["Members"] }
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
        members: [Member?]? = nil,
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
            "Members": members._fieldData,
            "Owner": owner._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(LoadMediaMutation.Data.LoadMedia.self),
            ObjectIdentifier(RoomAttrs.self)
          ]
        ))
      }

      /// LoadMedia.MediaInfo
      ///
      /// Parent Type: `MediaInfo`
      struct MediaInfo: SchemaAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.MediaInfo }

        var currentSeconds: String? { __data["CurrentSeconds"] }
        var source: MediaInfoAttrs.Source? { __data["Source"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var mediaInfoAttrs: MediaInfoAttrs { _toFragment() }
        }

        init(
          currentSeconds: String? = nil,
          source: MediaInfoAttrs.Source? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.MediaInfo.typename,
              "CurrentSeconds": currentSeconds,
              "Source": source._fieldData,
            ],
            fulfilledFragments: [
              ObjectIdentifier(LoadMediaMutation.Data.LoadMedia.MediaInfo.self),
              ObjectIdentifier(MediaInfoAttrs.self),
              ObjectIdentifier(RoomAttrs.MediaInfo.self)
            ]
          ))
        }
      }

      /// LoadMedia.Member
      ///
      /// Parent Type: `User`
      struct Member: SchemaAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }

        var id: String { __data["Id"] }
        var login: String { __data["Login"] }
        var avatar: String { __data["Avatar"] }
        var email: String { __data["Email"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var userAttrs: UserAttrs { _toFragment() }
        }

        init(
          id: String,
          login: String,
          avatar: String,
          email: String
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.User.typename,
              "Id": id,
              "Login": login,
              "Avatar": avatar,
              "Email": email,
            ],
            fulfilledFragments: [
              ObjectIdentifier(LoadMediaMutation.Data.LoadMedia.Member.self),
              ObjectIdentifier(UserAttrs.self),
              ObjectIdentifier(RoomAttrs.Member.self)
            ]
          ))
        }
      }
    }
  }
}
