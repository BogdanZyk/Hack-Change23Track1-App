// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SubscribeChatSubscription: GraphQLSubscription {
  public static let operationName: String = "SubscribeChat"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription SubscribeChat($roomId: String!) { SubscribeChat(RoomId: $roomId) { __typename Message { __typename ...MessageAttrs } RoomReaction } }"#,
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

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootSubscriptionType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("SubscribeChat", SubscribeChat?.self, arguments: ["RoomId": .variable("roomId")]),
    ] }

    public var subscribeChat: SubscribeChat? { __data["SubscribeChat"] }

    public init(
      subscribeChat: SubscribeChat? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootSubscriptionType.typename,
          "SubscribeChat": subscribeChat._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(SubscribeChatSubscription.Data.self)
        ]
      ))
    }

    /// SubscribeChat
    ///
    /// Parent Type: `InteractiveAction`
    public struct SubscribeChat: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.InteractiveAction }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("Message", [Message?]?.self),
        .field("RoomReaction", Int?.self),
      ] }

      public var message: [Message?]? { __data["Message"] }
      public var roomReaction: Int? { __data["RoomReaction"] }

      public init(
        message: [Message?]? = nil,
        roomReaction: Int? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.InteractiveAction.typename,
            "Message": message._fieldData,
            "RoomReaction": roomReaction,
          ],
          fulfilledFragments: [
            ObjectIdentifier(SubscribeChatSubscription.Data.SubscribeChat.self)
          ]
        ))
      }

      /// SubscribeChat.Message
      ///
      /// Parent Type: `Message`
      public struct Message: SchemaAPI.SelectionSet {
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
          type: GraphQLEnum<SchemaAPI.MessageType>? = nil
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
            ],
            fulfilledFragments: [
              ObjectIdentifier(SubscribeChatSubscription.Data.SubscribeChat.Message.self),
              ObjectIdentifier(MessageAttrs.self)
            ]
          ))
        }

        /// SubscribeChat.Message.From
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
                ObjectIdentifier(SubscribeChatSubscription.Data.SubscribeChat.Message.From.self),
                ObjectIdentifier(MessageUserAttrs.self),
                ObjectIdentifier(MessageAttrs.From.self)
              ]
            ))
          }
        }

        /// SubscribeChat.Message.Reaction
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
                ObjectIdentifier(SubscribeChatSubscription.Data.SubscribeChat.Message.Reaction.self),
                ObjectIdentifier(ReactionMessageAttrs.self),
                ObjectIdentifier(MessageAttrs.Reaction.self)
              ]
            ))
          }
        }

        /// SubscribeChat.Message.ReplyMessage
        ///
        /// Parent Type: `ReplyMessage`
        public struct ReplyMessage: SchemaAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.ReplyMessage }

          public var id: String? { __data["Id"] }
          public var text: String? { __data["Text"] }
          public var userName: String? { __data["UserName"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var replyMessageAttrs: ReplyMessageAttrs { _toFragment() }
          }

          public init(
            id: String? = nil,
            text: String? = nil,
            userName: String? = nil
          ) {
            self.init(_dataDict: DataDict(
              data: [
                "__typename": SchemaAPI.Objects.ReplyMessage.typename,
                "Id": id,
                "Text": text,
                "UserName": userName,
              ],
              fulfilledFragments: [
                ObjectIdentifier(SubscribeChatSubscription.Data.SubscribeChat.Message.ReplyMessage.self),
                ObjectIdentifier(ReplyMessageAttrs.self),
                ObjectIdentifier(MessageAttrs.ReplyMessage.self)
              ]
            ))
          }
        }
      }
    }
  }
}
