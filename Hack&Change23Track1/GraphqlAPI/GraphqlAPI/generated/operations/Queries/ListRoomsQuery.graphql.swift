// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class ListRoomsQuery: GraphQLQuery {
  static let operationName: String = "ListRooms"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query ListRooms { ListRooms { __typename ...RoomAttrs } }"#,
      fragments: [RoomAttrs.self, MediaInfoAttrs.self, SourceAttrs.self, UserAttrs.self]
    ))

  public init() {}

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootQueryType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("ListRooms", [ListRoom?]?.self),
    ] }

    var listRooms: [ListRoom?]? { __data["ListRooms"] }

    init(
      listRooms: [ListRoom?]? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootQueryType.typename,
          "ListRooms": listRooms._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(ListRoomsQuery.Data.self)
        ]
      ))
    }

    /// ListRoom
    ///
    /// Parent Type: `Room`
    struct ListRoom: SchemaAPI.SelectionSet {
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
            ObjectIdentifier(ListRoomsQuery.Data.ListRoom.self),
            ObjectIdentifier(RoomAttrs.self)
          ]
        ))
      }

      /// ListRoom.MediaInfo
      ///
      /// Parent Type: `MediaInfo`
      struct MediaInfo: SchemaAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.MediaInfo }

        var currentSeconds: String? { __data["CurrentSeconds"] }
        var pause: Bool? { __data["Pause"] }
        var source: Source? { __data["Source"] }
        var url: String? { __data["Url"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var mediaInfoAttrs: MediaInfoAttrs { _toFragment() }
        }

        init(
          currentSeconds: String? = nil,
          pause: Bool? = nil,
          source: Source? = nil,
          url: String? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.MediaInfo.typename,
              "CurrentSeconds": currentSeconds,
              "Pause": pause,
              "Source": source._fieldData,
              "Url": url,
            ],
            fulfilledFragments: [
              ObjectIdentifier(ListRoomsQuery.Data.ListRoom.MediaInfo.self),
              ObjectIdentifier(MediaInfoAttrs.self),
              ObjectIdentifier(RoomAttrs.MediaInfo.self)
            ]
          ))
        }

        /// ListRoom.MediaInfo.Source
        ///
        /// Parent Type: `Source`
        struct Source: SchemaAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }

          var name: String? { __data["Name"] }
          var id: String? { __data["Id"] }
          var cover: String? { __data["Cover"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            var sourceAttrs: SourceAttrs { _toFragment() }
          }

          init(
            name: String? = nil,
            id: String? = nil,
            cover: String? = nil
          ) {
            self.init(_dataDict: DataDict(
              data: [
                "__typename": SchemaAPI.Objects.Source.typename,
                "Name": name,
                "Id": id,
                "Cover": cover,
              ],
              fulfilledFragments: [
                ObjectIdentifier(ListRoomsQuery.Data.ListRoom.MediaInfo.Source.self),
                ObjectIdentifier(SourceAttrs.self),
                ObjectIdentifier(MediaInfoAttrs.Source.self)
              ]
            ))
          }
        }
      }

      /// ListRoom.Member
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
              ObjectIdentifier(ListRoomsQuery.Data.ListRoom.Member.self),
              ObjectIdentifier(UserAttrs.self),
              ObjectIdentifier(RoomAttrs.Member.self)
            ]
          ))
        }
      }
    }
  }
}
