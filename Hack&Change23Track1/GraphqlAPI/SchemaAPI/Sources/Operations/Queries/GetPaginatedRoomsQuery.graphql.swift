// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetPaginatedRoomsQuery: GraphQLQuery {
  public static let operationName: String = "GetPaginatedRooms"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetPaginatedRooms($page: Int, $pageSize: Int) { GetPaginatedRooms(Page: $page, PageSize: $pageSize) { __typename Entries { __typename ...RoomAttrs } TotalPages } }"#,
      fragments: [RoomAttrs.self, MediaInfoAttrs.self, SourceAttrs.self]
    ))

  public var page: GraphQLNullable<Int>
  public var pageSize: GraphQLNullable<Int>

  public init(
    page: GraphQLNullable<Int>,
    pageSize: GraphQLNullable<Int>
  ) {
    self.page = page
    self.pageSize = pageSize
  }

  public var __variables: Variables? { [
    "page": page,
    "pageSize": pageSize
  ] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootQueryType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("GetPaginatedRooms", GetPaginatedRooms?.self, arguments: [
        "Page": .variable("page"),
        "PageSize": .variable("pageSize")
      ]),
    ] }

    public var getPaginatedRooms: GetPaginatedRooms? { __data["GetPaginatedRooms"] }

    public init(
      getPaginatedRooms: GetPaginatedRooms? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootQueryType.typename,
          "GetPaginatedRooms": getPaginatedRooms._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(GetPaginatedRoomsQuery.Data.self)
        ]
      ))
    }

    /// GetPaginatedRooms
    ///
    /// Parent Type: `PaginatedRooms`
    public struct GetPaginatedRooms: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.PaginatedRooms }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("Entries", [Entry?]?.self),
        .field("TotalPages", Int?.self),
      ] }

      public var entries: [Entry?]? { __data["Entries"] }
      public var totalPages: Int? { __data["TotalPages"] }

      public init(
        entries: [Entry?]? = nil,
        totalPages: Int? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.PaginatedRooms.typename,
            "Entries": entries._fieldData,
            "TotalPages": totalPages,
          ],
          fulfilledFragments: [
            ObjectIdentifier(GetPaginatedRoomsQuery.Data.GetPaginatedRooms.self)
          ]
        ))
      }

      /// GetPaginatedRooms.Entry
      ///
      /// Parent Type: `Room`
      public struct Entry: SchemaAPI.SelectionSet {
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
              ObjectIdentifier(GetPaginatedRoomsQuery.Data.GetPaginatedRooms.Entry.self),
              ObjectIdentifier(RoomAttrs.self)
            ]
          ))
        }

        /// GetPaginatedRooms.Entry.MediaInfo
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
                ObjectIdentifier(GetPaginatedRoomsQuery.Data.GetPaginatedRooms.Entry.MediaInfo.self),
                ObjectIdentifier(MediaInfoAttrs.self),
                ObjectIdentifier(RoomAttrs.MediaInfo.self)
              ]
            ))
          }

          /// GetPaginatedRooms.Entry.MediaInfo.Source
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
                  ObjectIdentifier(GetPaginatedRoomsQuery.Data.GetPaginatedRooms.Entry.MediaInfo.Source.self),
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
}
