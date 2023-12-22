// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == SchemaAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == SchemaAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == SchemaAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == SchemaAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "RootMutationType": return SchemaAPI.Objects.RootMutationType
    case "Token": return SchemaAPI.Objects.Token
    case "RootQueryType": return SchemaAPI.Objects.RootQueryType
    case "User": return SchemaAPI.Objects.User
    case "PaginatedRooms": return SchemaAPI.Objects.PaginatedRooms
    case "Room": return SchemaAPI.Objects.Room
    case "MediaInfo": return SchemaAPI.Objects.MediaInfo
    case "Source": return SchemaAPI.Objects.Source
    case "PlaylistRow": return SchemaAPI.Objects.PlaylistRow
    case "RootSubscriptionType": return SchemaAPI.Objects.RootSubscriptionType
    case "InteractiveAction": return SchemaAPI.Objects.InteractiveAction
    case "Message": return SchemaAPI.Objects.Message
    case "ReactionMessage": return SchemaAPI.Objects.ReactionMessage
    case "ReplyMessage": return SchemaAPI.Objects.ReplyMessage
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
