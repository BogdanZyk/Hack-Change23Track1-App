// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetMessagesQuery: GraphQLQuery {
  public static let operationName: String = "GetMessages"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetMessages($roomId: String!) { GetMessages(RoomId: $roomId) { __typename ...MessageAttrs } }"#,
      fragments: [MessageAttrs.self, MessageUserAttrs.self, ReactionMessageAttrs.self, ReplyMessageAttrs.self]
    ))

  public var roomId: String

  public init(roomId: String) {
    self.roomId = roomId
  }

  public var __variables: Variables? { ["roomId": roomId] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootQueryType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("GetMessages", [GetMessage?]?.self, arguments: ["RoomId": .variable("roomId")]),
    ] }

    public var getMessages: [GetMessage?]? { __data["GetMessages"] }

    public init(
      getMessages: [GetMessage?]? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootQueryType.typename,
          "GetMessages": getMessages._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(GetMessagesQuery.Data.self)
        ]
      ))
    }

    /// GetMessage
    ///
    /// Parent Type: `Message`
    public struct GetMessage: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Message }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(MessageAttrs.self),
      ] }

      public var from: From? { __data["From"] }
      public var id: String? { __data["Id"] }
      public var reactions: [Reaction?]? { __data["Reactions"] }
      public var replyMessage: ReplyMessage? { __data["ReplyMessage"] }
      public var text: String? { __data["Text"] }
      public var type: GraphQLEnum<SchemaAPI.MessageType>? { __data["Type"] }
      public var insertedAt: SchemaAPI.DateTime? { __data["InsertedAt"] }
      public var updatedAt: SchemaAPI.DateTime? { __data["UpdatedAt"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var messageAttrs: MessageAttrs { _toFragment() }
      }

      public init(
        from: From? = nil,
        id: String? = nil,
        reactions: [Reaction?]? = nil,
        replyMessage: ReplyMessage? = nil,
        text: String? = nil,
        type: GraphQLEnum<SchemaAPI.MessageType>? = nil,
        insertedAt: SchemaAPI.DateTime? = nil,
        updatedAt: SchemaAPI.DateTime? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.Message.typename,
            "From": from._fieldData,
            "Id": id,
            "Reactions": reactions._fieldData,
            "ReplyMessage": replyMessage._fieldData,
            "Text": text,
            "Type": type,
            "InsertedAt": insertedAt,
            "UpdatedAt": updatedAt,
          ],
          fulfilledFragments: [
            ObjectIdentifier(GetMessagesQuery.Data.GetMessage.self),
            ObjectIdentifier(MessageAttrs.self)
          ]
        ))
      }

      /// GetMessage.From
      ///
      /// Parent Type: `User`
      public struct From: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }

        public var avatar: String? { __data["Avatar"] }
        public var id: String? { __data["Id"] }
        public var login: String? { __data["Login"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var messageUserAttrs: MessageUserAttrs { _toFragment() }
        }

        public init(
          avatar: String? = nil,
          id: String? = nil,
          login: String? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.User.typename,
              "Avatar": avatar,
              "Id": id,
              "Login": login,
            ],
            fulfilledFragments: [
              ObjectIdentifier(GetMessagesQuery.Data.GetMessage.From.self),
              ObjectIdentifier(MessageUserAttrs.self),
              ObjectIdentifier(MessageAttrs.From.self)
            ]
          ))
        }
      }

      /// GetMessage.Reaction
      ///
      /// Parent Type: `ReactionMessage`
      public struct Reaction: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.ReactionMessage }

        public var reaction: String? { __data["Reaction"] }
        public var from: ReactionMessageAttrs.From? { __data["From"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var reactionMessageAttrs: ReactionMessageAttrs { _toFragment() }
        }

        public init(
          reaction: String? = nil,
          from: ReactionMessageAttrs.From? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.ReactionMessage.typename,
              "Reaction": reaction,
              "From": from._fieldData,
            ],
            fulfilledFragments: [
              ObjectIdentifier(GetMessagesQuery.Data.GetMessage.Reaction.self),
              ObjectIdentifier(ReactionMessageAttrs.self),
              ObjectIdentifier(MessageAttrs.Reaction.self)
            ]
          ))
        }
      }

      /// GetMessage.ReplyMessage
      ///
      /// Parent Type: `ReplyMessage`
      public struct ReplyMessage: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.ReplyMessage }

        public var from: From? { __data["From"] }
        public var id: String? { __data["Id"] }
        public var text: String? { __data["Text"] }
        public var type: GraphQLEnum<SchemaAPI.MessageType>? { __data["Type"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var replyMessageAttrs: ReplyMessageAttrs { _toFragment() }
        }

        public init(
          from: From? = nil,
          id: String? = nil,
          text: String? = nil,
          type: GraphQLEnum<SchemaAPI.MessageType>? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.ReplyMessage.typename,
              "From": from._fieldData,
              "Id": id,
              "Text": text,
              "Type": type,
            ],
            fulfilledFragments: [
              ObjectIdentifier(GetMessagesQuery.Data.GetMessage.ReplyMessage.self),
              ObjectIdentifier(ReplyMessageAttrs.self),
              ObjectIdentifier(MessageAttrs.ReplyMessage.self)
            ]
          ))
        }

        /// GetMessage.ReplyMessage.From
        ///
        /// Parent Type: `User`
        public struct From: SchemaAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }

          public var avatar: String? { __data["Avatar"] }
          public var id: String? { __data["Id"] }
          public var login: String? { __data["Login"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var messageUserAttrs: MessageUserAttrs { _toFragment() }
          }

          public init(
            avatar: String? = nil,
            id: String? = nil,
            login: String? = nil
          ) {
            self.init(_dataDict: DataDict(
              data: [
                "__typename": SchemaAPI.Objects.User.typename,
                "Avatar": avatar,
                "Id": id,
                "Login": login,
              ],
              fulfilledFragments: [
                ObjectIdentifier(GetMessagesQuery.Data.GetMessage.ReplyMessage.From.self),
                ObjectIdentifier(MessageUserAttrs.self),
                ObjectIdentifier(ReplyMessageAttrs.From.self)
              ]
            ))
          }
        }
      }
    }
  }
}
