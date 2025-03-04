class BackendSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections

  use GraphQL::Subscriptions::ActionCableSubscriptions, redis: Redis.new(url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") )
  subscription(Types::SubscriptionType)
end
