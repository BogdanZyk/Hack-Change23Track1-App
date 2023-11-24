// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
import Hack&Change23Track1

class GetRoomByKeyQuery: GraphQLQuery {
  static let operationName: String = "GetRoomByKey"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetRoomByKey($key: String!) { GetRoomByKey(Key: $key) { __typename ...RoomAttrs } }"#,
      fragments: [RoomAttrs.self, PlayerItemAttrs.self, FileAttrs.self, UserAttrs.self]
    ))

  public var key: String

  public init(key: String) {
    self.key = key
  }

  public var __variables: Variables? { ["key": key] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootQueryType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("GetRoomByKey", GetRoomByKey?.self, arguments: ["Key": .variable("key")]),
    ] }

    var getRoomByKey: GetRoomByKey? { __data["GetRoomByKey"] }

    init(
      getRoomByKey: GetRoomByKey? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootQueryType.typename,
          "GetRoomByKey": getRoomByKey._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(GetRoomByKeyQuery.Data.self)
        ]
      ))
    }

    /// GetRoomByKey
    ///
    /// Parent Type: `Room`
    struct GetRoomByKey: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Room }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(RoomAttrs.self),
      ] }

      var file: File? { __data["File"] }
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
        file: File? = nil,
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
            "File": file._fieldData,
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
            ObjectIdentifier(GetRoomByKeyQuery.Data.GetRoomByKey.self),
            ObjectIdentifier(RoomAttrs.self)
          ]
        ))
      }

      /// GetRoomByKey.File
      ///
      /// Parent Type: `PlayFile`
      struct File: SchemaAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.PlayFile }

        var currentSeconds: String? { __data["CurrentSeconds"] }
        var durationSeconds: String? { __data["DurationSeconds"] }
        var file: File? { __data["File"] }
        var pause: Bool? { __data["Pause"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var playerItemAttrs: PlayerItemAttrs { _toFragment() }
        }

        init(
          currentSeconds: String? = nil,
          durationSeconds: String? = nil,
          file: File? = nil,
          pause: Bool? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.PlayFile.typename,
              "CurrentSeconds": currentSeconds,
              "DurationSeconds": durationSeconds,
              "File": file._fieldData,
              "Pause": pause,
            ],
            fulfilledFragments: [
              ObjectIdentifier(GetRoomByKeyQuery.Data.GetRoomByKey.File.self),
              ObjectIdentifier(PlayerItemAttrs.self),
              ObjectIdentifier(RoomAttrs.File.self)
            ]
          ))
        }

        /// GetRoomByKey.File.File
        ///
        /// Parent Type: `Audio`
        struct File: SchemaAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Audio }

          var id: String? { __data["Id"] }
          var name: String? { __data["Name"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            var fileAttrs: FileAttrs { _toFragment() }
          }

          init(
            id: String? = nil,
            name: String? = nil
          ) {
            self.init(_dataDict: DataDict(
              data: [
                "__typename": SchemaAPI.Objects.Audio.typename,
                "Id": id,
                "Name": name,
              ],
              fulfilledFragments: [
                ObjectIdentifier(GetRoomByKeyQuery.Data.GetRoomByKey.File.File.self),
                ObjectIdentifier(FileAttrs.self),
                ObjectIdentifier(PlayerItemAttrs.File.self)
              ]
            ))
          }
        }
      }

      /// GetRoomByKey.Member
      ///
      /// Parent Type: `User`
      struct Member: SchemaAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }

        var id: String { __data["Id"] }
        var login: String { __data["Login"] }
        var avatar: String { __data["Avatar"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var userAttrs: UserAttrs { _toFragment() }
        }

        init(
          id: String,
          login: String,
          avatar: String
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.User.typename,
              "Id": id,
              "Login": login,
              "Avatar": avatar,
            ],
            fulfilledFragments: [
              ObjectIdentifier(GetRoomByKeyQuery.Data.GetRoomByKey.Member.self),
              ObjectIdentifier(UserAttrs.self),
              ObjectIdentifier(RoomAttrs.Member.self)
            ]
          ))
        }
      }
    }
  }
}
